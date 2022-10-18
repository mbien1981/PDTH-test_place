local module = DMod:new("test_place_mutator", {
	author = "Dr_Newbie",
	categories = { "gameplay", "mutator" },
	dependency = "ovk_193",
	localization = {
		{ "mutator_test_place_mutator", "Test place" },
		{ "mutator_test_place_mutator_help", "" },
		{ "mutator_test_place_mutator_motd", "" },
	},
	version = "5",
})

rawset(_G, "test_place_md", {
	id = module:id(),
	path = ModPath,
})

module:hook("OnModuleLoading", "load_test_place", function(module)
	local mutator_availability = { all = { levels = { apartment = true } } }
	if not MutatorHelper.setup_mutator(module, module:id(), mutator_availability, nil, nil, true) then
		return
	end

	if Global.game_settings and not Global.game_settings.single_player then
		return
	end

	module:hook_post_require("lib/setups/setup", "lua/lib/updator")
	module:hook_post_require("core/lib/setups/coresetup", "lua/lib/updator")

	-- remove units
	module:hook_post_require("lib/setups/gamesetup", "lua/janitor")

	-- debug
	module:hook_post_require("lib/units/enemies/cop/copdamage", "lua/debug/copdamage")
	module:hook_post_require("lib/units/beings/player/states/playerstandard", "lua/debug/playerstandard")
	module:hook_post_require("lib/units/beings/player/playerdamage", "lua/debug/playerdamage")

	-- disable/modify events
	module:hook_post_require("lib/managers/mission/elementareatrigger", "lua/mission/areatrigger")
	module:hook_post_require("lib/managers/mission/elementdialogue", "lua/mission/dialogue")
	module:hook_post_require("lib/managers/mission/elementhint", "lua/mission/hint")
	module:hook_post_require("lib/managers/mission/elementobjective", "lua/mission/objective")
	module:hook_post_require("lib/managers/mission/elementplayerspawner", "lua/mission/playerspawner")
	module:hook_post_require("lib/managers/mission/elementspawncivilian", "lua/mission/spawncivilian")
	module:hook_post_require("lib/managers/mission/elementspawnciviliangroup", "lua/mission/spawnciviliangroup")
	module:hook_post_require("lib/managers/mission/elementspawnenemydummy", "lua/mission/spawnenemydummy")
	module:hook_post_require("lib/managers/mission/elementspawnenemygroup", "lua/mission/spawnenemygroup")
	module:hook_post_require("lib/managers/mission/elementwaypoint", "lua/mission/waypoint")
	module:hook_post_require("lib/managers/mission/missionscriptelement", "lua/mission/missionscript")

	if PackageManager then
		if
			not Global.game_settings
			or not Global.game_settings.level_id
			or not game_state_machine
			or not string.find(game_state_machine:current_state_name(), "game")
		then
			for _, level in pairs({
				"apartment",
				"bank",
				"bridge",
				"diamondheist",
				"l4d",
				"secret_stash",
				"slaughterhouse",
				"street",
				"suburbia",
			}) do
				if PackageManager:loaded(string.format("levels/%s/world", level)) then
					PackageManager:unload(string.format("levels/%s/world", level))
				end
			end
		end
	end
end)

return module
