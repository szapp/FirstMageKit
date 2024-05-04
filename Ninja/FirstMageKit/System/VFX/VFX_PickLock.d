instance spellFX_FMKPickLock (/*CFx_Base_Proto*/ FMK_CFx_Base_Proto) {
    visname_S               = "MFX_FMKPickLock_INIT";
    emtrjoriginnode         = "ZS_RIGHTHAND";
    emtrjmode_s             = "FIXED";
    emtrjloopmode_s         = "PINGPONG";
    emtrjeasefunc_s         = "LINEAR";
    emFXInvestTarget_S      = "spellFX_FMKPickLock_InvestTarget";
    };
    instance spellFX_FMKPickLock_KEY_INVEST_1 (C_ParticleFXEmitKey) { };
    instance spellFX_FMKPickLock_KEY_INVEST_2 (C_ParticleFXEmitKey) {
        emtrjmode_s         = "TARGET";
        emtrjeasevel        = 500;
    };
    instance spellFX_FMKPickLock_KEY_CAST (C_ParticleFXEmitKey) {
        pfx_ppsisloopingChg = 1;
        emtrjmode_s         = "FIXED";
        emtrjeasevel        = 0.000001;
        // sfxid            = "MFX_FMKPickLock_Cast"; // Moved to spell script
        // sfxIsAmbient     = 1;
};
instance spellFX_FMKPickLock_InvestTarget (/*CFx_Base_Proto*/ FMK_CFx_Base_Proto) {
    visname_S               = "MFX_FMKPickLock_TARGET";
    lightPresetName         = "CATACLYSM";
    emFXCreate_S            = "spellFX_FMKPickLock_InvestSound";
};
instance spellFX_FMKPickLock_InvestSound (/*CFx_Base_Proto*/ FMK_CFx_Base_Proto) {
    // Separate instance for immediate stopping on release (sorry for the zSpy warnings)
    sfxid                   = "MFX_FMKPickLock_INVEST";
    sfxIsAmbient            = 0;
    emFXCreatedOwnTrj       = 1;
};
