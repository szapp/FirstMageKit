// *****************************
// SPL_PickLock
// Largely inspired by https://forum.worldofplayers.de/forum/threads/?p=12237820
// *****************************

const int SPL_Cost_PickLock     = 5;   // Mana cost per lock tick
const int SPL_Time_PickLock     = 250;

const int TARGET_TYPE_MOB       = 128; // Technically invalid (see below)

instance Spell_PickLock (C_Spell_Proto) {
    time_per_mana               = 200; // Dynamically modified below
    spelltype                   = SPELL_NEUTRAL;
    targetCollectAlgo           = TARGET_COLLECT_FOCUS;
    targetCollectType           = TARGET_TYPE_MOB;
    targetCollectRange          = 500;
    canTurnDuringInvest         = FALSE;
    canChangeTargetDuringInvest = FALSE;
};


/*
 * Sugar
 */
func void Spell_PickLock_ClearKeyBuffer() {
    const int zCInput_Win32__ClearKeyBuffer = 5068240; //0x4D55D0
    const int call = 0;
    if (CALL_Begin(call)) {
        CALL__thiscall(zCInput_zinput, zCInput_Win32__ClearKeyBuffer);
        call = CALL_End();
    };
};


/*
 * Modified from https://forum.worldofplayers.de/forum/threads/?p=12237820
 */
func int Spell_Logic_PickLock(var int manaInvested) {
    var oCNpc slf; slf = Hlp_GetNpc(self);
    var oCMobLockable mob;

    if (self.attribute[ATR_MANA] < SPL_Cost_PickLock) {
        return SPL_SENDSTOP;
    };

    if (manaInvested <= SPL_Cost_PickLock) {
        if (!Hlp_Is_oCMobLockable(slf.focus_vob)) {
            return SPL_SENDSTOP;
        };

        mob = _^(slf.focus_vob);

        if (!(mob.bitfield & oCMobLockable_bitfield_locked)) {
            return SPL_SENDSTOP;
        };

        if (Hlp_StrCmp(mob.pickLockStr, "")) {
            Print(PRINT_NeverOpen);
            Spell_PickLock_ClearKeyBuffer();
            return SPL_SENDSTOP;
        };

        // Change in FX
        return SPL_NEXTLEVEL;

    } else if (!(manaInvested % SPL_Cost_PickLock)) {
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
            Print(PRINT_PICKLOCK_UNLOCK);
            Snd_Play3D(self, "PICKLOCK_SUCCESS");

            // Prevent the player from running forward after casting
            Spell_PickLock_ClearKeyBuffer();
            return SPL_SENDCAST;
        };

        //immerhin einen Schritt weiter
        Snd_Play3D(self, "PICKLOCK_SUCCESS");
    };

    // Vary the timing
    Spell_PickLock.time_per_mana = castFromIntf(mkf(Hlp_Random(SPL_Time_PickLock) + SPL_Time_PickLock/3));
    return SPL_RECEIVEINVEST;
};
func int Spell_Cast_PickLock() {};


/*
 * Enable focusing mob when using the spell
 */
func void Spell_PickLock_Prio() {
    var int caster; caster = MEM_ReadInt(ESP+4);
    if (!caster) {
        return;
    };
    var C_Npc slf; slf = _^(caster);
    if (!Npc_IsPlayer(slf)) {
        return;
    };

    const int mob_prio_backup = 42;
    if (mob_prio_backup == 42) {
        mob_prio_backup = Focus_Magic.mob_prio;
    };

    var int spellID; spellID = MEM_ReadInt(/*oCSpell*/ECX+/*spellID*/84);
    if (spellID == SPL_PickLock) {
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
func void Spell_PickLock_Focus() {
    // Constructed case that will only happen for Spell_PickLock
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
func void Spell_PickLock_Init() {
    const int oCSpell__IsTargetTypeValid    = 4743108; //0x485FC4
    const int oCSpell__Setup                = 4737328; //0x484930
    HookEngineF(oCSpell__IsTargetTypeValid, 5, Spell_PickLock_Focus);
    HookEngineF(oCSpell__Setup,             7, Spell_PickLock_Prio);
};
