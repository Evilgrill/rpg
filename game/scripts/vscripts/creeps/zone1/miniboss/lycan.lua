---------------------
--lycan call
---------------------

self.parent:EmitSound("lycan_lycan_ability_summon_03")

---------------------
--lycan companion
---------------------

self.parent:EmitSound("lycan_lycan_ally_03")

---------------------
--lycan wound
---------------------
self.parent:EmitSound("hero_bloodseeker.rupture")
---------------------
--lycan shapeshift
---------------------
self.parent:EmitSound("Hero_Lycan.Shapeshift.Cast")
---------------------
--lycan howl
---------------------
self.parent:EmitSound("Hero_Lycan.Howl")
---------------------
--lycan agility
---------------------
self.parent:EmitSound("lycan_lycan_attack_08")
---------------------
--lycan curse
---------------------

self.parent:EmitSound("lycan_lycan_ally_05")
self.parent:EmitSound("lycan_lycan_ally_04")
---------------------
--lycan double strike
---------------------
---------------------
--lycan bleeding
---------------------

if (IsServer()) then
    Enemies:RegisterEnemyAbility("npc_boss_lycan", "lycan_call", Enemies.ABILITY_TYPE_INNATE)
    Enemies:RegisterEnemyAbility("npc_boss_lycan", "lycan_companion", Enemies.ABILITY_TYPE_INNATE)
    Enemies:RegisterEnemyAbility("npc_boss_lycan", "lycan_wound", Enemies.ABILITY_TYPE_INNATE)
    Enemies:RegisterEnemyAbility("npc_boss_lycan", "lycan_shapeshift", Enemies.ABILITY_TYPE_INNATE)
    Enemies:RegisterEnemyAbility("npc_boss_lycan", "lycan_slam", Enemies.ABILITY_TYPE_INNATE)
    Enemies:RegisterEnemyAbility("npc_boss_lycan", "lycan_hunt", Enemies.ABILITY_TYPE_INNATE)
end
