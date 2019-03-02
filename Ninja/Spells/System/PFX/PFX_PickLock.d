instance MFX_PickLock_INIT (C_PARTICLEFX) {
    ppsvalue = 100.000000000;
    ppsscalekeys_s = "1";
    ppsislooping = 1;
    ppsissmooth = 1;
    ppsfps = 10.000000000;
    shptype_s = "SPHERE";
    shpfor_s = "object";
    shpoffsetvec_s = "0 0 0";
    shpdistribtype_s = "RAND";
    shpdim_s = "8";
    shpscalekeys_s = "1";
    shpscaleislooping = 1;
    shpscaleissmooth = 1;
    shpscalefps = 2.000000000;
    dirmode_s = "RAND";
    dirfor_s = "object";
    dirmodetargetfor_s = "OBJECT";
    dirmodetargetpos_s = "0 0 0";
    dirangleheadvar = 180.000000000;
    dirangleelevvar = 180.000000000;
    velavg = 0.005000001;
    lsppartavg = 1000.000000000;
    flygravity_s = "0 0 0";
    flycolldet_b = 0;
    visname_s = "WHITECLOUD.TGA";
    visorientation_s = "VELO";
    vistexanifps = 18.000000000;
    vistexaniislooping = 1;
    vistexcolorstart_s = "100 0 200";
    vistexcolorend_s = "255 0 10";
    vissizestart_s = "20 20";
    vissizeendscale = 1.00000000;
    visalphafunc_s = "ADD";
    visalphastart = 255.000000000;
    visalphaend = 1.000000000;
};

instance MFX_PickLock_TARGET (C_PARTICLEFX) {
    ppsvalue = 200.000000000;
    ppsscalekeys_s = "1";
    ppsislooping = 1;
    ppsissmooth = 1;
    ppsfps = 10.000000000;
    shptype_s = "SPHERE";
    shpfor_s = "object";
    shpoffsetvec_s = "0 0 0";
    shpdistribtype_s = "UNIFORM";
    shpdim_s = "225";
    shpscalekeys_s = "1";
    shpscaleislooping = 1;
    shpscaleissmooth = 1;
    shpscalefps = 2.000000000;
    dirmode_s = "TARGET";
    dirfor_s = "object";
    dirmodetargetfor_s = "OBJECT";
    dirmodetargetpos_s = "0 0 0";
    dirangleheadvar = 180.000000000;
    dirangleelevvar = 180.000000000;
    velavg = 0.06000001;
    lsppartavg = 1900.000000000;
    flygravity_s = "0 0 0";
    flycolldet_b = 0;
    visname_s = "MFX_SLEEP_STAR.TGA";
    visorientation_s = "NONE";
    vistexanifps = 18.000000000;
    vistexaniislooping = 1;
    vistexcolorstart_s = "100 0 200";
    vistexcolorend_s = "255 0 10";
    vissizestart_s = "50 50";
    vissizeendscale = 1.50000000;
    visalphafunc_s = "ADD";
    visalphastart = 255.000000000;
    visalphaend = 0.000000000;
};
