// *****************************
// SPL_PickLock
// Largely inspired by https://forum.worldofplayers.de/forum/threads/?p=12237820
// *****************************

// Constants.d (adjusted during initialization)
const int SPL_FMKPickLock       = 0;

const int SPL_Cost_FMKPickLock  = 5;    // Mana cost per lock tick
const int SPL_Time_FMKPickLock  = 1500; // MS per lock tick (not per mana!)

const int TARGET_TYPE_MOB       = 128;  // Technically invalid (see below)

instance Spell_FMKPickLock (C_Spell_Proto) {
    time_per_mana               = castFromIntf(fracf(SPL_Time_FMKPickLock, SPL_Cost_FMKPickLock));  // Do not change
    spelltype                   = SPELL_NEUTRAL;
    targetCollectAlgo           = TARGET_COLLECT_FOCUS;
    targetCollectType           = TARGET_TYPE_MOB;
    targetCollectRange          = 550;
    canTurnDuringInvest         = TRUE;
    canChangeTargetDuringInvest = FALSE;
    if (GOTHIC_BASE_VERSION == 2) {
        // Gothic 2 does not allow canTurnDuringInvest for non-NPC focus, so we'll restrict the azimuth instead
        targetCollectAzi        = 20;
    };
};


/*
 * Sugar
 */
func void Spell_FMKPickLock_ClearKeyBuffer() {
    const int zCInput_Win32__ClearKeyBuffer_G1 = 5016288; //0x4C8AE0
    const int zCInput_Win32__ClearKeyBuffer_G2 = 5068240; //0x4D55D0
    const int call = 0;
    if (CALL_Begin(call)) {
        CALL__thiscall(zCInput_zinput, MEMINT_SwitchG1G2(zCInput_Win32__ClearKeyBuffer_G1,
                                                         zCInput_Win32__ClearKeyBuffer_G2));
        call = CALL_End();
    };
};


/*
 * Modified from https://forum.worldofplayers.de/forum/threads/?p=12237820
 */
func int Spell_Logic_FMKPickLock(var int manaInvested) {
    var oCNpc slf; slf = Hlp_GetNpc(self);
    var oCMobLockable mob;

    if (Npc_GetActiveSpellLevel(self) <= MEMINT_SwitchG1G2(2, 1)) { // Gothic 1 needs one level more for starting the FX
        if (!Hlp_Is_oCMobLockable(slf.focus_vob)) {
            return SPL_SENDSTOP;
        };

        mob = _^(slf.focus_vob);

        if (!(mob.bitfield & oCMobLockable_bitfield_locked)) {
            return SPL_SENDSTOP;
        };

        if (Hlp_StrCmp(mob.pickLockStr, "")) {
            Print(Ninja_FirstMageKit_PRINT_NeverOpen);
            Spell_FMKPickLock_ClearKeyBuffer();
            return SPL_SENDSTOP;
        };

        if (self.attribute[ATR_MANA] < SPL_Cost_FMKPickLock) {
            return SPL_SENDSTOP;
        };

        // Change in FX
        return SPL_NEXTLEVEL;

    } else if (!(manaInvested % SPL_Cost_FMKPickLock)) {
        mob = _^(slf.focus_vob);

        //Für die Wahrnehmung so tun, als würde der Spieler das Mob benutzen
        slf.interactMob = slf.focus_vob;
        //Die anderen Npcs informieren:
        Npc_SendPassivePerc(self, PERC_ASSESSUSEMOB, self, self);
        //gegen Kamera zucken sofort wieder auf 0 setzen
        slf.interactMob = 0;

        //Länge des "RLRLRR"-Strings insgesamt:
        var int totalCharCount; totalCharCount = STR_Len(mob.pickLockStr);
        //davon schon aufgeschlossen:
        var int currCharCount; currCharCount = (mob.bitfield & oCMobLockable_bitfield_pickLockNr) >> 2;

        //jetzt einer mehr
        currCharCount += 1;

        //alten Wert im Bitfeld löschen, neuen reinschreiben:
        mob.bitfield = mob.bitfield & ~oCMobLockable_bitfield_pickLockNr;
        mob.bitfield = mob.bitfield | (currCharCount << 2);

        //Ists jetzt offen?
        if (currCharCount >= totalCharCount) {
            //gegebenenfalls entriegen
            mob.bitfield = mob.bitfield &~ oCMobLockable_bitfield_locked;
            Print(Ninja_FirstMageKit_PRINT_PICKLOCK_UNLOCK);
            Snd_Play3D(self, "PICKLOCK_SUCCESS");

            // No handouts! SPL_SENDCAST does not decrease the mana
            if (GOTHIC_BASE_VERSION == 2) {
                self.attribute[ATR_MANA] -= 1;
            };

            // Prevent the player from running forward after casting
            Spell_FMKPickLock_ClearKeyBuffer();
            return SPL_SENDCAST;
        };

        //immerhin einen Schritt weiter
        Snd_Play3D(self, "PICKLOCK_SUCCESS");

        // Vary the timing
        var int timestep;
        timestep = roundf(fracf(SPL_Time_FMKPickLock, SPL_Cost_FMKPickLock)); // Divide total time by mana needed
        timestep = Hlp_Random(timestep) + /*minimum*/80;                      // Create oscillations
        Spell_FMKPickLock.time_per_mana = castFromIntf(mkf(timestep));        // Cast to Daedalus float
    };

    return SPL_RECEIVEINVEST;
};
func int Spell_Cast_FMKPickLock() {};


/*
 * Enable focusing mob when using the spell
 */
func void Spell_FMKPickLock_Prio() {
    var int caster; caster = MEM_ReadInt(ESP+4);
    if (!caster) {
        return;
    };
    var C_Npc slf; slf = _^(caster);
    if (!Npc_IsPlayer(slf)) {
        return;
    };

    const int mob_prio_backup = 42; // 42 == not initialized yet
    if (mob_prio_backup == 42) {
        mob_prio_backup = Focus_Magic.mob_prio;
    };

    var int spellID; spellID = MEM_ReadInt(/*oCSpell*/ECX+/*spellID*/84);
    if (spellID == SPL_FMKPickLock) {
        // Adjust the global(!) focus priorities temporarily(!)
        Focus_Magic.mob_prio = 1;
    } else if (mob_prio_backup != 42) {
        // Reset the focus priorities for all other spells!
        Focus_Magic.mob_prio = mob_prio_backup;
    };
};


/*
 * Make the focus check mob specific (disallow NPC)
 */
func void Spell_FMKPickLock_Focus() {
    // Constructed case that will only happen for Spell_FMKPickLock
    if (ECX == TARGET_TYPE_MOB) {
        var int vobPtr; vobPtr = MEM_ReadInt(ESP+4);
        if (Hlp_Is_oCMobLockable(vobPtr)) {
            var oCMobLockable mob; mob = _^(vobPtr);
            if (mob.bitfield & oCMobLockable_bitfield_locked) {
                ECX = 1;
            };
        };
    };
};


/*
 * Initialize the focus tweaks
 */
func void Spell_FMKPickLock_Init() {
    const int oCSpell__IsTargetTypeValid_G1    = 4709316; //0x47DBC4
    const int oCSpell__IsTargetTypeValid_G2    = 4743108; //0x485FC4
    const int oCSpell__Setup_G1                = 4703664; //0x47C5B0
    const int oCSpell__Setup_G2                = 4737328; //0x484930
    HookEngineF(+MEMINT_SwitchG1G2(oCSpell__IsTargetTypeValid_G1,
                                   oCSpell__IsTargetTypeValid_G2),        5, Spell_FMKPickLock_Focus);
    HookEngineF(+MEMINT_SwitchG1G2(oCSpell__Setup_G1, oCSpell__Setup_G2), 7, Spell_FMKPickLock_Prio);


    // Make sure Focus_Magic is initialized (necessary for Spell_FMKPickLock_Prio). For details see GothicFreeAim
    const int oCNpcFocus__focuslist_G1         =  9283120; //0x8DA630
    const int oCNpcFocus__focuslist_G2         = 11208440; //0xAB06F8

    var int fMagicPtr; fMagicPtr = MEM_ReadIntArray(+MEMINT_SwitchG1G2(oCNpcFocus__focuslist_G1,
                                                                       oCNpcFocus__focuslist_G2), /*Focus_Magic*/ 5);
    if (fMagicPtr) {
        MEM_Info("Spell_FMKPickLock: Reinitializing Focus_Magic instance");
        Focus_Magic = _^(fMagicPtr);
    };
};
