core:import("CoreMissionScriptElement")
ElementSpawnCivilianGroup = ElementSpawnCivilianGroup or class(CoreMissionScriptElement.MissionScriptElement)

local module = ... or D:module(test_place_md.id)
local ElementSpawnCivilianGroup = module:hook_class("ElementSpawnCivilianGroup")

module:post_hook(ElementSpawnCivilianGroup, "init", function(self)
	self._values.enabled = false
end, true)
