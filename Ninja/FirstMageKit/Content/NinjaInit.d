/*
 * Menu initialization function called by Ninja every time a menu is opened
 *
 * Here used to inject initialization once before first new game/loading
 */
func void Ninja_FirstMageKit_Menu(var int menuPtr) {
    const int once = 0;
    if (once) {
        return;
    };
    once = 1;

    MEM_InitAll();

    // Add mana processing calls
    HookDaedalusFuncS("Spell_ProcessMana",         "Ninja_FirstMageKit_Spell_ProcessMana");
    HookDaedalusFuncS("Spell_ProcessMana_Release", "Ninja_FirstMageKit_Spell_ProcessMana_Release");

    // Enlarge static arrays
    Ninja_FirstMageKit_EnlargeStatStringArr(MEM_GetSymbol("spellFxInstanceNames"), Ninja_FirstMageKit_NumNewSpells);
    Ninja_FirstMageKit_EnlargeStatStringArr(MEM_GetSymbol("spellFxAniLetters"),    Ninja_FirstMageKit_NumNewSpells);
    Ninja_FirstMageKit_EnlargeStatStringArr(MEM_GetSymbol("TXT_SPELLS"),           Ninja_FirstMageKit_NumNewSpells);

    // Add spells (also increments MAX_SPELL)
    SPL_ManaForLife = Ninja_FirstMageKit_SetSpell("ManaForLife", "SAC", NAME_SPL_ManaForLife);
    SPL_PickLock    = Ninja_FirstMageKit_SetSpell("PickLock",    "PYR", NAME_SPL_PickLock);

    // Spell script initializations
    Spell_ManaForLife_Init();
    Spell_PickLock_Init();

    // Adjust language
    var int lang; lang = Ninja_FirstMageKit_GuessLocalization();
    if (lang == 1) { // DE
        NAME_SPL_ManaForLife                     = "Manasucht";
        NAME_SPL_PickLock                        = "Entriegeln";
        Ninja_FirstMageKit_PRINT_NeverOpen       = "Da lässt sich nichts machen";
        Ninja_FirstMageKit_PRINT_PICKLOCK_UNLOCK = "Das Schloß ist geknackt";
        Ninja_FirstMageKit_PRINT_Hitpoints       = "Lebenspunktkosten:";
        Ninja_FirstMageKit_PRINT_Mana            = "Manasteigerung:";
        Ninja_FirstMageKit_NAME_MinManakosten    = "Manakosten (min):";
    } else if (lang == 2) { // PL
        NAME_SPL_ManaForLife                     = "Gwa³towny wzrost mana";
        NAME_SPL_PickLock                        = "Odblokowaå";
        Ninja_FirstMageKit_PRINT_NeverOpen       = "Tego nie da siê otworzyæ.";
        Ninja_FirstMageKit_PRINT_PICKLOCK_UNLOCK = "Zamek otwarty.";
        Ninja_FirstMageKit_PRINT_Hitpoints       = "Wydatek punkty trafieñ:";
        Ninja_FirstMageKit_PRINT_Mana            = "Premia many:";
        Ninja_FirstMageKit_NAME_MinManakosten    = "Wydatek many:";
    } else if (lang == 3) { // RU
        NAME_SPL_ManaForLife                     = "óâåëè÷åíèå ìàíû";
        NAME_SPL_PickLock                        = "ðàñöåïëÿòü";
        Ninja_FirstMageKit_PRINT_NeverOpen       = "Ýòî ìíå íèêîãäà íå îòêðûòü.";
        Ninja_FirstMageKit_PRINT_PICKLOCK_UNLOCK = "Çàìîê îòêðûò.";
        Ninja_FirstMageKit_PRINT_Hitpoints       = "Çäîðîâüå:";
        Ninja_FirstMageKit_PRINT_Mana            = "Ìàíà:";
        Ninja_FirstMageKit_NAME_MinManakosten    = "Ðàñõîä ìàíû:";
    }; // Else: Keep default -> English
};


// Directly offer the new items to the player (only on new game)
instance PC_Hero (Npc_Default) {
    EquipItem(self, ItRu_ManaForLife);
    EquipItem(self, ItSc_PickLock);
    CreateInvItems(self, ItSc_PickLock, 99);
};


/*
 * Additions to the mana processing functions
 */
func int Ninja_FirstMageKit_Spell_ProcessMana(var int manaInvested) {
    var int activeSpell; activeSpell = Npc_GetActiveSpell(self);

    if (activeSpell == SPL_ManaForLife        ) { return Spell_Logic_ManaForLife(manaInvested);         };
    if (activeSpell == SPL_PickLock           ) { return Spell_Logic_PickLock(manaInvested);            };

    PassArgumentI(manaInvested);
    ContinueCall();
};
func int Ninja_FirstMageKit_Spell_ProcessMana_Release(var int manaInvested) {
    var int activeSpell; activeSpell = Npc_GetActiveSpell(self);

    if (activeSpell == SPL_ManaForLife        ) { return SPL_SENDCAST;                                  };
    if (activeSpell == SPL_PickLock           ) { return SPL_SENDSTOP; /* Aborted */                    };

    PassArgumentI(manaInvested);
    ContinueCall();
};
