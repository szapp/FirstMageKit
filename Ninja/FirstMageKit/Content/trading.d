/*
 * Check whether items of specific mainflag are in container
 */
func int Ninja_FirstMageKit_ContainerSearchMainflag(var int containerPtr, var int mainflag) {
    if (!containerPtr) {
        return 0;
    };

    var int list; list = MEM_ReadInt(containerPtr+/*contents*/4);
    var zCListSort l;
    while(list);
        l = _^(list);
        list = l.next;
        if (Hlp_Is_oCItem(l.data)) {
            var oCItem itm; itm = _^(l.data);
            if (itm.mainflag & mainflag) {
                return TRUE;
            };
        };
    end;
    return FALSE;
};


/*
 * Implement hook for trading (initialization function)
 */
func void Ninja_FirstMageKit_SetupTrading() {
    if (MEM_GetSymbol("SPL_PickLock")) {
        // Only add it if it does not exist in the mod already
        return;
    };

    const int oCInformationManager__OnTradeBegin_setNpc_G1 = 7528916; //0x72E1D4
    const int oCInformationManager__OnTradeBegin_setNpc_G2 = 6696756; //0x662F34
    HookEngineF(+MEMINT_SwitchG1G2(oCInformationManager__OnTradeBegin_setNpc_G1,
                                   oCInformationManager__OnTradeBegin_setNpc_G2), 6, Ninja_FirstMageKit_AddSPLOnTrade);

    // Adjust value of scroll to match lock pick item
    var int valueSymbPtr;
    if (GOTHIC_BASE_VERSION == 1) {
        valueSymbPtr = MEM_GetSymbol("Value_Dietrich");
    } else {
        valueSymbPtr = MEM_GetSymbol("Value_Lockpick");
    };
    if (valueSymbPtr) {
        var zCPar_Symbol valueSymb; valueSymb = _^(valueSymbPtr);
        Value_Sc_FMKPickLock = valueSymb.content;
    };
};


/*
 * Supply (mage) traders with lock pick scrolls (on opening trading)
 */
func void Ninja_FirstMageKit_AddSPLOnTrade() {
    // Minimum number of spells for traders to have
    const int TraderMinSpells = 5;

    var oCNpc npc; npc = _^(MEM_ReadInt(ESI+32)); // oCInformationManager->npc

    // We only want to give trader NPCs scrolls who trade with magic goods
    if (GOTHIC_BASE_VERSION == 1) {
        if (!NPC_GetInvItemBySlot(npc, INV_RUNE, 0)) {
            return;
        };
    } else {
        // Gothic 2 lacks internal inventory categories - do it the hard way
        if (!Ninja_FirstMageKit_ContainerSearchMainflag(_@(npc.inventory2_vtbl), ITEM_KAT_RUNE)) {
            return;
        };
    };

    // Giving negative number of items actually removes them from the inventory (Gothic 1)
    var int amount; amount = TraderMinSpells - Npc_HasItems(npc, ItSc_FMKPickLock);
    if (amount > 0) {
        CreateInvItems(npc, ItSc_FMKPickLock, amount);
    };
};
