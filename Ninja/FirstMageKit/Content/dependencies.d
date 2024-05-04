/*
 * Ensure that common dependencies exist
 */
class FMK_C_Spell {
    var float time_per_mana;
    var int damage_per_level;
    var int damageType;
    var int spellType;
    var int canTurnDuringInvest;
    var int canChangeTargetDuringInvest;
    var int isMultiEffect;
    var int targetCollectAlgo;
    var int targetCollectType;
    var int targetCollectRange;
    var int targetCollectAzi;
    var int targetCollectElev;
};

class FMK_C_Focus {
    var float npc_longrange;
    var float npc_range1, npc_range2;
    var float npc_azi;
    var float npc_elevdo, npc_elevup;
    var int npc_prio;
    var float item_range1, item_range2;
    var float item_azi;
    var float item_elevdo, item_elevup;
    var int item_prio;
    var float mob_range1, mob_range2;
    var float mob_azi;
    var float mob_elevdo, mob_elevup;
    var int mob_prio;
};

// Expect underlying instance by exact name
instance Focus_Magic(FMK_C_Focus);
