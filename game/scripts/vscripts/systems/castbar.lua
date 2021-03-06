if (IsServer()) then
    require("libraries/worldpanels")
end

modifier_castbar = class({
    IsDebuff = function(self)
        return false
    end,
    IsHidden = function(self)
        return true
    end,
    IsPurgable = function(self)
        return false
    end,
    RemoveOnDeath = function(self)
        return false
    end,
    AllowIllusionDuplicate = function(self)
        return false
    end,
    GetAttributes = function(self)
        return MODIFIER_ATTRIBUTE_PERMANENT
    end,
    DeclareFunctions = function(self)
        return {
            MODIFIER_EVENT_ON_ABILITY_START,
            MODIFIER_PROPERTY_CASTTIME_PERCENTAGE
        }
    end,
})
--Units:GetSpellHaste(self.hero) = statsTable.spellHaste =  (1 + flat) * totalpercent with 8 cap value
-- if u get 50 flat(0.5 for calcution) and 50% increase this make Units:GetSpellHaste = 2.25  this make (1/2.25 - 1) *-100 = 55.56 so your cast time will be 44.44% of
-- so you shit out spell 1/0.444 = at  2.25 rate match the 50 flat then add 50% (1.5*1.5)
function modifier_castbar:GetModifierPercentageCasttime() -- decrease cast time for a percentage
    return  ((1/Units:GetSpellHaste(self.hero)) - 1) * -100
end

function modifier_castbar:OnAbilityStart(keys)
    if (not IsServer()) then
        return
    end
    local ability = keys.ability
    if (ability.IsRequireCastbar and ability.IsRequireCastbar(ability) == true and keys.unit == self.hero) then
        local abilityIndex = ability:GetEntityIndex()
        local channelTime = ability:GetChannelTime()
        local IsChannelAbility = (channelTime > 0)
        local castTime = 0
        if (IsChannelAbility) then
            castTime = channelTime
        else
            castTime = ability:GetCastPoint() * 1/Units:GetSpellHaste(self.hero)
        end
        local event = {
            casttime = castTime,
            ability = abilityIndex,
            id = self.hero.castBarId
        }
        CustomGameEventManager:Send_ServerToAllClients("rpg_show_castbar", event)
    end
end

function modifier_castbar:OnCreated(keys)
    if (not IsServer()) then
        return
    end
    local hero = self:GetParent()
    self.hero = hero
    hero.castBar = WorldPanels:CreateWorldPanelForAll({
        layout = "file://{resources}/layout/custom_game/castbar.xml",
        entity = hero:GetEntityIndex(),
        entityHeight = -40,
        data = { id = Castbar.id }
    })
    hero.castBarId = Castbar.id
    Castbar.id = Castbar.id + 1
end

LinkLuaModifier("modifier_castbar", "systems/castbar", LUA_MODIFIER_MOTION_NONE)

if not Castbar then
    Castbar = class({})
end

function Castbar:OnNPCSpawned(keys)
    if (not IsServer()) then
        return
    end
    local hero = EntIndexToHScript(keys.entindex)
    if (hero.IsRealHero and hero:IsRealHero() and not hero.castBar) then
        hero:AddNewModifier(hero, nil, "modifier_castbar", { Duration = -1 })
    end
end

function Castbar:AddToUnit(unit)
    if (not IsServer()) then
        return
    end
    if (not unit.castBar) then
        unit:AddNewModifier(unit, nil, "modifier_castbar", { Duration = -1 })
    end
end

if not Castbar.initialized then
    ListenToGameEvent('npc_spawned', Dynamic_Wrap(Castbar, 'OnNPCSpawned'), Castbar)
    Castbar.initialized = true
    Castbar.id = 0
end