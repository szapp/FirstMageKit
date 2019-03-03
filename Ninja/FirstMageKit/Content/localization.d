/*
 * Guess localization (0 = EN, 1 = DE, 2 = PL, 3 = RU)
 */
func int Ninja_FirstMageKit_GuessLocalization() {
    var int pan; pan = MEM_GetSymbol("MOBNAME_PAN");
    if (pan) {
        var zCPar_Symbol panSymb; panSymb = _^(pan);
        var string panName; panName = MEM_ReadString(panSymb.content);
        if (Hlp_StrCmp(panName, "Pfanne")) { // DE
            return 1;
        } else if (Hlp_StrCmp(panName, "Patelnia")) { // PL
            return 2;
        } else if (Hlp_StrCmp(panName, "Ñêîâîğîäà")) { // RU
            return 3;
        };
    };
    return 0; // Otherwise EN
};


/*
 * Texts to be localized (default: English)
 */
const string NAME_SPL_FMKManaForLife                  = "Mana surge";
const string NAME_SPL_FMKPickLock                     = "Unlock";
const string Ninja_FirstMageKit_PRINT_NeverOpen       = "It will never open.";
const string Ninja_FirstMageKit_PRINT_PICKLOCK_UNLOCK = "The lock's open.";
const string Ninja_FirstMageKit_PRINT_Hitpoints       = "Hitpoint cost:";
const string Ninja_FirstMageKit_PRINT_Mana            = "Mana increase:";
const string Ninja_FirstMageKit_NAME_MinManakosten    = "Mana cost (min):";


/*
 * Adjust texts to language
 */
func void Ninja_FirstMageKit_LocalizeTexts() {
    var int lang; lang = Ninja_FirstMageKit_GuessLocalization();
    if (lang == 1) { // DE
        NAME_SPL_FMKManaForLife                  = "Manasucht";
        NAME_SPL_FMKPickLock                     = "Entriegeln";
        Ninja_FirstMageKit_PRINT_NeverOpen       = "Da lässt sich nichts machen";
        Ninja_FirstMageKit_PRINT_PICKLOCK_UNLOCK = "Das Schloß ist geknackt";
        Ninja_FirstMageKit_PRINT_Hitpoints       = "Lebenspunktkosten:";
        Ninja_FirstMageKit_PRINT_Mana            = "Manasteigerung:";
        Ninja_FirstMageKit_NAME_MinManakosten    = "Manakosten (min):";
    } else if (lang == 2) { // PL
        NAME_SPL_FMKManaForLife                  = "Gwa³towny wzrost mana";
        NAME_SPL_FMKPickLock                     = "Odblokowaå";
        Ninja_FirstMageKit_PRINT_NeverOpen       = "Tego nie da siê otworzyæ.";
        Ninja_FirstMageKit_PRINT_PICKLOCK_UNLOCK = "Zamek otwarty.";
        Ninja_FirstMageKit_PRINT_Hitpoints       = "Wydatek punkty trafieñ:";
        Ninja_FirstMageKit_PRINT_Mana            = "Premia many:";
        Ninja_FirstMageKit_NAME_MinManakosten    = "Wydatek many:";
    } else if (lang == 3) { // RU
        NAME_SPL_FMKManaForLife                  = "óâåëè÷åíèå ìàíû";
        NAME_SPL_FMKPickLock                     = "ğàñöåïëÿòü";
        Ninja_FirstMageKit_PRINT_NeverOpen       = "İòî ìíå íèêîãäà íå îòêğûòü.";
        Ninja_FirstMageKit_PRINT_PICKLOCK_UNLOCK = "Çàìîê îòêğûò.";
        Ninja_FirstMageKit_PRINT_Hitpoints       = "Çäîğîâüå:";
        Ninja_FirstMageKit_PRINT_Mana            = "Ìàíà:";
        Ninja_FirstMageKit_NAME_MinManakosten    = "Ğàñõîä ìàíû:";
    }; // Else: Keep default -> English
};
