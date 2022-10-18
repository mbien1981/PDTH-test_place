local module = ... or D:module(test_place_md.id)
local PlayerStandard = module:hook_class("PlayerStandard")

module:post_hook(PlayerStandard, "init", function(self)
	local _tracker = rawget(_G, "_tracker")
	if not _tracker then
		return
	end

	_tracker:remove_tracker("player_pos")
	_tracker:remove_tracker("player_rot")
	_tracker:remove_tracker("player_lookat")
	_updator:remove("debug_player")

	_tracker:add_tracker("pos", "0, 0, 0", "player_pos")
	_tracker:add_tracker("rot", "0, 0, 0", "player_rot")
	_tracker:add_tracker("lookat", "0, 0, 0", "player_lookat")

	_updator:add(function()
		local unit = self._unit
		if not alive(unit) then
			return
		end

		_tracker:update_tracker("player_pos", tostring(unit:position()))
		_tracker:update_tracker("player_rot", tostring(unit:camera():rotation()))

		local ray_forward = function()
			local player = managers.player:player_unit()
			local from = player:camera():position()
			local to = Vector3()
			mvector3.set(to, player:camera():forward())
			mvector3.multiply(to, 20000)
			mvector3.add(to, from)

			local colRay = World:raycast("ray", from, to, "slot_mask", managers.slot:get_mask("bullet_impact_targets"))
			return colRay and colRay.hit_position
		end

		local to = ray_forward()
		if not to then
			return
		end

		Application:draw_sphere(to, 5, 0, 1, 0)
		_tracker:update_tracker("player_lookat", tostring(to))
	end, "debug_player", 0)
end)

module:hook(PlayerStandard, "_get_input", function(self, t, dt, paused)
	local input = module:call_orig(PlayerStandard, "_get_input", self, t, dt, paused)
	local data_shit = {
		data = {
			jump = true,
		},
		keys = {
			jump = "btn_jump_press",
		},
	}

	for btn, on in pairs(data_shit.data) do
		local shit = data_shit.keys[btn]
		if on and input[shit] == false then
			input[shit] = self._controller:get_input_bool(btn)
		end
	end

	return input
end)
