///                     XXXXXXXXXXXXXXXXXXXXXXXXXXXXX                      ///
///                     XX  M A N A F O R L I F E  XX                      ///
///                     XXXXXXXXXXXXXXXXXXXXXXXXXXXXX                      ///
///                  Taken from mud-freak's Zauberpaket                    ///

// Blaues "Elekron" auf der Hand
INSTANCE spellFX_FMKManaForLife (/*CFx_Base_Proto*/ Ninja_FirstMakeKit_CFx_Base_Proto)
{
    visname_S               = "MFX_ManaForLife_INIT";
    emtrjoriginnode         = "ZS_RIGHTHAND";
    emtrjmode_s             = "FIXED";
    emtrjloopmode_s         = "NONE";
    emtrjeasefunc_s         = "LINEAR";
    emSelfRotVel_S          = "0 500 -250";
    emtrjdynupdatedelay     = 0.;
    emFXCreate_S            = "spellFX_FMKManaForLife_2OBJ";
    emFXInvestOrigin_S      = "spellFX_FMKManaForLife_INVEST"; // SPL_NEXTLEVEL
    };
    INSTANCE spellFX_FMKManaForLife_KEY_CAST (C_ParticleFXEmitKey)
    {
        visname_S           = "MFX_ManaForLife_ORIGIN";
        sfxid               = "SFX_HealObsession";
        sfxIsAmbient        = 1;
};
// Rotes "Elekron" auf der Hand
INSTANCE spellFX_FMKManaForLife_2OBJ (/*CFx_Base_Proto*/ Ninja_FirstMakeKit_CFx_Base_Proto)
{
    visname_S               = "MFX_ManaForLife_INIT2";
    emtrjoriginnode         = "ZS_RIGHTHAND";
    emtrjmode_s             = "FIXED";
    emtrjloopmode_s         = "NONE";
    emtrjeasefunc_s         = "LINEAR";
    emSelfRotVel_S          = "500 0 250";
    emtrjdynupdatedelay     = 0.;
    };
    INSTANCE spellFX_FMKManaForLife_2OBJ_KEY_INIT (C_ParticleFXEmitKey)
    {
        pfx_ppsisloopingChg  = 1; // Beenden sonst bleibt es nach Zauber
    };
    INSTANCE spellFX_FMKManaForLife_2OBJ_KEY_CAST (C_ParticleFXEmitKey)
    {
        pfx_ppsisloopingChg  = 1; // Beenden sonst bleibt es nach Zauber
};
// Investphase
INSTANCE spellFX_FMKManaForLife_INVEST (/*CFx_Base_Proto*/ Ninja_FirstMakeKit_CFx_Base_Proto)
{
    visname_S               = "MFX_ManaForLife_SPATTER_0";
    emTrjOriginNode         = "BIP01 Spine2";
    emFXCreatedOwnTrj       = 1;
    sfxid                   = "MFX_MANAFORLIFE_HEARTBEAT";
    sfxIsAmbient            = 1;
    lightPresetname         = "AURA";
    emFXCreate_S            = "spellFX_FMKManaForLife_SPATTER_90";
    emFXLifeSpan            = 30; // Kindersicherung: Falls es hängen bleibt.
};
INSTANCE spellFX_FMKManaForLife_SPATTER_90 (/*CFx_Base_Proto*/ Ninja_FirstMakeKit_CFx_Base_Proto)
{
    visname_S               = "MFX_ManaForLife_SPATTER_90";
    emTrjOriginNode         = "BIP01 Spine2";
    emFXCreatedOwnTrj       = 1;
    emFXCreate_S            = "spellFX_FMKManaForLife_SPATTER_180";
};
INSTANCE spellFX_FMKManaForLife_SPATTER_180 (/*CFx_Base_Proto*/ Ninja_FirstMakeKit_CFx_Base_Proto)
{
    visname_S               = "MFX_ManaForLife_SPATTER_180";
    emTrjOriginNode         = "BIP01 Pelvis";
    emFXCreatedOwnTrj       = 1;
    emFXCreate_S            = "spellFX_FMKManaForLife_SPIRAL";
};
// Spirale in HP-Rot und Mana-Blau um den Caster
INSTANCE spellFX_FMKManaForLife_SPIRAL (/*CFx_Base_Proto*/ Ninja_FirstMakeKit_CFx_Base_Proto)
{
    visname_S               = "MFX_ManaForLife_RING_LARGE1";
    emTrjOriginNode         = "Bip01";
    emtrjmode_s             = "FIXED";
    emSelfRotVel_S          = "0 400 0";
    emtrjdynupdatedelay     = 0;
    emFXCreatedOwnTrj       = 1;
    emFXCreate_S            = "spellFX_FMKManaForLife_SPIRAL2";
};
INSTANCE spellFX_FMKManaForLife_SPIRAL2 (/*CFx_Base_Proto*/ Ninja_FirstMakeKit_CFx_Base_Proto)
{
    visname_S               = "MFX_ManaForLife_RING_LARGE2";
    emTrjOriginNode         = "Bip01";
    emtrjmode_s             = "FIXED";
    emSelfRotVel_S          = "0 400 0";
    emtrjdynupdatedelay     = 0;
    emFXCreatedOwnTrj       = 0;
    emFXCreate_S            = "DEMENTOR_FX";
};


// Copied for Gothic 1 compatibility
INSTANCE DEMENTOR_FX (/*CFx_Base_Proto*/ Ninja_FirstMakeKit_CFx_Base_Proto)
{
    // ...
    sfxid               = "Dementhor_Talk";
    sfxisambient        = 1;
};
