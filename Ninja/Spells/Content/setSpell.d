/*
 * Add a new spell at "runtime" (kind of). Expects the static arrays to be already enlarged (enlargeStatStringArr)
 */
func int Ninja_Spells_SetSpell(var string spellFxInst, var string spellFxAniLetter, var string spellTxt,
                               var string itemRuneInst, var string itemScrollInst) {
    // Increase index
    var int spellID; spellID = MAX_SPELL;
    MAX_SPELL += 1;

    // Set static arrays
    MEM_WriteStatStringArr(spellFxInstanceNames, spellID, spellFxInst);
    MEM_WriteStatStringArr(spellFxAniLetters,    spellID, spellFxAniLetter);
    MEM_WriteStatStringArr(TXT_SPELLS,           spellID, spellTxt);

    // Overwrite item instances 'spell' variable - assumed to be first on code stack
    var zCPar_Symbol symb;
    var int stackpos;
    if (!Hlp_StrCmp(itemRuneInst, "")) {
        symb = _^(MEM_GetSymbol(itemRuneInst));
        stackpos = symb.content + currParserStackAddress + /*zPAR_TOK_PUSHINT*/ 1;
        if (MEM_ReadInt(stackpos) == 999) {
            MEM_WriteInt(stackpos, spellID);
        };
    };

    if (!Hlp_StrCmp(itemScrollInst, "")) {
        symb = _^(MEM_GetSymbol(itemScrollInst));
        stackpos = symb.content + currParserStackAddress + /*zPAR_TOK_PUSHINT*/ 1;
        if (MEM_ReadInt(stackpos) == 999) {
            MEM_WriteInt(stackpos, spellID);
        };
    };

    return spellID;
};
