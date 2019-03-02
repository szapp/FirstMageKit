/*
 * Add a new spell at "runtime" (kind of). Expects the static arrays to be already enlarged (enlargeStatStringArr)
 */
func int Ninja_Spells_SetSpell(var string spellFxInst, var string spellFxAniLetter, var string spellTxt) {
    // Increase index
    var int spellID; spellID = MAX_SPELL;
    MAX_SPELL += 1;

    // Set static arrays
    MEM_WriteStatStringArr(spellFxInstanceNames, spellID, spellFxInst);
    MEM_WriteStatStringArr(spellFxAniLetters,    spellID, spellFxAniLetter);
    MEM_WriteStatStringArr(TXT_SPELLS,           spellID, spellTxt);

    return spellID;
};
