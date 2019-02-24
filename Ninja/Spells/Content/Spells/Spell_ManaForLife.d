// *****************************
// SPL_ManaForLife (mud-freak)
// *****************************

// Einstellungsmöglichkeinten
const int SPL_ManaForLife_RELATION = 2;    // 1 HP entspricht wieviel MP
const int SPL_ManaForLife_MINHP    = 20;   // Minimum an HP übrig lassen
const int SPL_ManaForLife_MAXHP    = 250;  // Maximum investbare HP
const int SPL_ManaForLife_SAYTIME  = 50;   // Interval zum Stöhnen (pro HP)

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
        self.aivar[AIV_SpellLevel] = 0;

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
    self.attribute[ATR_HITPOINTS] -= 1;
    Npc_ChangeAttribute(self, ATR_MANA, +SPL_ManaForLife_RELATION);
    self.aivar[AIV_SpellLevel] += 1;

    // Stöhnen: Die SVM hole ich manuell, weil B_Say für SC inkorrekt ist.
    var String soundprefix; soundprefix = ConcatStrings(
        ConcatStrings("SVM_", IntToString(self.voice)), "_AARGH_");
    if (self.aivar[AIV_SpellLevel] == SPL_ManaForLife_SAYTIME*1) {
        // B_Say(self, self, "$Aargh_1"); // Nicht korrekt für Hero
        Snd_Play3D(self, ConcatStrings(soundprefix, "1"));
    } else if (self.aivar[AIV_SpellLevel] == SPL_ManaForLife_SAYTIME*2) {
        // B_Say(self, self, "$Aargh_2"); // Nicht korrekt für Hero
        Snd_Play3D(self, ConcatStrings(soundprefix, "2"));
    } else if (self.aivar[AIV_SpellLevel] == SPL_ManaForLife_SAYTIME*3) {
        // B_Say(self, self, "$Aargh_3"); // Nicht korrekt für Hero
        Snd_Play3D(self, ConcatStrings(soundprefix, "3"));
        self.aivar[AIV_SpellLevel] = 0;
    };

    // Kein Mana abziehen
    return SPL_STATUS_CANINVEST_NO_MANADEC;
};

func void Spell_Cast_ManaForLife() {
    Wld_StopEffect("FOV_MORPH1"); // Zur Sicherheit
    self.aivar[AIV_SelectSpell] += 1;
};
