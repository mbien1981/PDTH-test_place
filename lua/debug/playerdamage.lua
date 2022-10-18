local module = ... or D:module(test_place_md.id)
local PlayerDamage = module:hook_class("PlayerDamage")
module:hook(50, PlayerDamage, "damage_fall", function(self, data)
	return nil
end)
