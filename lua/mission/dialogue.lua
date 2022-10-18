core:import("CoreMissionScriptElement")
ElementDialogue = ElementDialogue or class(CoreMissionScriptElement.MissionScriptElement)

local module = ... or D:module(test_place_md.id)
local ElementDialogue = module:hook_class("ElementDialogue")

module:post_hook(ElementDialogue, "init", function(self)
	self._values.enabled = false
end, true)
