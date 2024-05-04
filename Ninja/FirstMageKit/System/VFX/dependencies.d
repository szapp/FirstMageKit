class FMK_C_ParticleFXEmitKey {
    var string visname_s;
    var float vissizescale;
    var float scaleduration;
    var float pfx_ppsvalue;
    var int pfx_ppsissmoothchg;
    var int pfx_ppsisloopingchg;
    var float pfx_sctime;
    var string pfx_flygravity_s;
    var string pfx_shpdim_s;
    var int pfx_shpisvolumechg;
    var float pfx_shpscalefps;
    var float pfx_shpdistribwalkspeed;
    var string pfx_shpoffsetvec_s;
    var string pfx_shpdistribtype_s;
    var string pfx_dirmode_s;
    var string pfx_dirfor_s;
    var string pfx_dirmodetargetfor_s;
    var string pfx_dirmodetargetpos_s;
    var float pfx_velavg;
    var float pfx_lsppartavg;
    var float pfx_visalphastart;
    var string lightpresetname;
    var float lightrange;
    var string sfxid;
    var int sfxisambient;
    var string emcreatefxid;
    var float emflygravity;
    var string emselfrotvel_s;
    var string emtrjmode_s;
    var float emtrjeasevel;
    var int emcheckcollision;
    var float emfxlifespan;
};

prototype FMK_CFx_Base_Proto(FMK_CFx_Base) {
    visName_S                = "";
    visAlpha                 = 1;
    emTrjMode_S              = "FIXED";
    emTrjOriginNode          = "ZS_RIGHTHAND";
    emTrjTargetNode          = "";
    emTrjTargetRange         = 10;
    emTrjTargetAzi           = 0;
    emTrjTargetElev          = 0;
    emTrjNumKeys             = 10;
    emTrjNumKeysVar          = 0;
    emTrjAngleElevVar        = 0;
    emTrjAngleHeadVar        = 0;
    emTrjKeyDistVar          = 0;
    emTrjLoopMode_S          = "NONE";
    emTrjEaseFunc_S          = "LINEAR";
    emTrjEaseVel             = 100;
    emTrjDynUpdateDelay      = 2000000;
    emTrjDynUpdateTargetOnly = 0;
    emFXCreate_S             = "";
    emFXTriggerDelay         = 0;
    emFXCreatedOwnTrj        = 0;
    emActionCollDyn_S        = "";
    emActionCollStat_S       = "";
    emFXCollStat_S           = "";
    emFXCollDyn_S            = "";
    // emFXCollDynPerc_S        = ""; // Does not exist in Gothic 1
    emFXCollStatAlign_S      = "";
    emFXCollDynAlign_S       = "";
    emCheckCollision         = 0;
    emAdjustShpToOrigin      = 0;
    emInvestNextKeyDuration  = 0;
    emFlyGravity             = 0;
    emFXLifeSpan             = -1;
    emSelfRotVel_S           = "0 0 0";
    lightPresetName          = "";
    sfxID                    = "";
    sendAssessMagic          = 0;
    secsPerDamage            = -1;
};
