// *****************************
// SPL_ManaForLife (name modified for compatibility)
// Taken from mud-freak's Zauberpaket
//
// If using this spell in a mod (instead of this patch) make sure to remove 'FMK' from all symbol names!
// *****************************

// Constants.d (adjusted during initialization)
const int SPL_FMKManaForLife          = 0;

// Einstellungsm�glichkeinten
const int SPL_FMKManaForLife_RELATION = 2;    // 1 HP entspricht wieviel MP
const int SPL_FMKManaForLife_MINHP    = 20;   // Minimum an HP �brig lassen
const int SPL_FMKManaForLife_MAXHP    = 250;  // Maximum investbare HP
const int SPL_FMKManaForLife_SAYTIME  = 50;   // Interval zum St�hnen (pro HP)
const int SPL_FMKManaForLife_SplLevel = 0;    // Previously used AI-var AIV_SpellLevel

INSTANCE Spell_FMKManaForLife (/*C_Spell_Proto*/ C_Spell) {
    // Remaining standards copied from C_Spell_Proto (might not exist in mod)
    // --- C_Spell_Proto ---
    canChangeTargetDuringInvest = 1;
    targetCollectRange          = 10000;
    targetCollectAzi            = 60;
    targetCollectElev           = 60;
    // --- C_Spell_Proto ---

    time_per_mana           = IntToFloat(MEMINT_SwitchG1G2(250, 50)); // Ms pro 1 HP (nicht zu hoch!)
    spelltype               = SPELL_NEUTRAL;
    targetCollectAlgo       = TARGET_COLLECT_CASTER;
    canTurnDuringInvest     = FALSE;
};

func int Spell_Logic_FMKManaForLife(var int healthInvested) {
    /* Wenn NPCs diesen Spell benutzen sollen beachten, dass NPCs normaler-
     * weise immer volles Mana haben, siehe B_ReadySpell. Ausserdem muss
     * dann der spellFX angepasst werden, weil der ScreenFX ja sonst f�r den
     * Spieler zu sehen ist. */

    // Einmalige Abfrage zu Anfang
    if (healthInvested == 0) {
        // Nicht genug HP
        if (self.attribute[ATR_HITPOINTS] <= SPL_FMKManaForLife_MINHP)
        || (self.attribute[ATR_MANA] == self.attribute[ATR_MANA_MAX]) {
            return SPL_SENDSTOP;
        };
        SPL_FMKManaForLife_SplLevel = 0;

        if (GOTHIC_BASE_VERSION == 2) { // Gothic 1 parsing compatibility
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
    Npc_ChangeAttribute(self, ATR_MANA, +SPL_FMKManaForLife_RELATION);
    SPL_FMKManaForLife_SplLevel += 1;

    // St�hnen: Die SVM hole ich manuell, weil B_Say f�r SC inkorrekt ist.
    var String soundprefix; soundprefix = ConcatStrings(
        ConcatStrings("SVM_", IntToString(self.voice)), "_AARGH_");
    if (SPL_FMKManaForLife_SplLevel == SPL_FMKManaForLife_SAYTIME*1) {
        // B_Say(self, self, "$Aargh_1"); // Nicht korrekt f�r Hero
        Snd_Play3D(self, ConcatStrings(soundprefix, "1"));
    } else if (SPL_FMKManaForLife_SplLevel == SPL_FMKManaForLife_SAYTIME*2) {
        // B_Say(self, self, "$Aargh_2"); // Nicht korrekt f�r Hero
        Snd_Play3D(self, ConcatStrings(soundprefix, "2"));
    } else if (SPL_FMKManaForLife_SplLevel == SPL_FMKManaForLife_SAYTIME*3) {
        // B_Say(self, self, "$Aargh_3"); // Nicht korrekt f�r Hero
        Snd_Play3D(self, ConcatStrings(soundprefix, "3"));
        SPL_FMKManaForLife_SplLevel = 0;
    };

    // Kein Mana abziehen
    // return SPL_STATUS_CANINVEST_NO_MANADEC;
    return SPL_RECEIVEINVEST;
};

func void Spell_Cast_FMKManaForLife(var int spellLevel) {
    if (GOTHIC_BASE_VERSION == 2) { // Gothic 1 parsing compatibility
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
    var int spell; spell = MEMINT_SwitchG1G2(ESI, ECX);
    var int spellID; spellID = MEM_ReadInt(spell+/*spellID*/84);
    if (spellID == SPL_FMKManaForLife) {
        MEM_WriteInt(spell+/*investATR*/124, ATR_HITPOINTS);
    };
};


/*
 * Initialize to cast with zero mana
 */
func void Spell_FMKManaForLife_Init() {
    const int oCSpell__InitValues_G1 = 4701341; //0x47BC9D
    const int oCSpell__InitValues_G2 = 4735143; //0x4840A7
    HookEngineF(MEMINT_SwitchG1G2(oCSpell__InitValues_G1, oCSpell__InitValues_G2), 6, Spell_FMKManaForLife_SetToHP);

    // There is way less mana compared to HP in Gothic 1
    if (GOTHIC_BASE_VERSION == 1) {
        SPL_FMKManaForLife_RELATION = 1;
    };
};
