/*
 * Check whether items of specific mainflag are in container
 */
func int Patch_FirstMageKit_ContainerSearchMainflag(var int containerPtr, var int mainflag) {
    if (!containerPtr) {
        return 0;
    };

    const int oCItemContainer_contents_offset = 4;

    var int list; list = MEM_ReadInt(containerPtr+oCItemContainer_contents_offset);
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
func void Patch_FirstMageKit_SetupTrading() {
    if (MEM_GetSymbol("SPL_PickLock")) {
        // Only add it if it does not exist in the mod already
        return;
    };

    const int oCInformationManager__OnTradeBegin_setNpc[4] = {/*G1*/7528916, /*G1A*/7784467, /*G2*/7838996, /*G2A*/6696756};
    HookEngineF(oCInformationManager__OnTradeBegin_setNpc[FMK_EXE], 6, Patch_FirstMageKit_AddSPLOnTrade);

    // Adjust value of scroll to match lock pick item
    var int valueSymbPtr;
    if (GOTHIC_BASE_VERSION == 1) || (GOTHIC_BASE_VERSION == 112) {
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
func void Patch_FirstMageKit_AddSPLOnTrade() {
    const int INV_RUNE      = 3;
    const int ITEM_KAT_RUNE = 1 << 9;

    // Minimum number of spells for traders to have
    const int TraderMinSpells = 5;
    const int oCInformationManager_npc_offset = 32;

    var oCNpc npc; npc = _^(MEM_ReadInt(ESI + oCInformationManager_npc_offset));

    // We only want to give scrolls to trader NPCs who trade with magic goods
    if (GOTHIC_BASE_VERSION == 1) || (GOTHIC_BASE_VERSION == 112) {
        if (!NPC_GetInvItemBySlot(npc, INV_RUNE, 0)) {
            return;
        };
    } else {
        // Gothic 2 lacks internal inventory categories - do it the hard way
        if (!Patch_FirstMageKit_ContainerSearchMainflag(_@(npc.inventory2_vtbl), ITEM_KAT_RUNE)) {
            return;
        };
    };

    // Giving negative number of items actually removes them from the inventory (Gothic 1)
    var int amount; amount = TraderMinSpells - Npc_HasItems(npc, ItSc_FMKPickLock);
    if (amount > 0) {
        MEM_Info("FirstMageKit: Replenishing trader inventory with lock picking spells");
        CreateInvItems(npc, ItSc_FMKPickLock, amount);
    };
};
