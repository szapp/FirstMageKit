/*
 * Guess localization (0 = EN, 1 = DE, 2 = PL, 3 = RU)
 * Source: https://github.com/szapp/Ninja/wiki/Inject-Changes#localization
 */
func int Patch_FirstMageKit_GuessLocalization() {
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
const string Patch_FirstMageKit_PRINT_NeverOpen       = "It will never open.";
const string Patch_FirstMageKit_PRINT_PICKLOCK_UNLOCK = "The lock's open.";
const string Patch_FirstMageKit_PRINT_Hitpoints       = "Hitpoint cost:";
const string Patch_FirstMageKit_PRINT_Mana            = "Mana increase:";
const string Patch_FirstMageKit_NAME_MinManakosten    = "Mana cost (min):";
const string Patch_FirstMageKit_NAME_MageScroll       = "Scroll";
const string Patch_FirstMageKit_NAME_Rune             = "Rune";
const string Patch_FirstMageKit_NAME_Spruchrolle      = "Scroll";
const string Patch_FirstMageKit_NAME_Mag_Circle       = "Circle:";
const string Patch_FirstMageKit_NAME_Spell_Invest     = "Sustainable spell";
const string Patch_FirstMageKit_NAME_Value            = "Value:";


/*
 * Adjust texts to language
 * Source: https://github.com/szapp/Ninja/wiki/Inject-Changes#localization
 */
func void Patch_FirstMageKit_LocalizeTexts() {
    var int lang; lang = Patch_FirstMageKit_GuessLocalization();
    if (lang == 1) { // DE (Windows 1252)
        NAME_SPL_FMKManaForLife                  = "Manasucht";
        NAME_SPL_FMKPickLock                     = "Entriegeln";
        Patch_FirstMageKit_PRINT_NeverOpen       = "Da l�sst sich nichts machen";
        Patch_FirstMageKit_PRINT_PICKLOCK_UNLOCK = "Das Schlo� ist geknackt";
        Patch_FirstMageKit_PRINT_Hitpoints       = "Lebenspunktkosten:";
        Patch_FirstMageKit_PRINT_Mana            = "Manasteigerung:";
        Patch_FirstMageKit_NAME_MinManakosten    = "Manakosten (min):";
        Patch_FirstMageKit_NAME_MageScroll       = "Spruchrolle";
        Patch_FirstMageKit_NAME_Rune             = "Rune";
        Patch_FirstMageKit_NAME_Spruchrolle      = "Spruchrolle";
        Patch_FirstMageKit_NAME_Mag_Circle       = "Kreis:";
        Patch_FirstMageKit_NAME_Spell_Invest     = "Aufrechterhaltungs-Zauber";
        Patch_FirstMageKit_NAME_Value            = "Wert:";
    } else if (lang == 2) { // PL (Windows 1250)
        NAME_SPL_FMKManaForLife                  = "Ofiara krwi";
        NAME_SPL_FMKPickLock                     = "Otwieranie zamk�w";
        Patch_FirstMageKit_PRINT_NeverOpen       = "Tego nie da si� otworzy�.";
        Patch_FirstMageKit_PRINT_PICKLOCK_UNLOCK = "Zamek otwarty.";
        Patch_FirstMageKit_PRINT_Hitpoints       = "Wydatek punkt�w trafie�:";
        Patch_FirstMageKit_PRINT_Mana            = "Premia many:";
        Patch_FirstMageKit_NAME_MinManakosten    = "Min. wydatek many:";
        Patch_FirstMageKit_NAME_MageScroll       = "Zw�j";
        Patch_FirstMageKit_NAME_Rune             = "Runa";
        Patch_FirstMageKit_NAME_Spruchrolle      = "Zw�j";
        Patch_FirstMageKit_NAME_Mag_Circle       = "Kr�g:";
        Patch_FirstMageKit_NAME_Spell_Invest     = "Zakl�cie sta�e";
        Patch_FirstMageKit_NAME_Value            = "Warto��:";
    } else if (lang == 3) { // RU (Windows 1251)
        NAME_SPL_FMKManaForLife                  = "���������� ����";
        NAME_SPL_FMKPickLock                     = "�������� ������";
        Patch_FirstMageKit_PRINT_NeverOpen       = "��� ��� ������� �� �������.";
        Patch_FirstMageKit_PRINT_PICKLOCK_UNLOCK = "����� ������.";
        Patch_FirstMageKit_PRINT_Hitpoints       = "��������:";
        Patch_FirstMageKit_PRINT_Mana            = "����:";
        Patch_FirstMageKit_NAME_MinManakosten    = "������ ����:";
        Patch_FirstMageKit_NAME_MageScroll       = "������";
        Patch_FirstMageKit_NAME_Rune             = "����";
        Patch_FirstMageKit_NAME_Spruchrolle      = "������";
        Patch_FirstMageKit_NAME_Mag_Circle       = "����:";
        Patch_FirstMageKit_NAME_Spell_Invest     = "Sustainable spell"; // ??? in the Russian scripts
        Patch_FirstMageKit_NAME_Value            = "����:";
    }; // Else: Keep default -> English
};
