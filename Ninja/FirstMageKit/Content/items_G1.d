const int Value_Sc_FMKManaForLife =   5;
const int Value_Sc_FMKPickLock    =  10;

instance ItRu_FMKManaForLife (C_Item) {
    name                =   Patch_FirstMageKit_NAME_Rune;

    mainflag            =   ITEM_KAT_RUNE;
    flags               =   0;

    visual              =   "PATCH_FMK_MANAFORLIFE_RU_G1.3DS";
    material            =   MAT_STONE;

    spell               =   SPL_FMKManaForLife;

    mag_circle          =   3;

    description         =   NAME_SPL_FMKManaForLife;
    TEXT    [0]         =   Patch_FirstMageKit_NAME_Mag_Circle;
    COUNT   [0]         =   mag_circle;

    TEXT    [1]         =   Patch_FirstMageKit_NAME_Spell_Invest;

    TEXT    [2]         =   Patch_FirstMageKit_PRINT_Hitpoints;
    COUNT   [2]         =   1;

    TEXT    [3]         =   Patch_FirstMageKit_PRINT_Mana;
    COUNT   [3]         =   SPL_FMKManaForLife_RELATION;
};

instance ItRu_FMKPickLock (C_Item) {
    name                =   Patch_FirstMageKit_NAME_Rune;

    mainflag            =   ITEM_KAT_RUNE;
    flags               =   0;

    visual              =   "PATCH_FMK_PICKLOCK_RU_G1.3DS";
    material            =   MAT_STONE;

    spell               =   SPL_FMKPickLock;

    mag_circle          =   1;

    description         =   NAME_SPL_FMKPickLock;
    TEXT    [0]         =   Patch_FirstMageKit_NAME_Mag_Circle;
    COUNT   [0]         =   mag_circle;

    TEXT    [1]         =   Patch_FirstMageKit_NAME_Spell_Invest;

    TEXT    [2]         =   Patch_FirstMageKit_NAME_MinManakosten;
    COUNT   [2]         =   SPL_Cost_FMKPickLock;
};


instance ItSc_FMKManaForLife (C_Item) {
    name                =   Patch_FirstMageKit_NAME_Spruchrolle;

    mainflag            =   ITEM_KAT_RUNE;
    flags               =   ITEM_MULTI;

    value               =   Value_Sc_FMKManaForLife;

    visual              =   "PATCH_FMK_MANAFORLIFE_SC_G1.3DS";
    material            =   MAT_LEATHER;

    spell               =   SPL_FMKManaForLife;

    description         =   NAME_SPL_FMKManaForLife;

    TEXT    [1]         =   Patch_FirstMageKit_NAME_Spell_Invest;

    TEXT    [2]         =   Patch_FirstMageKit_PRINT_Hitpoints;
    COUNT   [2]         =   1;

    TEXT    [3]         =   Patch_FirstMageKit_PRINT_Mana;
    COUNT   [3]         =   SPL_FMKManaForLife_RELATION;

    TEXT    [5]         =   Patch_FirstMageKit_NAME_Value;
    COUNT   [5]         =   value;
};

instance ItSc_FMKPickLock (C_Item) {
    name                =   Patch_FirstMageKit_NAME_Spruchrolle;

    mainflag            =   ITEM_KAT_RUNE;
    flags               =   ITEM_MULTI;

    value               =   Value_Sc_FMKPickLock;

    visual              =   "PATCH_FMK_PICKLOCK_SC_G1.3DS";
    material            =   MAT_LEATHER;

    spell               =   SPL_FMKPickLock;

    description         =   NAME_SPL_FMKPickLock;

    TEXT    [1]         =   Patch_FirstMageKit_NAME_Spell_Invest;

    TEXT    [2]         =   Patch_FirstMageKit_NAME_MinManakosten;
    COUNT   [2]         =   SPL_Cost_FMKPickLock;

    TEXT    [5]         =   Patch_FirstMageKit_NAME_Value;
    COUNT   [5]         =   value;
};
