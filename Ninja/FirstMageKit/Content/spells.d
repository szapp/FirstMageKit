/*
 * Enlarging stating arrays is tricky
 * Source: https://github.com/szapp/Ninja/wiki/Applications-and-Examples
 */
func void Patch_FirstMageKit_EnlargeStatStringArr(var int symbPtr, var int numNewTotal) {
    const int zCPar_Symbol___zCPar_Symbol[4] = {/*G1*/7306624, /*G1A*/7544544, /*G2*/7609520, /*G2A*/8001264};
    const int zCPar_Symbol__AllocSpace[4]    = {/*G1*/7306832, /*G1A*/7544784, /*G2*/7609728, /*G2A*/8001472};

    // First: Backup all the relevant information of the symbol
    var zCPar_Symbol symb; symb = _^(symbPtr);
    var string name; name = symb.name;
    var int bitfield; bitfield = symb.bitfield;
    var int numEle; numEle = bitfield & zCPar_Symbol_bitfield_ele;

    // I refuse to make it smaller
    if (numNewTotal <= numEle) {
        return;
    };

    // The string content we'll have to backup this way (one string at a time, deep copy)
    var int buffer; buffer = MEM_Alloc(numEle * sizeof_zSTRING);
    repeat(i, numEle); var int i;
        MEM_WriteStringArray(buffer, i, MEM_ReadStringArray(symb.content, i));
    end;

    // Free the content of the symbol
    const int call = 0;
    if (CALL_Begin(call)) {
        CALL__thiscall(_@(symbPtr), zCPar_Symbol___zCPar_Symbol[IDX_EXE]);
        call = CALL_End();
    };

    // Reset the properties how we want them - mind the increase in elements
    symb.name = name;
    symb.bitfield = (bitfield & ~zCPar_Symbol_bitfield_ele) | numNewTotal;
    symb.bitfield = symb.bitfield & ~zCPar_Symbol_bitfield_space; // Set 'allocated' to false

    // Have Gothic allocate the space for the content (we cannot do this ourselves, because it's tied to a pool)
    const int call2 = 0;
    if (CALL_Begin(call2)) {
        CALL__thiscall(_@(symbPtr), zCPar_Symbol__AllocSpace[IDX_EXE]);
        call2 = CALL_End();
    };

    // Restore the content - again one by one
    repeat(i, numEle);
        MEM_WriteStringArray(symb.content, i, MEM_ReadStringArray(buffer, i));
    end;
    MEM_Free(buffer);
};


/*
 * Obtain number of spells in a safe way
 */
func int Patch_FirstMageKit_GetMaxSpell() {
    var int symbPtr; var zCPar_Symbol symb;
    var int ret;

    // Get MAX_SPELL if exists
    symbPtr = MEM_GetSymbol("MAX_SPELL");
    if (symbPtr) {
        symb = _^(symbPtr);
        ret = symb.content;
    };

    // Get number of elements in spellFxInstanceNames
    symbPtr = MEM_GetSymbol("spellFxInstanceNames");
    if (symbPtr) {
        symb = _^(symbPtr);
        if (ret < (symb.bitfield & zCPar_Symbol_bitfield_ele)) {
            ret = (symb.bitfield & zCPar_Symbol_bitfield_ele);
        };
    } else {
        // That should be near impossible
        MEM_SendToSpy(zERR_TYPE_FATAL, "Symbol 'spellFxInstanceNames' not found.");
        return -1;
    };

    // Get number of elements in spellFxAniLetters
    symbPtr = MEM_GetSymbol("spellFxAniLetters");
    if (symbPtr) {
        symb = _^(symbPtr);
        if (ret < (symb.bitfield & zCPar_Symbol_bitfield_ele)) {
            ret = (symb.bitfield & zCPar_Symbol_bitfield_ele);
        };
    } else {
        // That should be near impossible
        MEM_SendToSpy(zERR_TYPE_FATAL, "Symbol 'spellFxAniLetters' not found.");
        return -1;
    };

    // Return the most number of elements
    return ret;
};


/*
 * Set MAX_SPELL if the symbol exists
 */
func void Patch_FirstMageKit_SetMaxSpell(var int value) {
    var int symbPtr; symbPtr = MEM_GetSymbol("MAX_SPELL");
    if (symbPtr) {
        var zCPar_Symbol symb; symb = _^(symbPtr);
        symb.content = value;
    };
};


/*
 * Add a new spell at "runtime" (kind of). Expects the static arrays to be already enlarged (see above)
 */
func void Patch_FirstMageKit_SetSpell(var int spellID, var string spellFxInst, var string spellFxAniLetter,
                                      var string spellTxt) {
    // Set static arrays
    MEM_WriteStatStringArr(spellFxInstanceNames, spellID, spellFxInst);
    MEM_WriteStatStringArr(spellFxAniLetters,    spellID, spellFxAniLetter);
    MEM_WriteStatStringArr(TXT_SPELLS,           spellID, spellTxt);
};


/*
 * Initialize the new spells
 */
func void Patch_FirstMageKit_CreateSpells() {
    const int NumNewSpells = 2;

    // Get MAX_SPELL (this constant might not exist in the mod, e.g. sometimes missing in translated scripts)
    var int MAX_SPELL; MAX_SPELL = Patch_FirstMageKit_GetMaxSpell();

    // Enlarge static arrays
    Patch_FirstMageKit_EnlargeStatStringArr(MEM_GetSymbol("spellFxInstanceNames"), MAX_SPELL + NumNewSpells);
    Patch_FirstMageKit_EnlargeStatStringArr(MEM_GetSymbol("spellFxAniLetters"),    MAX_SPELL + NumNewSpells);
    Patch_FirstMageKit_EnlargeStatStringArr(MEM_GetSymbol("TXT_SPELLS"),           MAX_SPELL + NumNewSpells);

    // Assign new spell ID
    SPL_FMKManaForLife = MAX_SPELL;
    SPL_FMKPickLock    = MAX_SPELL + 1;
    Patch_FirstMageKit_SetMaxSpell(MAX_SPELL + NumNewSpells);

    // Add spells
    Patch_FirstMageKit_SetSpell(SPL_FMKManaForLife, "FMKManaForLife", "SAC", NAME_SPL_FMKManaForLife);
    Patch_FirstMageKit_SetSpell(SPL_FMKPickLock,    "FMKPickLock",    "PY2", NAME_SPL_FMKPickLock);

    // Add mana processing calls
    HookDaedalusFuncS("Spell_ProcessMana",         "Patch_FirstMageKit_Spell_ProcessMana");
    HookDaedalusFuncS("Spell_ProcessMana_Release", "Patch_FirstMageKit_Spell_ProcessMana_Release");
};


/*
 * Additions to the mana processing functions
 */
func int Patch_FirstMageKit_Spell_ProcessMana(var int manaInvested) {
    var int activeSpell; activeSpell = Npc_GetActiveSpell(self);

    if (activeSpell == SPL_FMKManaForLife     ) { return Spell_Logic_FMKManaForLife(manaInvested);      };
    if (activeSpell == SPL_FMKPickLock        ) { return Spell_Logic_FMKPickLock(manaInvested);         };

    PassArgumentI(manaInvested);
    ContinueCall();
};
func int Patch_FirstMageKit_Spell_ProcessMana_Release(var int manaInvested) {
    const int SPL_SENDCAST = 2;

    var int activeSpell; activeSpell = Npc_GetActiveSpell(self);

    if (activeSpell == SPL_FMKManaForLife     ) { return SPL_SENDCAST;                                  };
    if (activeSpell == SPL_FMKPickLock        ) { return SPL_SENDCAST;                                  };

    PassArgumentI(manaInvested);
    ContinueCall();
};
