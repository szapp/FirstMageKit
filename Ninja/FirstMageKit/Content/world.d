/*
 * Iterate over all containers in the world and add n items 'addItemInst' for all n items 'findItemInst' found
 */
func void Ninja_FirstMageKit_MatchItemInContainers(var string findItemInst, var string addItemInst) {
    const int zCWorld__SearchVobListByBaseClass_G1 =  6250016; //0x5F5E20
    const int zCWorld__SearchVobListByBaseClass_G2 =  6439712; //0x624320
    const int oCMobContainer__classDef_G1          =  9285504; //0x8DAF80
    const int oCMobContainer__classDef_G2          = 11212976; //0xAB18B0
    const int oCMobContainer__IsIn_G1              =  6833040; //0x684390
    const int oCMobContainer__IsIn_G2              =  7496896; //0x7264C0
    const int oCMobContainer__CreateContents_G1    =  6832208; //0x684050
    const int oCMobContainer__CreateContents_G2    =  7496080; //0x726190

    // Check if the instance even exists - if not, tough luck
    var int itemSymbID; itemSymbID = MEM_FindParserSymbol(findItemInst);
    if (itemSymbID == -1) {
        MEM_SendToSpy(zERR_TYPE_WARN, ConcatStrings("Instance not found: ", findItemInst));
        return;
    };
    var string contentStr; contentStr = ConcatStrings(STR_Upper(addItemInst), ":");

    // Create array that will contain all containers in the current world
    var int vobListPtr;  vobListPtr = MEM_ArrayCreate();
    var zCArray vobList; vobList    = _^(vobListPtr);

    // Search containers and fill the array
    var int vobTreePtr; vobTreePtr = _@(MEM_Vobtree);
    var int worldPtr;   worldPtr   = MEM_Game._zCSession_world;
    var int classDef;   classDef   = MEMINT_SwitchG1G2(oCMobContainer__classDef_G1, oCMobContainer__classDef_G2);
    const int call = 0;
    if (CALL_Begin(call)) {
        CALL_PtrParam(_@(vobTreePtr));
        CALL_PtrParam(_@(vobListPtr));
        CALL_PtrParam(_@(classDef));
        CALL__thiscall(_@(worldPtr), MEMINT_SwitchG1G2(zCWorld__SearchVobListByBaseClass_G1,
                                                       zCWorld__SearchVobListByBaseClass_G2));
        call = CALL_End();
    };

    // Iterate over all containers
    repeat(i, vobList.numInArray); var int i;
        var int containerPtr; containerPtr = MEM_ReadIntArray(vobList.array, i);
        const int call2 = 0;
        if (CALL_Begin(call2)) {
            CALL_PtrParam(_@(itemSymbID));
            CALL_PutRetValTo(_@(amount));
            CALL__thiscall(_@(containerPtr), MEMINT_SwitchG1G2(oCMobContainer__IsIn_G1, oCMobContainer__IsIn_G2));
            call2 = CALL_End();
        };

        var int amount;
        if (amount < 1) {
            continue;
        };

        var string contentStrNum; contentStrNum = ConcatStrings(contentStr, IntToString(amount));
        var int contentStrPtr; contentStrPtr = _@s(contentStrNum);

        const int call3 = 0;
        if (CALL_Begin(call3)) {
            CALL_PtrParam(_@(contentStrPtr));
            CALL__thiscall(_@(containerPtr), MEMINT_SwitchG1G2(oCMobContainer__CreateContents_G1,
                                                               oCMobContainer__CreateContents_G2));
            call3 = CALL_End();
        };
    end;

    // Free container array
    MEM_ArrayFree(vobListPtr);
};


/*
 * Make the patch come to life, by adding the spell items in appropriate manner (into inventory/placed into containers)
 */
func void Ninja_FirstMageKit_PlaceSpellItems() {
    // On very first time add the mana for life spell (as rune) to the player inventory
    var int loaded;
    if (!loaded) {
        // Wait for player to be spawned
        FF_ApplyOnceExt(Ninja_FirstMageKit_AddRuneOnce, 1, 1);
        loaded = 1;
    };

    // Do the following for each world only once. To check this, we use a neat trick here (explained below)
    if (!Hlp_IsValidItem(ItSc_PickLock)) {

        // For any lock pick in any container in the world add the same number of lock pick spells
        if (GOTHIC_BASE_VERSION == 1) {
            Ninja_FirstMageKit_MatchItemInContainers("ItKeLockpick", "ItSc_PickLock");
        } else {
            Ninja_FirstMageKit_MatchItemInContainers("ItKe_Lockpick", "ItSc_PickLock");
        };

        // Now mark this world as processed by inserting an item. This item will stay in the world throughout saving and
        // loading, and we'll know next time that we already added the scrolls here. This method is more convenient than
        // checking variables, because we'd need one variable per unknown number(!) of worlds.
        // But it's best do to this once the player exists. So let's wait for that, see function below.
        FF_ApplyOnceExt(Ninja_FirstMageKit_AddIndicatorOnce, 1, 1);
    };
};


/*
 * Add an indicator item into the world - for each world only once ever. This function is called from init
 */
func void Ninja_FirstMageKit_AddIndicatorOnce() {
    // That's all:
    Wld_InsertItem(ItSc_PickLock, MEM_FARFARAWAY);

    // Sugar:
    // Since we are dealing with who-knows-what kind of mods that might not have the waypoint "TOT", the item would
    // be spawned at origin (0,0,0) which might be accessible to the player. So we'll move the item into the abyss.
    var zCTree newTreeNode; newTreeNode = _^(MEM_World.globalVobTree_firstChild);
    var int itmPtr; itmPtr = newTreeNode.data;
    var zCVob itm; itm = _^(itmPtr);
    itm.bitfield[0] = itm.bitfield[0] & ~(zCVob_bitfield0_collDetectionStatic | zCVob_bitfield0_collDetectionDynamic);
    const int zCVob__Move_G1 = 6217184; //0x5EDDE0
    const int zCVob__Move_G2 = 6402784; //0x61B2E0
    const int abyss = -636609590;
    const int call = 0;
    if (CALL_Begin(call)) {
        CALL_FloatParam(_@(FLOATNULL));   // Z
        CALL_FloatParam(_@(abyss));       // Y Very negative integer float
        CALL_FloatParam(_@(FLOATNULL));   // X
        CALL__thiscall(_@(itmPtr), MEMINT_SwitchG1G2(zCVob__Move_G1, zCVob__Move_G2));
        call = CALL_End();
    };
};


/*
 * Add the mana for life spell (as rune) to the player inventory - only once ever. This function is called from init
 */
func void Ninja_FirstMageKit_AddRuneOnce() {
    CreateInvItem(hero, ItRu_ManaForLife);
};
