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
