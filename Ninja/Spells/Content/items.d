const int Value_Ru_ManaForLife = 1500;
const int Value_Sc_ManaForLife =  200;

instance ItRu_ManaForLife (C_Item) {
    spell               =   999; // Has to be 999 and has to be first entry!

    name                =   NAME_Rune;

    mainflag            =   ITEM_KAT_RUNE;
    flags               =   0;

    value               =   Value_Ru_ManaForLife;

    visual              =   "ItRu_ManaForLife.3DS";
    material            =   MAT_STONE;

    mag_circle          =   3;

    wear                =   WEAR_EFFECT;
    effect              =   "SPELLFX_WEAKGLIMMER_RED";

    description         =   NAME_SPL_ManaForLife;
    TEXT    [0]         =   NAME_Mag_Circle;
    COUNT   [0]         =   mag_circle;

    TEXT    [1]         =   NAME_Spell_Invest;

    TEXT    [2]         =   ConcatStrings(PRINT_Beliarshitpoints_MAX, "1");

    TEXT    [3]         =   ConcatStrings(PRINT_LearnMANA_MAX,
                                IntToString(SPL_ManaForLife_RELATION));

    TEXT    [5]         =   NAME_Value;
    COUNT   [5]         =   value;
};


instance ItSc_ManaForLife (C_Item) {
    spell               =   999; // Has to be 999 and has to be first entry!

    name                =   NAME_Spruchrolle;

    mainflag            =   ITEM_KAT_RUNE;
    flags               =   ITEM_MULTI;

    value               =   Value_Sc_ManaForLife;

    visual              =   "ItSc_ManaForLife.3DS";
    material            =   MAT_LEATHER;

    wear                =   WEAR_EFFECT;
    effect              =   "SPELLFX_WEAKGLIMMER_RED";

    description         =   NAME_SPL_ManaForLife;

    TEXT    [0]         =   Name_MageScroll;

    TEXT    [1]         =   NAME_Spell_Invest;

    TEXT    [2]         =   ConcatStrings(PRINT_Beliarshitpoints_MAX, "1");

    TEXT    [3]         =   ConcatStrings(PRINT_LearnMANA_MAX,
                                IntToString(SPL_ManaForLife_RELATION));

    TEXT    [5]         =   NAME_Value;
    COUNT   [5]         =   value;
};
