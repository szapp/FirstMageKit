/*
 * Guess localization (0 = EN, 1 = DE, 2 = PL, 3 = RU)
 * Source: https://github.com/szapp/Ninja/wiki/Inject-Changes#localization
 */
func int Ninja_FirstMageKit_GuessLocalization() {
    var int pan; pan = MEM_GetSymbol("MOBNAME_PAN");
    if (pan) {
        var zCPar_Symbol panSymb; panSymb = _^(pan);
        var string panName; panName = MEM_ReadString(panSymb.content);
        if (Hlp_StrCmp(panName, "Pfanne")) { // DE (Windows 1252)
            return 1;
        } else if (Hlp_StrCmp(panName, "Patelnia")) { // PL (Windows 1250)
            return 2;
        } else if (Hlp_StrCmp(panName, "���������")) { // RU (Windows 1251)
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
const string Ninja_FirstMageKit_NAME_Rune             = "Rune";
const string Ninja_FirstMageKit_NAME_Spruchrolle      = "Scroll";
const string Ninja_FirstMageKit_NAME_Mag_Circle       = "Circle:";
const string Ninja_FirstMageKit_NAME_Spell_Invest     = "Sustainable spell";
const string Ninja_FirstMageKit_NAME_Value            = "Value:";


/*
 * Adjust texts to language
 * Source: https://github.com/szapp/Ninja/wiki/Inject-Changes#localization
 */
func void Ninja_FirstMageKit_LocalizeTexts() {
    var int lang; lang = Ninja_FirstMageKit_GuessLocalization();
    if (lang == 1) { // DE (Windows 1252)
        NAME_SPL_FMKManaForLife                  = "Manasucht";
        NAME_SPL_FMKPickLock                     = "Entriegeln";
        Ninja_FirstMageKit_PRINT_NeverOpen       = "Da l�sst sich nichts machen";
        Ninja_FirstMageKit_PRINT_PICKLOCK_UNLOCK = "Das Schlo� ist geknackt";
        Ninja_FirstMageKit_PRINT_Hitpoints       = "Lebenspunktkosten:";
        Ninja_FirstMageKit_PRINT_Mana            = "Manasteigerung:";
        Ninja_FirstMageKit_NAME_MinManakosten    = "Manakosten (min):";
        Ninja_FirstMageKit_NAME_MageScroll       = "Spruchrolle";
        Ninja_FirstMageKit_NAME_Rune             = "Rune";
        Ninja_FirstMageKit_NAME_Spruchrolle      = "Spruchrolle";
        Ninja_FirstMageKit_NAME_Mag_Circle       = "Kreis:";
        Ninja_FirstMageKit_NAME_Spell_Invest     = "Aufrechterhaltungs-Zauber";
        Ninja_FirstMageKit_NAME_Value            = "Wert:";
    } else if (lang == 2) { // PL (Windows 1250)
        NAME_SPL_FMKManaForLife                  = "Ofiara krwi";
        NAME_SPL_FMKPickLock                     = "Otwieranie zamk�w";
        Ninja_FirstMageKit_PRINT_NeverOpen       = "Tego nie da si� otworzy�.";
        Ninja_FirstMageKit_PRINT_PICKLOCK_UNLOCK = "Zamek otwarty.";
        Ninja_FirstMageKit_PRINT_Hitpoints       = "Wydatek punkt�w trafie�:";
        Ninja_FirstMageKit_PRINT_Mana            = "Premia many:";
        Ninja_FirstMageKit_NAME_MinManakosten    = "Min. wydatek many:";
        Ninja_FirstMageKit_NAME_MageScroll       = "Zw�j";
        Ninja_FirstMageKit_NAME_Rune             = "Runa";
        Ninja_FirstMageKit_NAME_Spruchrolle      = "Zw�j";
        Ninja_FirstMageKit_NAME_Mag_Circle       = "Kr�g:";
        Ninja_FirstMageKit_NAME_Spell_Invest     = "Zakl�cie sta�e";
        Ninja_FirstMageKit_NAME_Value            = "Warto��:";
    } else if (lang == 3) { // RU (Windows 1251)
        NAME_SPL_FMKManaForLife                  = "���������� ����";
        NAME_SPL_FMKPickLock                     = "����������";
        Ninja_FirstMageKit_PRINT_NeverOpen       = "��� ��� ������� �� �������.";
        Ninja_FirstMageKit_PRINT_PICKLOCK_UNLOCK = "����� ������.";
        Ninja_FirstMageKit_PRINT_Hitpoints       = "��������:";
        Ninja_FirstMageKit_PRINT_Mana            = "����:";
        Ninja_FirstMageKit_NAME_MinManakosten    = "������ ����:";
        Ninja_FirstMageKit_NAME_MageScroll       = "������";
        Ninja_FirstMageKit_NAME_Rune             = "����";
        Ninja_FirstMageKit_NAME_Spruchrolle      = "������";
        Ninja_FirstMageKit_NAME_Mag_Circle       = "����:";
        Ninja_FirstMageKit_NAME_Spell_Invest     = "Sustainable spell"; // ??? in the Russian scripts
        Ninja_FirstMageKit_NAME_Value            = "����:";
    }; // Else: Keep default -> English
};
