const int Value_Ru_ManaForLife = 1500;
const int Value_Ru_PickLock    = 1500;
const int Value_Sc_ManaForLife =  200;
const int Value_Sc_PickLock    =  200;

instance ItRu_ManaForLife (C_Item) {
    name                =   NAME_Rune;

    mainflag            =   ITEM_KAT_RUNE;
    flags               =   0;

    value               =   Value_Ru_ManaForLife;

    visual              =   "NINJA_FMK_MANAFORLIFE_RU.3DS";
    material            =   MAT_STONE;

    spell               =   SPL_ManaForLife;

    mag_circle          =   3;

    wear                =   WEAR_EFFECT;
    effect              =   "SPELLFX_WEAKGLIMMER_RED";

    description         =   NAME_SPL_ManaForLife;
    TEXT    [0]         =   NAME_Mag_Circle;
    COUNT   [0]         =   mag_circle;

    TEXT    [1]         =   NAME_Spell_Invest;

    TEXT    [2]         =   ConcatStrings(PRINT_Beliarshitpoints_MAX, "1");

    TEXT    [3]         =   ConcatStrings(PRINT_LearnMANA_MAX, IntToString(SPL_ManaForLife_RELATION));

    TEXT    [5]         =   NAME_Value;
    COUNT   [5]         =   value;
};

instance ItRu_PickLock (C_Item) {
    name                =   NAME_Rune;

    mainflag            =   ITEM_KAT_RUNE;
    flags               =   0;

    value               =   Value_Ru_PickLock;

    visual              =   "NINJA_FMK_PICKLOCK_RU.3DS";
    material            =   MAT_STONE;

    spell               =   SPL_PickLock;

    mag_circle          =   1;

    wear                =   WEAR_EFFECT;
    effect              =   "SPELLFX_WEAKGLIMMER";

    description         =   NAME_SPL_PickLock;
    TEXT    [0]         =   NAME_Mag_Circle;
    COUNT   [0]         =   mag_circle;

    TEXT    [1]         =   NAME_Spell_Invest;

    TEXT    [2]         =   NAME_MinManakosten;
    COUNT   [2]         =   SPL_Cost_PickLock;

    TEXT    [5]         =   NAME_Value;
    COUNT   [5]         =   value;
};


instance ItSc_ManaForLife (C_Item) {
    name                =   NAME_Spruchrolle;

    mainflag            =   ITEM_KAT_RUNE;
    flags               =   ITEM_MULTI;

    value               =   Value_Sc_ManaForLife;

    visual              =   "NINJA_FMK_MANAFORLIFE_SC.3DS";
    material            =   MAT_LEATHER;

    spell               =   SPL_ManaForLife;

    wear                =   WEAR_EFFECT;
    effect              =   "SPELLFX_WEAKGLIMMER_RED";

    description         =   NAME_SPL_ManaForLife;

    TEXT    [0]         =   Name_MageScroll;

    TEXT    [1]         =   NAME_Spell_Invest;

    TEXT    [2]         =   ConcatStrings(PRINT_Beliarshitpoints_MAX, "1");

    TEXT    [3]         =   ConcatStrings(PRINT_LearnMANA_MAX, IntToString(SPL_ManaForLife_RELATION));

    TEXT    [5]         =   NAME_Value;
    COUNT   [5]         =   value;
};

instance ItSc_PickLock (C_Item) {
    name                =   NAME_Spruchrolle;

    mainflag            =   ITEM_KAT_RUNE;
    flags               =   ITEM_MULTI;

    value               =   Value_Sc_PickLock;

    visual              =   "NINJA_FMK_PICKLOCK_SC.3DS";
    material            =   MAT_LEATHER;

    spell               =   SPL_PickLock;

    wear                =   WEAR_EFFECT;
    effect              =   "SPELLFX_WEAKGLIMMER";

    description         =   NAME_SPL_PickLock;

    TEXT    [0]         =   Name_MageScroll;

    TEXT    [1]         =   NAME_Spell_Invest;

    TEXT    [2]         =   NAME_MinManakosten;
    COUNT   [2]         =   SPL_Cost_PickLock;

    TEXT    [5]         =   NAME_Value;
    COUNT   [5]         =   value;
};
