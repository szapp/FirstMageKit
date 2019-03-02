/*
 * Menu initialization function called by Ninja every time a menu is opened
 *
 * Here used to inject initialization once before first new game/loading
 */
func void Ninja_Spells_Menu(var int menuPtr) {
    const int once = 0;
    if (once) {
        return;
    };
    once = 1;

    MEM_InitAll();

    // Add mana processing calls
    HookDaedalusFuncS("Spell_ProcessMana",         "Ninja_Spells_Spell_ProcessMana");
    HookDaedalusFuncS("Spell_ProcessMana_Release", "Ninja_Spells_Spell_ProcessMana_Release");

    // Enlarge static arrays
    Ninja_Spells_EnlargeStatStringArr(MEM_GetSymbol("spellFxInstanceNames"), Ninja_Spells_NumNewSpells);
    Ninja_Spells_EnlargeStatStringArr(MEM_GetSymbol("spellFxAniLetters"),    Ninja_Spells_NumNewSpells);
    Ninja_Spells_EnlargeStatStringArr(MEM_GetSymbol("TXT_SPELLS"),           Ninja_Spells_NumNewSpells);

    // Add spells (also increments MAX_SPELL)
    SPL_ManaForLife = Ninja_Spells_SetSpell("ManaForLife", "SAC", NAME_SPL_ManaForLife);
    SPL_PickLock    = Ninja_Spells_SetSpell("PickLock",    "PYR", NAME_SPL_PickLock);

    // Spell script initializations
    Spell_ManaForLife_Init();
    Spell_PickLock_Init();
};


// Directly offer the new items to the player (only on new game)
instance PC_Hero (Npc_Default) {
    EquipItem(self, ItRu_ManaForLife);
    EquipItem(self, ItSc_PickLock);
    EquipItem(self, ItRu_FireBolt);
    CreateInvItems(self, ItSc_PickLock, 99);
};


/*
 * Additions to the mana processing functions
 */
func int Ninja_Spells_Spell_ProcessMana(var int manaInvested) {
    var int activeSpell; activeSpell = Npc_GetActiveSpell(self);

    if (activeSpell == SPL_ManaForLife        ) { return Spell_Logic_ManaForLife(manaInvested);         };
    if (activeSpell == SPL_PickLock           ) { return Spell_Logic_PickLock(manaInvested);            };

    PassArgumentI(manaInvested);
    ContinueCall();
};
func int Ninja_Spells_Spell_ProcessMana_Release(var int manaInvested) {
    var int activeSpell; activeSpell = Npc_GetActiveSpell(self);

    if (activeSpell == SPL_ManaForLife        ) { return SPL_SENDCAST;                                  };
    if (activeSpell == SPL_PickLock           ) { return SPL_SENDSTOP; /* Aborted */                    };

    PassArgumentI(manaInvested);
    ContinueCall();
};
