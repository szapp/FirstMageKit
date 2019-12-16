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
        } else if (Hlp_StrCmp(panName, "���������")) { // RU
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
const string Ninja_FirstMageKit_NAME_MageScroll       = "Scroll";


/*
 * Adjust texts to language
 */
func void Ninja_FirstMageKit_LocalizeTexts() {
    var int lang; lang = Ninja_FirstMageKit_GuessLocalization();
    if (lang == 1) { // DE
        NAME_SPL_FMKManaForLife                  = "Manasucht";
        NAME_SPL_FMKPickLock                     = "Entriegeln";
        Ninja_FirstMageKit_PRINT_NeverOpen       = "Da l�sst sich nichts machen";
        Ninja_FirstMageKit_PRINT_PICKLOCK_UNLOCK = "Das Schlo� ist geknackt";
        Ninja_FirstMageKit_PRINT_Hitpoints       = "Lebenspunktkosten:";
        Ninja_FirstMageKit_PRINT_Mana            = "Manasteigerung:";
        Ninja_FirstMageKit_NAME_MinManakosten    = "Manakosten (min):";
        Ninja_FirstMageKit_NAME_MageScroll       = "Spruchrolle";
    } else if (lang == 2) { // PL
        NAME_SPL_FMKManaForLife                  = "Ofiara krwi";
        NAME_SPL_FMKPickLock                     = "Otwieranie zamk�w";
        Ninja_FirstMageKit_PRINT_NeverOpen       = "Tego nie da si� otworzy�.";
        Ninja_FirstMageKit_PRINT_PICKLOCK_UNLOCK = "Zamek otwarty.";
        Ninja_FirstMageKit_PRINT_Hitpoints       = "Wydatek punkt�w trafie�:";
        Ninja_FirstMageKit_PRINT_Mana            = "Premia many:";
        Ninja_FirstMageKit_NAME_MinManakosten    = "Min. wydatek many:";
        Ninja_FirstMageKit_NAME_MageScroll       = "Zw�j";
    } else if (lang == 3) { // RU
        NAME_SPL_FMKManaForLife                  = "���������� ����";
        NAME_SPL_FMKPickLock                     = "����������";
        Ninja_FirstMageKit_PRINT_NeverOpen       = "��� ��� ������� �� �������.";
        Ninja_FirstMageKit_PRINT_PICKLOCK_UNLOCK = "����� ������.";
        Ninja_FirstMageKit_PRINT_Hitpoints       = "��������:";
        Ninja_FirstMageKit_PRINT_Mana            = "����:";
        Ninja_FirstMageKit_NAME_MinManakosten    = "������ ����:";
        Ninja_FirstMageKit_NAME_MageScroll       = "������";
    }; // Else: Keep default -> English
};
