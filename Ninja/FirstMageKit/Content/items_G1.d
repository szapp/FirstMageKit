const int Value_Sc_ManaForLife =   5;
const int Value_Sc_PickLock    =  10;

instance ItRu_ManaForLife (C_Item) {
    name                =   NAME_Rune;

    mainflag            =   ITEM_KAT_RUNE;
    flags               =   0;

    visual              =   "NINJA_FMK_MANAFORLIFE_RU_G1.3DS";
    material            =   MAT_STONE;

    spell               =   SPL_ManaForLife;

    mag_circle          =   3;

    description         =   NAME_SPL_ManaForLife;
    TEXT    [0]         =   NAME_Mag_Circle;
    COUNT   [0]         =   mag_circle;

    TEXT    [1]         =   NAME_Spell_Invest;

    TEXT    [2]         =   Ninja_FirstMageKit_PRINT_Hitpoints;
    COUNT   [2]         =   1;

    TEXT    [3]         =   Ninja_FirstMageKit_PRINT_Mana;
    COUNT   [3]         =   SPL_ManaForLife_RELATION;
};

instance ItRu_PickLock (C_Item) {
    name                =   NAME_Rune;

    mainflag            =   ITEM_KAT_RUNE;
    flags               =   0;

    visual              =   "NINJA_FMK_PICKLOCK_RU_G1.3DS";
    material            =   MAT_STONE;

    spell               =   SPL_PickLock;

    mag_circle          =   1;

    description         =   NAME_SPL_PickLock;
    TEXT    [0]         =   NAME_Mag_Circle;
    COUNT   [0]         =   mag_circle;

    TEXT    [1]         =   NAME_Spell_Invest;

    TEXT    [2]         =   Ninja_FirstMageKit_NAME_MinManakosten;
    COUNT   [2]         =   SPL_Cost_PickLock;
};


instance ItSc_ManaForLife (C_Item) {
    name                =   NAME_Spruchrolle;

    mainflag            =   ITEM_KAT_RUNE;
    flags               =   ITEM_MULTI;

    value               =   Value_Sc_ManaForLife;

    visual              =   "NINJA_FMK_MANAFORLIFE_SC_G1.3DS";
    material            =   MAT_LEATHER;

    spell               =   SPL_ManaForLife;

    description         =   NAME_SPL_ManaForLife;

    TEXT    [1]         =   NAME_Spell_Invest;

    TEXT    [2]         =   Ninja_FirstMageKit_PRINT_Hitpoints;
    COUNT   [2]         =   1;

    TEXT    [3]         =   Ninja_FirstMageKit_PRINT_Mana;
    COUNT   [3]         =   SPL_ManaForLife_RELATION;

    TEXT    [5]         =   NAME_Value;
    COUNT   [5]         =   value;
};

instance ItSc_PickLock (C_Item) {
    name                =   NAME_Spruchrolle;

    mainflag            =   ITEM_KAT_RUNE;
    flags               =   ITEM_MULTI;

    value               =   Value_Sc_PickLock;

    visual              =   "NINJA_FMK_PICKLOCK_SC_G1.3DS";
    material            =   MAT_LEATHER;

    spell               =   SPL_PickLock;

    description         =   NAME_SPL_PickLock;

    TEXT    [1]         =   NAME_Spell_Invest;

    TEXT    [2]         =   Ninja_FirstMageKit_NAME_MinManakosten;
    COUNT   [2]         =   SPL_Cost_PickLock;

    TEXT    [5]         =   NAME_Value;
    COUNT   [5]         =   value;
};
