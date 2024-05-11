// *****************************
// SPL_ManaForLife (name modified for compatibility)
// Taken from mud-freak's Zauberpaket
//
// If using this spell in a mod (instead of this patch) make sure to remove 'FMK' from all symbol names!
// *****************************

// Constants.d (adjusted during initialization)
const int SPL_FMKManaForLife          = 0;

// Einstellungsmöglichkeinten
const int SPL_FMKManaForLife_RELATION = 2;    // 1 HP entspricht wieviel MP - NO, IT'S REVERSED HERE!
const int SPL_FMKManaForLife_MINHP    = 20;   // Minimum an HP übrig lassen
const int SPL_FMKManaForLife_MAXHP    = 400;  // Maximum investbare HP
const int SPL_FMKManaForLife_SAYTIME  = 50;   // Interval zum Stöhnen (pro HP) - OVERWRITTEN BELOW
const int SPL_FMKManaForLife_SplLevel = 0;    // Previously used AI-var AIV_SpellLevel

INSTANCE Spell_FMKManaForLife (/*C_Spell_Proto*/ FMK_C_Spell) {
    // Remaining standards copied from C_Spell_Proto (might not exist in mod)
    // --- C_Spell_Proto ---
    canChangeTargetDuringInvest     = 1;
    targetCollectRange              = 10000;
    targetCollectAzi                = 60;
    targetCollectElev               = 60;
    // --- C_Spell_Proto ---
    const int SPELL_NEUTRAL         = 1;
    const int TARGET_COLLECT_CASTER = 1;

    time_per_mana           = IntToFloat((100 / SPL_FMKManaForLife_RELATION) + 1); // Make it depend on mana not hp
    spelltype               = SPELL_NEUTRAL;
    targetCollectAlgo       = TARGET_COLLECT_CASTER;
    canTurnDuringInvest     = FALSE;

    SPL_FMKManaForLife_SAYTIME = SPL_FMKManaForLife_RELATION * 25; // Every 25 gained mana points
};

func int Spell_Logic_FMKManaForLife(var int healthInvested) {
    const int SPL_RECEIVEINVEST     = 1;
    const int SPL_SENDCAST          = 2;
    const int SPL_SENDSTOP          = 3;
    const int SPL_NEXTLEVEL         = 4;

    const int ATR_HITPOINTS         = 0;
    const int ATR_MANA              = 2;
    const int ATR_MANA_MAX          = 3;


    /* Wenn NPCs diesen Spell benutzen sollen beachten, dass NPCs normaler-
     * weise immer volles Mana haben, siehe B_ReadySpell. Ausserdem muss
     * dann der spellFX angepasst werden, weil der ScreenFX ja sonst für den
     * Spieler zu sehen ist. */

    // Einmalige Abfrage zu Anfang
    if (healthInvested == 0) {
        // Nicht genug HP
        if (self.attribute[ATR_HITPOINTS] <= SPL_FMKManaForLife_MINHP)
        || (self.attribute[ATR_MANA] == self.attribute[ATR_MANA_MAX]) {
            return SPL_SENDSTOP;
        };
        SPL_FMKManaForLife_SplLevel = 0;

        if (GOTHIC_BASE_VERSION == 130) || (GOTHIC_BASE_VERSION == 2) { // Gothic 1 parsing compatibility
            // Zur Sicherheit
            MEM_PushStringParam("FOV_MORPH1");
            MEM_CallByString("WLD_STOPEFFECT");
        };
        return SPL_NEXTLEVEL; // Damit der FX startet
    };

    // Beenden
    if (self.attribute[ATR_HITPOINTS] <= SPL_FMKManaForLife_MINHP)
    || (self.attribute[ATR_MANA] == self.attribute[ATR_MANA_MAX])
    || (healthInvested > SPL_FMKManaForLife_MAXHP) {
        return SPL_SENDCAST;
    };

    // Tausche HP gegen MP
    // self.attribute[ATR_HITPOINTS] -= 1; // Done below, since this spell now takes health instead of mana
    Npc_ChangeAttribute(self, ATR_MANA, +((healthInvested % SPL_FMKManaForLife_RELATION) == 0));
    SPL_FMKManaForLife_SplLevel += 1;

    // Stöhnen: Die SVM hole ich manuell, weil B_Say für SC inkorrekt ist.
    var String soundprefix; soundprefix = ConcatStrings(
        ConcatStrings("SVM_", IntToString(self.voice)), "_AARGH_");
    if (SPL_FMKManaForLife_SplLevel == SPL_FMKManaForLife_SAYTIME*1) {
        // B_Say(self, self, "$Aargh_1"); // Nicht korrekt für Hero
        Snd_Play3D(self, ConcatStrings(soundprefix, "1"));
    } else if (SPL_FMKManaForLife_SplLevel == SPL_FMKManaForLife_SAYTIME*2) {
        // B_Say(self, self, "$Aargh_2"); // Nicht korrekt für Hero
        Snd_Play3D(self, ConcatStrings(soundprefix, "2"));
    } else if (SPL_FMKManaForLife_SplLevel == SPL_FMKManaForLife_SAYTIME*3) {
        // B_Say(self, self, "$Aargh_3"); // Nicht korrekt für Hero
        Snd_Play3D(self, ConcatStrings(soundprefix, "3"));
        SPL_FMKManaForLife_SplLevel = 0;
    };

    // Kein Mana abziehen
    // return SPL_STATUS_CANINVEST_NO_MANADEC;
    return SPL_RECEIVEINVEST;
};

func void Spell_Cast_FMKManaForLife(var int spellLevel) {
    if (GOTHIC_BASE_VERSION == 130) || (GOTHIC_BASE_VERSION == 2) { // Gothic 1 parsing compatibility
        // Zur Sicherheit
        MEM_PushStringParam("FOV_MORPH1");
        MEM_CallByString("WLD_STOPEFFECT");
    };
    // self.aivar[AIV_SelectSpell] += 1; // Not needed for player-only spell
};


/*
 * Set health as the invest attribute to allow casting with zero mana
 */
func void Spell_FMKManaForLife_SetToHP() {
    const int ATR_HITPOINTS            = 0;

    const int oCSpell_spellID_offset   = 84;
    const int oCSpell_investATR_offset = 124;

    var int spellID; spellID = MEM_ReadInt(ESI + oCSpell_spellID_offset);
    if (spellID == SPL_FMKManaForLife) {
        MEM_WriteInt(ESI + oCSpell_investATR_offset, ATR_HITPOINTS);
    };
};


/*
 * Initialize to cast with zero mana
 */
func void Spell_FMKManaForLife_Init() {
    const int oCSpell__InitValues[4] = {/*G1*/4701341, /*G1A*/4743966, /*G2*/4729447, /*G2A*/4735143};
    HookEngineF(oCSpell__InitValues[FMK_EXE], 6, Spell_FMKManaForLife_SetToHP);
};
