core:import("CoreMissionScriptElement")
ElementAreaTrigger = ElementAreaTrigger or class(CoreMissionScriptElement.MissionScriptElement)

local module = ... or D:module(test_place_md.id)
local ElementAreaTrigger = module:hook_class("ElementAreaTrigger")

module:post_hook(ElementAreaTrigger, "init", function(self)
	self._values.enabled = false
end, true)
