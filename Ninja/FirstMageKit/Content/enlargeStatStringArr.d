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
