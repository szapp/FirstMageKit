const int Value_Sc_FMKManaForLife = 250;
const int Value_Sc_FMKPickLock    =  10;

instance ItRu_FMKManaForLife (C_Item) {
    name                =   NAME_Rune;

    mainflag            =   ITEM_KAT_RUNE;
    flags               =   0;

    visual              =   "NINJA_FMK_MANAFORLIFE_RU_G2.3DS";
    material            =   MAT_STONE;

    spell               =   SPL_FMKManaForLife;

    mag_circle          =   3;

    wear                =   WEAR_EFFECT;
    effect              =   "SPELLFX_WEAKGLIMMER_RED";

    description         =   NAME_SPL_FMKManaForLife;
    TEXT    [0]         =   NAME_Mag_Circle;
    COUNT   [0]         =   mag_circle;

    TEXT    [1]         =   NAME_Spell_Invest;

    TEXT    [2]         =   Ninja_FirstMageKit_PRINT_Hitpoints;
    COUNT   [2]         =   1;

    TEXT    [3]         =   Ninja_FirstMageKit_PRINT_Mana;
    COUNT   [3]         =   SPL_FMKManaForLife_RELATION;
};

instance ItRu_FMKPickLock (C_Item) {
    name                =   NAME_Rune;

    mainflag            =   ITEM_KAT_RUNE;
    flags               =   0;

    visual              =   "NINJA_FMK_PICKLOCK_RU_G2.3DS";
    material            =   MAT_STONE;

    spell               =   SPL_FMKPickLock;

    mag_circle          =   1;

    wear                =   WEAR_EFFECT;
    effect              =   "SPELLFX_WEAKGLIMMER";

    description         =   NAME_SPL_FMKPickLock;
    TEXT    [0]         =   NAME_Mag_Circle;
    COUNT   [0]         =   mag_circle;

    TEXT    [1]         =   NAME_Spell_Invest;

    TEXT    [2]         =   Ninja_FirstMageKit_NAME_MinManakosten;
    COUNT   [2]         =   SPL_Cost_FMKPickLock;
};


instance ItSc_FMKManaForLife (C_Item) {
    name                =   NAME_Spruchrolle;

    mainflag            =   ITEM_KAT_RUNE;
    flags               =   ITEM_MULTI;

    value               =   Value_Sc_FMKManaForLife;

    visual              =   "NINJA_FMK_MANAFORLIFE_SC_G2.3DS";
    material            =   MAT_LEATHER;

    spell               =   SPL_FMKManaForLife;

    wear                =   WEAR_EFFECT;
    effect              =   "SPELLFX_WEAKGLIMMER_RED";

    description         =   NAME_SPL_FMKManaForLife;

    TEXT    [0]         =   Name_MageScroll;

    TEXT    [1]         =   NAME_Spell_Invest;

    TEXT    [2]         =   Ninja_FirstMageKit_PRINT_Hitpoints;
    COUNT   [2]         =   1;

    TEXT    [3]         =   Ninja_FirstMageKit_PRINT_Mana;
    COUNT   [3]         =   SPL_FMKManaForLife_RELATION;

    TEXT    [5]         =   NAME_Value;
    COUNT   [5]         =   value;
};

instance ItSc_FMKPickLock (C_Item) {
    name                =   NAME_Spruchrolle;

    mainflag            =   ITEM_KAT_RUNE;
    flags               =   ITEM_MULTI;

    value               =   Value_Sc_FMKPickLock;

    visual              =   "NINJA_FMK_PICKLOCK_SC_G2.3DS";
    material            =   MAT_LEATHER;

    spell               =   SPL_FMKPickLock;

    // Out! This messes with the ease of inserting the item
    //wear                =   WEAR_EFFECT;
    //effect              =   "SPELLFX_WEAKGLIMMER";

    description         =   NAME_SPL_FMKPickLock;

    TEXT    [0]         =   Name_MageScroll;

    TEXT    [1]         =   NAME_Spell_Invest;

    TEXT    [2]         =   Ninja_FirstMageKit_NAME_MinManakosten;
    COUNT   [2]         =   SPL_Cost_FMKPickLock;

    TEXT    [5]         =   NAME_Value;
    COUNT   [5]         =   value;
};
