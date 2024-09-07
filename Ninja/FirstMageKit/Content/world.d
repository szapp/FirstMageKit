/*
 * Iterate over all containers in the world and add n items 'addItemInst' for all n items 'findItemInst' found
 */
func void Patch_FirstMageKit_MatchItemInContainers(var string findItemInst, var string addItemInst) {
    const int zCWorld__SearchVobListByBaseClass[4] = {/*G1*/ 6250016, /*G1A*/6385120, /*G2*/6408896, /*G2A*/ 6439712};
    const int oCMobContainer__classDef[4]          = {/*G1*/ 9285504, /*G1A*/9576984, /*G2*/9970696, /*G2A*/11212976};
    const int oCMobContainer__IsIn[4]              = {/*G1*/ 6833040, /*G1A*/7028576, /*G2*/7111728, /*G2A*/ 7496896};
    const int oCMobContainer__CreateContents[4]    = {/*G1*/ 6832208, /*G1A*/7027648, /*G2*/7110912, /*G2A*/ 7496080};

    // Check if the instance even exists - if not, tough luck
    var int itemSymbID; itemSymbID = MEM_FindParserSymbol(findItemInst);
    if (itemSymbID == -1) {
        MEM_SendToSpy(zERR_TYPE_WARN, ConcatStrings("FirstMageKit: Instance not found: ", findItemInst));
        return;
    };
    var string contentStr; contentStr = ConcatStrings(STR_Upper(addItemInst), ":");

    // Create array that will contain all containers in the current world
    var int vobListPtr;  vobListPtr = MEM_ArrayCreate();
    var zCArray vobList; vobList    = _^(vobListPtr);

    // Search containers and fill the array
    var int vobTreePtr; vobTreePtr = _@(MEM_Vobtree);
    var int worldPtr;   worldPtr   = MEM_Game._zCSession_world;
    var int addedTotal; addedTotal = 0;
    const int call = 0;
    if (CALL_Begin(call)) {
        CALL_PtrParam(_@(vobTreePtr));
        CALL_PtrParam(_@(vobListPtr));
        CALL_PtrParam(_@(oCMobContainer__classDef[FMK_EXE]));
        CALL__thiscall(_@(worldPtr), zCWorld__SearchVobListByBaseClass[FMK_EXE]);
        call = CALL_End();
    };

    // Iterate over all containers
    repeat(i, vobList.numInArray); var int i;
        var int containerPtr; containerPtr = MEM_ReadIntArray(vobList.array, i);
        const int call2 = 0;
        if (CALL_Begin(call2)) {
            CALL_PtrParam(_@(itemSymbID));
            CALL_PutRetValTo(_@(amount));
            CALL__thiscall(_@(containerPtr), oCMobContainer__IsIn[FMK_EXE]);
            call2 = CALL_End();
        };

        var int amount;
        if (amount < 1) {
            continue;
        };

        addedTotal += amount;
        var string contentStrNum; contentStrNum = ConcatStrings(contentStr, IntToString(amount));
        var int contentStrPtr; contentStrPtr = _@s(contentStrNum);

        const int call3 = 0;
        if (CALL_Begin(call3)) {
            CALL_PtrParam(_@(contentStrPtr));
            CALL__thiscall(_@(containerPtr), oCMobContainer__CreateContents[FMK_EXE]);
            call3 = CALL_End();
        };

    end;

    if (addedTotal > 0) {
        var string msg; msg = "FirstMageKit: Added ";
        msg = ConcatStrings(msg, IntToString(addedTotal));
        msg = ConcatStrings(msg, " ");
        msg = ConcatStrings(msg, addItemInst);
        msg = ConcatStrings(msg, " items to containers");
        MEM_Info(msg);
    };

    // Free container array
    MEM_ArrayFree(vobListPtr);
};


/*
 * Make the patch come to life, by adding the spell items in appropriate manner (into inventory/placed into containers)
 */
func void Patch_FirstMageKit_PlaceSpellItems() {
    // On very first time add the mana for life spell (as rune) to the player inventory
    var int loaded;
    if (!loaded) {
        // Wait for player to be spawned
        HookEngineF(oCGame__Render, 7, Patch_FirstMageKit_AddRuneOnce);
        loaded = 1;
    };

    // Do the following for each world only once. To check this, we use a neat trick here (explained below)
    if (!Hlp_IsValidItem(ItSc_FMKPickLock)) {

        // Only add it if it does not exist in the mod already
        if (MEM_GetSymbol("SPL_PickLock")) {
            return;
        };

        // For any lock pick in any container in the world add the same number of lock pick spells
        if (GOTHIC_BASE_VERSION == 1) {
            Patch_FirstMageKit_MatchItemInContainers("ItKeLockpick", "ItSc_FMKPickLock");
        } else {
            Patch_FirstMageKit_MatchItemInContainers("ItKe_Lockpick", "ItSc_FMKPickLock");
        };

        // Now mark this world as processed by inserting an item. This item will stay in the world throughout saving and
        // loading, and we'll know next time that we already added the scrolls here. This method is more convenient than
        // checking variables, because we'd need one variable per unknown number(!) of worlds.
        // But it's best do to this once the player exists. So let's wait for that, see function below.
        HookEngineF(oCGame__Render, 7, Patch_FirstMageKit_AddIndicatorOnce);
    };
};


/*
 * Add an indicator item into the world - for each world only once ever. This function is called from init
 */
func void Patch_FirstMageKit_AddIndicatorOnce() {
    RemoveHookF(oCGame__Render, 0, Patch_FirstMageKit_AddIndicatorOnce);

    // That's all:
    Wld_InsertItem(ItSc_FMKPickLock, MEM_FARFARAWAY);

    // Sugar:
    // Since we are dealing with who-knows-what kind of mods that might not have the waypoint "TOT", the item would
    // be spawned at origin (0,0,0) which might be accessible to the player. So we'll move the item into the abyss.
    var zCTree newTreeNode; newTreeNode = _^(MEM_World.globalVobTree_firstChild);
    var int itmPtr; itmPtr = newTreeNode.data;
    var zCVob itm; itm = _^(itmPtr);
    itm.bitfield[0] = itm.bitfield[0] & ~(zCVob_bitfield0_collDetectionStatic | zCVob_bitfield0_collDetectionDynamic);
    const int zCVob__Move[4] = {/*G1*/6217184, /*G1A*/6350240, /*G2*/6372384, /*G2A*/6402784};
    const int abyss = -636609590; // Around -1e16
    const int call = 0;
    if (CALL_Begin(call)) {
        CALL_FloatParam(_@(FLOATNULL));   // Z
        CALL_FloatParam(_@(abyss));       // Y Very negative integer float
        CALL_FloatParam(_@(FLOATNULL));   // X
        CALL__thiscall(_@(itmPtr), zCVob__Move[FMK_EXE]);
        call = CALL_End();
    };
};


/*
 * Add the mana for life spell (as rune) to the player inventory - only once ever. This function is called from init
 */
func void Patch_FirstMageKit_AddRuneOnce() {
    RemoveHookF(oCGame__Render, 0, Patch_FirstMageKit_AddRuneOnce);
    if (!MEM_GetSymbol("SPL_ManaForLife")) {
        // Only add it if it does not exist in the mod already
        CreateInvItem(hero, ItRu_FMKManaForLife);
    };
};
