/*
 * Enlarging stating arrays is tricky
 */
func void Ninja_FirstMageKit_EnlargeStatStringArr(var int symbPtr, var int numNew) {
    const int zCPar_Symbol___zCPar_Symbol_G1 = 7306624; //0x6F7D80
    const int zCPar_Symbol___zCPar_Symbol_G2 = 8001264; //0x7A16F0
    const int zCPar_Symbol__AllocSpace_G1    = 7306832; //0x6F7E50
    const int zCPar_Symbol__AllocSpace_G2    = 8001472; //0x7A17C0

    // First: Backup all the relevant information of the symbol
    var zCPar_Symbol symb; symb = _^(symbPtr);
    var string name; name = symb.name;
    var int bitfield; bitfield = symb.bitfield;
    var int numEle; numEle = bitfield & zCPar_Symbol_bitfield_ele;
    // The string content we'll have to backup this way (one string at a time, deep copy)
    var int buffer; buffer = MEM_Alloc(numEle * sizeof_zSTRING);
    repeat(i, numEle); var int i;
        MEM_WriteStringArray(buffer, i, MEM_ReadStringArray(symb.content, i));
    end;

    // Free the content of the symbol
    const int call = 0;
    if (CALL_Begin(call)) {
        CALL__thiscall(_@(symbPtr), MEMINT_SwitchG1G2(zCPar_Symbol___zCPar_Symbol_G1,
                                                      zCPar_Symbol___zCPar_Symbol_G2));
        call = CALL_End();
    };

    // Reset the properties how we want them - mind the increase in elements
    symb.name = name;
    symb.bitfield = (bitfield & ~zCPar_Symbol_bitfield_ele) | (numEle+numNew);
    symb.bitfield = symb.bitfield & ~4194304; // Set 'allocated' to false

    // Have Gothic allocate the space for the content (we cannot do this ourselves, because it's tied to a pool)
    const int call2 = 0;
    if (CALL_Begin(call2)) {
        CALL__thiscall(_@(symbPtr), MEMINT_SwitchG1G2(zCPar_Symbol__AllocSpace_G1, zCPar_Symbol__AllocSpace_G2));
        call2 = CALL_End();
    };

    // Restore the content - again one by one
    repeat(i, numEle);
        MEM_WriteStringArray(symb.content, i, MEM_ReadStringArray(buffer, i));
    end;
    MEM_Free(buffer);
};


/*
 * Add a new spell at "runtime" (kind of). Expects the static arrays to be already enlarged (see above)
 */
func int Ninja_FirstMageKit_SetSpell(var string spellFxInst, var string spellFxAniLetter, var string spellTxt) {
    // Increase index
    var int spellID; spellID = MAX_SPELL;
    MAX_SPELL += 1;

    // Set static arrays
    MEM_WriteStatStringArr(spellFxInstanceNames, spellID, spellFxInst);
    MEM_WriteStatStringArr(spellFxAniLetters,    spellID, spellFxAniLetter);
    MEM_WriteStatStringArr(TXT_SPELLS,           spellID, spellTxt);

    return spellID;
};


/*
 * Initialize the new spells
 */
func void Ninja_FirstMageKit_CreateSpells() {
    const int NumNewSpells = 2;

    // Enlarge static arrays
    Ninja_FirstMageKit_EnlargeStatStringArr(MEM_GetSymbol("spellFxInstanceNames"), NumNewSpells);
    Ninja_FirstMageKit_EnlargeStatStringArr(MEM_GetSymbol("spellFxAniLetters"),    NumNewSpells);
    Ninja_FirstMageKit_EnlargeStatStringArr(MEM_GetSymbol("TXT_SPELLS"),           NumNewSpells);

    // Add spells (also increments MAX_SPELL)
    SPL_FMKManaForLife = Ninja_FirstMageKit_SetSpell("FMKManaForLife", "SAC", NAME_SPL_FMKManaForLife);
    SPL_FMKPickLock    = Ninja_FirstMageKit_SetSpell("FMKPickLock",    "PYR", NAME_SPL_FMKPickLock);

    // Add mana processing calls
    HookDaedalusFuncS("Spell_ProcessMana",         "Ninja_FirstMageKit_Spell_ProcessMana");
    HookDaedalusFuncS("Spell_ProcessMana_Release", "Ninja_FirstMageKit_Spell_ProcessMana_Release");
};


/*
 * Additions to the mana processing functions
 */
func int Ninja_FirstMageKit_Spell_ProcessMana(var int manaInvested) {
    var int activeSpell; activeSpell = Npc_GetActiveSpell(self);

    if (activeSpell == SPL_FMKManaForLife     ) { return Spell_Logic_FMKManaForLife(manaInvested);      };
    if (activeSpell == SPL_FMKPickLock        ) { return Spell_Logic_FMKPickLock(manaInvested);         };

    PassArgumentI(manaInvested);
    ContinueCall();
};
func int Ninja_FirstMageKit_Spell_ProcessMana_Release(var int manaInvested) {
    var int activeSpell; activeSpell = Npc_GetActiveSpell(self);

    if (activeSpell == SPL_FMKManaForLife     ) { return SPL_SENDCAST;                                  };
    if (activeSpell == SPL_FMKPickLock        ) { return SPL_SENDSTOP; /* Aborted */                    };

    PassArgumentI(manaInvested);
    ContinueCall();
};
