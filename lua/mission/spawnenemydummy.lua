core:import("CoreMissionScriptElement")
ElementSpawnEnemyDummy = ElementSpawnEnemyDummy or class(CoreMissionScriptElement.MissionScriptElement)

local module = ... or D:module(test_place_md.id)
local ElementSpawnEnemyDummy = module:hook_class("ElementSpawnEnemyDummy")

module:post_hook(ElementSpawnEnemyDummy, "init", function(self)
	self._values.enabled = false
end, true)
