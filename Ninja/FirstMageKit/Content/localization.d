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
        } else if (Hlp_StrCmp(panName, "Сковорода")) { // RU
            return 3;
        };
    };
    return 0; // Otherwise EN
};
