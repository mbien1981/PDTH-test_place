core:import("CoreMissionScriptElement")
core:import("CoreClass")
ElementPlayerSpawner = ElementPlayerSpawner or class(CoreMissionScriptElement.MissionScriptElement)

local module = ... or D:module(test_place_md.id)
local ElementPlayerSpawner = module:hook_class("ElementPlayerSpawner")

module:post_hook(ElementPlayerSpawner, "init", function(self)
	self._values.state = "standard"
	self._values.position = Vector3(-815, 30, 1675)
	self._values.rotation = Rotation(0, 0, 0)
end)
