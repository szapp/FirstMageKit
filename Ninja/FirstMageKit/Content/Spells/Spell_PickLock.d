// *****************************
// SPL_PickLock (name modified for compatibility)
// Source: https://forum.worldofplayers.de/forum/threads/1547129
// Largely inspired by https://forum.worldofplayers.de/forum/threads/?p=12237820
//
// If using this spell in a mod (instead of this patch) make sure to remove 'FMK' from all symbol names!
// *****************************

// Constants.d (adjusted during initialization)
const int SPL_FMKPickLock       = 0;

const int SPL_Cost_FMKPickLock  = 5;    // Mana cost per lock tick
const int SPL_Time_FMKPickLock  = 1500; // MS per lock tick (not per mana!)

const int TARGET_TYPE_MOB       = 128;  // Technically invalid (see below)

instance Spell_FMKPickLock (/*C_Spell_Proto*/ C_Spell) {
    // Remaining standards copied from C_Spell_Proto (might not exist in mod)
    // --- C_Spell_Proto ---
    targetCollectAzi            = 60;
    targetCollectElev           = 60;
    // --- C_Spell_Proto ---

    time_per_mana               = IntToFloat(SPL_Time_FMKPickLock / SPL_Cost_FMKPickLock); // Do not change
    spelltype                   = SPELL_NEUTRAL;
    targetCollectAlgo           = TARGET_COLLECT_FOCUS;
    targetCollectType           = TARGET_TYPE_MOB;
    targetCollectRange          = 550;
    canTurnDuringInvest         = TRUE;
    canChangeTargetDuringInvest = FALSE;
    if (GOTHIC_BASE_VERSION == 130) || (GOTHIC_BASE_VERSION == 2) {
        // Gothic 2 does not allow canTurnDuringInvest for non-NPC focus, so we'll restrict the azimuth instead
        targetCollectAzi        = 20;
    };
};


/*
 * Sugar
 */
func void Spell_FMKPickLock_ClearKeyBuffer() {
    const int zCInput_Win32__ClearKeyBuffer[4] = {/*G1*/5016288, /*G1A*/5081840, /*G2*/5058576, /*G2A*/5068240};
    const int call = 0;
    if (CALL_Begin(call)) {
        CALL__thiscall(zCInput_zinput, zCInput_Win32__ClearKeyBuffer[IDX_EXE]);
        call = CALL_End();
    };
};


/*
 * Modified from https://forum.worldofplayers.de/forum/threads/?p=12237820
 */
func int Spell_Logic_FMKPickLock(var int manaInvested) {
    var oCNpc slf; slf = Hlp_GetNpc(self);
    var oCMobLockable mob;
    var int mobPtr;

    if (Npc_GetActiveSpellLevel(self) <= MEMINT_SwitchExe(2, 2, 1, 1)) { // G1 needs one level more for starting the FX
        if (!Hlp_Is_oCMobLockable(slf.focus_vob)) {
            return SPL_SENDSTOP;
        };

        mob = _^(slf.focus_vob);

        if (!(mob.bitfield & oCMobLockable_bitfield_locked)) {
            return SPL_SENDSTOP;
        };

        if (Hlp_StrCmp(mob.pickLockStr, "")) {
            Print(Patch_FirstMageKit_PRINT_NeverOpen);
            Spell_FMKPickLock_ClearKeyBuffer();
            return SPL_SENDSTOP;
        };

        if (self.attribute[ATR_MANA] < SPL_Cost_FMKPickLock) {
            return SPL_SENDSTOP;
        };

        // Remember verified focus
        mobPtr = slf.focus_vob;

        // Change in FX
        return SPL_NEXTLEVEL;

    } else if (!(manaInvested % SPL_Cost_FMKPickLock)) {
        mob = _^(slf.focus_vob);

        // Ensure focus was not changed
        if (slf.focus_vob != mobPtr) {
            return SPL_SENDSTOP;
        };

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
            Print(Patch_FirstMageKit_PRINT_PICKLOCK_UNLOCK);
            Snd_Play3D(self, "PICKLOCK_SUCCESS");

            // FX sound here, because VFX would also trigger it when aborting (releasing button prematurely)
            Snd_Play("MFX_PICKLOCK_CAST");

            // No handouts! SPL_SENDCAST does not decrease the mana
            if (GOTHIC_BASE_VERSION == 130) || (GOTHIC_BASE_VERSION == 2) {
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
        timestep = SPL_Time_FMKPickLock / SPL_Cost_FMKPickLock; // Divide total time by mana needed
        timestep = Hlp_Random(timestep) + /*minimum*/80;        // Create oscillations
        Spell_FMKPickLock.time_per_mana = IntToFloat(timestep); // Cast to Daedalus float
    };

    return SPL_RECEIVEINVEST;
};
func void Spell_Cast_FMKPickLock(var int spellLevel) {};


/*
 * Reset Focus_Magic instance
 * This function is called if (and only if) the active spell changes
 */
func void Spell_FMKPickLock_ResetFocus() {
    var oCMag_Book mb; mb = _^(ECX);
    if (!mb.owner) {
        return;
    };
    var C_Npc slf; slf = _^(mb.owner);
    if (!Npc_IsPlayer(slf)) {
        return;
    };

    // Should never happen, but safety first
    if (!_@(Focus_Magic)) {
        return;
    };

    // Backup/reset Focus_Magic completely
    const int focusCopy         = 0;
    const int sizeof_oCNpcFocus = 80;
    if (!focusCopy) {
        // Create one-time backup per session
        MEM_Info("Spell_FMKPickLock: Backing up original Focus_Magic values");
        focusCopy = MEM_Alloc(sizeof_oCNpcFocus);
        MEM_CopyBytes(_@(Focus_Magic), focusCopy, sizeof_oCNpcFocus);
    } else {
        // Reset on every spell change
        MEM_CopyBytes(focusCopy, _@(Focus_Magic), sizeof_oCNpcFocus);
    };
};


/*
 * Enable focusing mob when using the spell
 */
func void Spell_FMKPickLock_Prio() {
    const int arg0_offset            = 4;
    const int oCSpell_spellID_offset = 84;

    var int caster; caster = MEM_ReadInt(ESP + arg0_offset);
    if (!caster) {
        return;
    };
    var C_Npc slf; slf = _^(caster);
    if (!Npc_IsPlayer(slf)) {
        return;
    };

    var int spellID; spellID = MEM_ReadInt(ECX + oCSpell_spellID_offset);
    if (spellID == SPL_FMKPickLock) {
        // Adjust the global(!) focus priorities temporarily(!) = until the active spell changes
        Focus_Magic.mob_prio = 1;
    };
};


/*
 * Make the focus check mob specific (disallow NPC)
 */
func void Spell_FMKPickLock_Focus() {
    const int arg0_offset = 4;

    // Constructed case that will only happen for Spell_FMKPickLock
    if (ECX == TARGET_TYPE_MOB) {
        var int vobPtr; vobPtr = MEM_ReadInt(ESP + arg0_offset);
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
    const int oCSpell__IsTargetTypeValid[4] = {/*G1*/4709316, /*G1A*/4752548, /*G2*/4737444, /*G2A*/ 4743108};
    const int oCSpell__Setup[4]             = {/*G1*/4703664, /*G1A*/4746560, /*G2*/4731600, /*G2A*/ 4737328};
    const int oCMag_Book__SetFrontSpell[4]  = {/*G1*/4660480, /*G1A*/4697600, /*G2*/4683296, /*G2A*/ 4688320};
    const int oCNpcFocus__focuslist[4]      = {/*G1*/9283120, /*G1A*/9571240, /*G2*/9966160, /*G2A*/11208440};
    const int Focus_Magic_Index             = 5;

    MEM_InitAll();

    HookEngineF(oCSpell__IsTargetTypeValid[IDX_EXE], 5, Spell_FMKPickLock_Focus);
    HookEngineF(oCSpell__Setup[IDX_EXE],             7, Spell_FMKPickLock_Prio);
    HookEngineF(oCMag_Book__SetFrontSpell[IDX_EXE],  7, Spell_FMKPickLock_ResetFocus);

    // Ensure that Focus_Magic is not empty (necessary for Spell_FMKPickLock_Prio). For details see GothicFreeAim
    var int fMagicPtr; fMagicPtr = MEM_ReadIntArray(oCNpcFocus__focuslist[IDX_EXE], Focus_Magic_Index);
    if (fMagicPtr) {
        MEM_Info("Spell_FMKPickLock: Reassigning Focus_Magic instance");
        Focus_Magic = _^(fMagicPtr);
    };
};
