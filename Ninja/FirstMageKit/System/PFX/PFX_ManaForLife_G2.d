///                     XXXXXXXXXXXXXXXXXXXXXXXXXXXXX                      ///
///                     XX  M A N A F O R L I F E  XX                      ///
///                     XXXXXXXXXXXXXXXXXXXXXXXXXXXXX                      ///
///                  Taken from mud-freak's Zauberpaket                    ///

/* MFX_FMK_MANAFORLIFE_16BIT_TRIPOLY.TGA ist die gleiche Textur wie
 * MFX_MASTEROFDISASTER_AURA_16BIT.TGA, allerdings als Tri-Poly. Damit spar
 * ich mir die Option vistexisquadpoly, die doppelt so rechenaufwendig ist. */
INSTANCE MFX_FMKManaForLife_INIT (C_PARTICLEFX)
{
     ppsvalue = 75.000000000;
     ppsscalekeys_s = "1";
     shptype_s = "POINT";
     shpfor_s = "object";
     shpoffsetvec_s = "15 0 0";
     dirmode_s = "NONE";
     dirfor_s = "object";
     dirmodetargetfor_s = "OBJECT";
     velavg = 0;
     lsppartavg = 150.000000000;
     flygravity_s = "0 0 0";
     flycolldet_b = 0;
     visname_s = "MFX_FMK_MANAFORLIFE_16BIT_TRIPOLY.TGA";
     vistexisquadpoly = 0;
     visorientation_s = "NONE";
     vistexcolorstart_s = "100 100 255";
     vistexcolorend_s = "0 0 250";
     vissizestart_s = "10 10";
     vissizeendscale = 1;
     visalphafunc_s = "ADD";
     visalphastart = 255.000000000;
     visalphaend = 255.000000000;
     trlFadeSpeed = 1;
     trltexture_s = "FMK_HEAVENLIGHT.TGA";
     trlwidth = 1;
     useemittersfor = 1;
};
INSTANCE MFX_FMKManaForLife_INIT2 (C_PARTICLEFX)
{
     ppsvalue = 75.000000000;
     ppsscalekeys_s = "1";
     shptype_s = "POINT";
     shpfor_s = "object";
     shpoffsetvec_s = "0 15 0";
     dirmode_s = "NONE";
     dirfor_s = "object";
     dirmodetargetfor_s = "OBJECT";
     velavg = 0;
     lsppartavg = 150.000000000;
     flygravity_s = "0 0 0";
     flycolldet_b = 0;
     visname_s = "MFX_FMK_MANAFORLIFE_16BIT_TRIPOLY.TGA";
     vistexisquadpoly = 0;
     visorientation_s = "NONE";
     vistexcolorstart_s = "255 100 100";
     vistexcolorend_s = "250 0 0";
     vissizestart_s = "10 10";
     vissizeendscale = 1;
     visalphafunc_s = "ADD";
     visalphastart = 255.000000000;
     visalphaend = 255.000000000;
     trlFadeSpeed = 1;
     trltexture_s = "FMK_HELLLIGHT.TGA";
     trlwidth = 1;
     useemittersfor = 1;
};

// Copied from Gothic 2 NotR
PROTOTYPE MFX_FMKManaForLife_FOUNTAIN (C_PARTICLEFX)
{
    ppsvalue = 200;
    ppsscalekeys_s = "2 1 1 1 1 1 0.8 0.6 0.4 0.2";
    ppsfps = 1;
    shptype_s = "POINT";
    shpfor_s = "OBJECT";
    shpoffsetvec_s = "20 0 0";
    shpdistribtype_s = "BOX";
    shpdim_s = "20 2 2";
    shpmeshrender_b = 1;
    shpscalekeys_s = "1";
    shpscaleissmooth = 1;
    dirmode_s = "DIR";
    dirfor_s = "OBJECT";
    dirmodetargetfor_s = "OBJECT";
    dirmodetargetpos_s = "0 0 0";
    dirangleheadvar = 2;
    dirangleelevvar = 2;
    velavg = 0.600000024;
    velvar = 0.100000001;
    lsppartavg = 1700;
    lsppartvar = 300;
    flygravity_s = "0 -0.0008 0";
    visname_s = "FMK_INFLATE_WATER.TGA";
    visorientation_s = "VELO3D";
    vistexanifps = 18;
    vistexcolorstart_s = "200 220 250";
    vistexcolorend_s = "128 200 255";
    vissizestart_s = "5 25";
    visalphafunc_s = "BLEND";
    visalphastart = 150;
    visalphaend = 50;
};

// Wir bedienen uns dem Inflatezauber und passen den Spritz-Effekt an
INSTANCE MFX_FMKManaForLife_SPATTER_0 (MFX_FMKManaForLife_FOUNTAIN)
{
    ppsscalekeys_s = "2";           // Wir loopen den Effekt, weil er unter-
    ppsIsLooping = 1;               //  schiedlich lang sein kann.
    diranglehead = 0;               // Spritzwinkel
    velavg = 0.200000024;           // Spritzstärke
    vistexcolorstart_s = "98 0 0";  // In Blutrot
    vistexcolorend_s = "191 28 28";
};
INSTANCE MFX_FMKManaForLife_SPATTER_90 (MFX_FMKManaForLife_FOUNTAIN)
{
    ppsscalekeys_s = "2";
    ppsIsLooping = 1;
    diranglehead = 170;
    dirAngleElev = 30;
    velavg = 0.200000024;
    vistexcolorstart_s = "98 0 0";
    vistexcolorend_s = "191 28 28";
};
INSTANCE MFX_FMKManaForLife_SPATTER_180 (MFX_FMKManaForLife_FOUNTAIN)
{
    ppsscalekeys_s = "2";
    ppsIsLooping = 1;
    diranglehead = 160;
    dirAngleElev = -20;
    velavg = 0.200000024;
    vistexcolorstart_s = "98 0 0";
    vistexcolorend_s = "191 28 28";
};

INSTANCE MFX_FMKManaForLife_RING_LARGE1 (C_PARTICLEFX)
{
    ppsvalue = 250.000000000;
    ppsscalekeys_s = "1";
    shptype_s = "LINE";
    shpfor_s = "OBJECT";
    shpoffsetvec_s = "70 -30 0";
    shpDistribType_S = "WALK";
    shpDistribWalkSpeed = 0.0008;
    shpDim_S = "100";
    dirmode_s = "NONE";
    velavg = 0;
    lsppartavg = 600.000000000;
    flygravity_s = "0 0 0";
    flycolldet_b = 0;
    visname_s = "MFX_FMK_MANAFORLIFE_16BIT_TRIPOLY.TGA";
    vistexisquadpoly = 0;
    visorientation_s = "NONE";
    vistexcolorstart_s = "100 100 255"; // "0 0 255"; // Lichterkettenartefakt
    vistexcolorend_s = "0 0 255";
    vissizestart_s = "25 25";
    vissizeendscale = 2;
    visalphafunc_s = "ADD";
    visalphastart = 255.000000000;
    visalphaend = 255.000000000;
};

INSTANCE MFX_FMKManaForLife_RING_LARGE2 (C_PARTICLEFX)
{
    ppsvalue = 250.000000000;
    ppsscalekeys_s = "1";
    shptype_s = "LINE";
    shpfor_s = "OBJECT";
    shpoffsetvec_s = "-70 -30 0";
    shpDistribType_S = "WALK";
    shpDistribWalkSpeed = 0.0008;
    shpDim_S = "100";
    dirmode_s = "NONE";
    velavg = 0;
    lsppartavg = 600.000000000;
    flygravity_s = "0 0 0";
    flycolldet_b = 0;
    visname_s = "MFX_FMK_MANAFORLIFE_16BIT_TRIPOLY.TGA";
    vistexisquadpoly = 0;
    visorientation_s = "NONE";
    vistexcolorstart_s = "255 100 100"; // "255 0 0"; // Lichterkettenartefakt
    vistexcolorend_s = "255 0 0";
    vissizestart_s = "25 25";
    vissizeendscale = 2;
    visalphafunc_s = "ADD";
    visalphastart = 255.000000000;
    visalphaend = 255.000000000;

};

/* Kopie von MFX_Fear_ORIGIN aber mit mehr Partikeln (ppsvalue), wichtig!
 * Mit zu wenig pps weigert sich Gothic unter Umständen den FX zu rendern.  */
INSTANCE MFX_FMKManaForLife_ORIGIN (C_PARTICLEFX)
{
     ppsvalue = 75;
     ppsscalekeys_s = "1 1 1 1 1 1 1 1";
     ppsissmooth = 1;
     ppsfps = 2;
     shptype_s = "CIRCLE";
     shpfor_s = "object";
     shpoffsetvec_s = "0 -120 0";
     shpdistribtype_s = "RAND";
     shpdim_s = "20";
     shpscalekeys_s = "1";
     dirmode_s = "DIR";
     dirfor_s = "world";
     dirmodetargetfor_s = "OBJECT";
     dirangleheadvar = 180;
     dirangleelev = 90;
     velavg = 0.00999999978;
     lsppartavg = 1000;
     lsppartvar = 150;
     flygravity_s = "0 0 0";
     visname_s = "FMK_HEAVENLIGHT.TGA";
     visorientation_s = "VELO";
     vistexisquadpoly = 1;
     vistexcolorstart_s = "255 0 0";
     vistexcolorend_s = "255 0 50";
     vissizestart_s = "3 18";
     vissizeendscale = 20;
     visalphafunc_s = "ADD";
     visalphastart = 255;
};
