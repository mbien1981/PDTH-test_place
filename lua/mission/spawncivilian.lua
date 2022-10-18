core:import("CoreMissionScriptElement")
ElementSpawnCivilian = ElementSpawnCivilian or class(CoreMissionScriptElement.MissionScriptElement)

local module = ... or D:module(test_place_md.id)
local ElementSpawnCivilian = module:hook_class("ElementSpawnCivilian")

module:post_hook(ElementSpawnCivilian, "init", function(self)
	self._values.enabled = false
end, true)
