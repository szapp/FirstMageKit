/*
 * Menu initialization function called by Ninja every time a menu is opened
 *
 * Here used to inject initialization before very first new game/loading once
 */
func void Ninja_FirstMageKit_Menu(var int menuPtr) {
    const int once = 0;
    if (once) {
        return;
    };
    once = 1;

    MEM_InitAll();

    Ninja_FirstMageKit_LocalizeTexts();
    Ninja_FirstMageKit_CreateSpells();
    Ninja_FirstMageKit_SetupTrading();

    // Retrieve rate from ini
    SPL_FMKManaForLife_RELATION = STR_ToInt(MEM_GetGothOpt("MANAFORLIFE", "hpPerOneMana"));
    if (SPL_FMKManaForLife_RELATION < 1) { // Force positive values
        SPL_FMKManaForLife_RELATION = MEMINT_SwitchG1G2(10, 2); // Default values
        MEM_SetGothOpt("MANAFORLIFE", "hpPerOneMana", IntToString(SPL_FMKManaForLife_RELATION));
    };

    // Has to be initialized before first loading (Ninja_FirstMageKit_Init is too late)
    Spell_FMKManaForLife_Init();
};


/*
 * Initialization function called by Ninja after "Init_Global" (G2) / "Init_<Levelname>" (G1)
 */
func void Ninja_FirstMageKit_Init() {
    // Wrapper for "LeGo_Init" to ensure correct LeGo initialization without breaking the mod
    LeGo_MergeFlags(LeGo_FrameFunctions);

    Spell_FMKManaForLife_Init();
    Spell_FMKPickLock_Init();
    Ninja_FirstMageKit_PlaceSpellItems();
};
