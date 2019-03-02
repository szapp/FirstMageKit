// *****************************
// SPL_ManaForLife
// Taken from mud-freak's Zauberpaket
// *****************************

// Einstellungsmöglichkeinten
const int SPL_ManaForLife_RELATION = 2;    // 1 HP entspricht wieviel MP
const int SPL_ManaForLife_MINHP    = 20;   // Minimum an HP übrig lassen
const int SPL_ManaForLife_MAXHP    = 250;  // Maximum investbare HP
const int SPL_ManaForLife_SAYTIME  = 50;   // Interval zum Stöhnen (pro HP)
const int SPL_ManaForLife_SplLevel = 0;    // Previously used AI-var AIV_SpellLevel

INSTANCE Spell_ManaForLife (C_Spell_Proto) {
    time_per_mana           = 50;            // Ms pro 1 HP (nicht zu hoch!)
    spelltype               = SPELL_NEUTRAL;
    targetCollectAlgo       = TARGET_COLLECT_CASTER;
    canTurnDuringInvest     = FALSE;
};

func int Spell_Logic_ManaForLife(var int healthInvested) {
    /* Wenn NPCs diesen Spell benutzen sollen beachten, dass NPCs normaler-
     * weise immer volles Mana haben, siehe B_ReadySpell. Ausserdem muss
     * dann der spellFX angepasst werden, weil der ScreenFX ja sonst für den
     * Spieler zu sehen ist. */

    // Einmalige Abfrage zu Anfang
    if (healthInvested == 0) {
        // Nicht genug HP
        if (self.attribute[ATR_HITPOINTS] <= SPL_ManaForLife_MINHP)
        || (self.attribute[ATR_MANA] == self.attribute[ATR_MANA_MAX]) {
            return SPL_SENDSTOP;
        };
        SPL_ManaForLife_SplLevel = 0;

        Wld_StopEffect("FOV_MORPH1"); // Zur Sicherheit
        return SPL_NEXTLEVEL; // Damit der FX startet
    };

    // Beenden
    if (self.attribute[ATR_HITPOINTS] <= SPL_ManaForLife_MINHP)
    || (self.attribute[ATR_MANA] == self.attribute[ATR_MANA_MAX])
    || (healthInvested > SPL_ManaForLife_MAXHP) {
        return SPL_SENDCAST;
    };

    // Tausche HP gegen MP
    // self.attribute[ATR_HITPOINTS] -= 1; // Done below, since this spell now takes health instead of mana
    Npc_ChangeAttribute(self, ATR_MANA, +SPL_ManaForLife_RELATION);
    SPL_ManaForLife_SplLevel += 1;

    // Stöhnen: Die SVM hole ich manuell, weil B_Say für SC inkorrekt ist.
    var String soundprefix; soundprefix = ConcatStrings(
        ConcatStrings("SVM_", IntToString(self.voice)), "_AARGH_");
    if (SPL_ManaForLife_SplLevel == SPL_ManaForLife_SAYTIME*1) {
        // B_Say(self, self, "$Aargh_1"); // Nicht korrekt für Hero
        Snd_Play3D(self, ConcatStrings(soundprefix, "1"));
    } else if (SPL_ManaForLife_SplLevel == SPL_ManaForLife_SAYTIME*2) {
        // B_Say(self, self, "$Aargh_2"); // Nicht korrekt für Hero
        Snd_Play3D(self, ConcatStrings(soundprefix, "2"));
    } else if (SPL_ManaForLife_SplLevel == SPL_ManaForLife_SAYTIME*3) {
        // B_Say(self, self, "$Aargh_3"); // Nicht korrekt für Hero
        Snd_Play3D(self, ConcatStrings(soundprefix, "3"));
        SPL_ManaForLife_SplLevel = 0;
    };

    // Kein Mana abziehen
    // return SPL_STATUS_CANINVEST_NO_MANADEC;
    return SPL_RECEIVEINVEST;
};

func void Spell_Cast_ManaForLife() {
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
func void Spell_ManaForLife_SetToHP() {
    var int spell; spell = MEMINT_SwitchG1G2(ESI, ECX);
    var int spellID; spellID = MEM_ReadInt(spell+/*spellID*/84);
    if (spellID == SPL_ManaForLife) {
        MEM_WriteInt(spell+/*investATR*/124, ATR_HITPOINTS);
    };
};


/*
 * Initialize to cast with zero mana
 */
func void Spell_ManaForLife_Init() {
    const int oCSpell__InitValues_G1 = 4701341; //0x47BC9D
    const int oCSpell__InitValues_G2 = 4735143; //0x4840A7
    HookEngineF(+MEMINT_SwitchG1G2(oCSpell__InitValues_G1, oCSpell__InitValues_G2), 6, Spell_ManaForLife_SetToHP);
};
