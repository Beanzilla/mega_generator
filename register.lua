local S = tech.getter

function tech.register_generator2(data)

	local groups = {snappy=2, choppy=2, oddly_breakable_by_hand=2,
		tech_machine=1, ["tech_lv"]=1, ["tech_mv"]=1, ["tech_hv"]=1}
	local active_groups = {not_in_creative_inventory = 1}
	for k, v in pairs(groups) do active_groups[k] = v end

	local generator_formspec =
		"size[8,9;]"..
		"label[0,0;"..S("Mega Generator").."]"..
		"list[current_name;3,1;1,1;]"..
		"list[current_player;main;0,5;8,4;]"..
		"listring[]"

	local desc = S("Mega Generator")
	local desc_on = S("Mega Generator (Active)")

	local run = function(pos, node)
		local meta = minetest.get_meta(pos)
		meta:set_int("LV_EU_supply", data.supply_lv)
		meta:set_int("MV_EU_supply", data.supply_mv)
		meta:set_int("HV_EU_supply", data.supply_hv)
		if node.name ~= "mega_generator_active" then
			tech.swap_node(pos, "mega_generator:mega_generator_active")
		end
	end

	minetest.register_node("mega_generator:mega_generator", {
		description = desc,
		tiles = {
				"mega_generator_side.png",
				"technic_machine_bottom.png",
				"mega_generator_side.png",
				"mega_generator_side.png",
				"mega_generator_side.png",
				"mega_generator_side.png"
		},
		paramtype2 = "facedir",
		groups = groups,
		connect_sides = {"bottom", "back", "left", "right"},
		legacy_facedir_simple = true,
		drop = "mega_generator:mega_generator",
		sounds = default.node_sound_wood_defaults(),
		on_construct = function(pos)
			local meta = minetest.get_meta(pos)
			meta:set_string("infotext", desc)
		end,
		can_dig = tech.machine_can_dig,
		allow_metadata_inventory_put = tech.machine_inventory_put,
		allow_metadata_inventory_take = tech.machine_inventory_take,
		allow_metadata_inventory_move = tech.machine_inventory_move,
		technic_run = run,
		after_place_node = data.tube and pipeworks.after_place,
		after_dig_node = tech.machine_after_dig_node,
	})

	minetest.register_node("mega_generator:mega_generator_active", {
		description = desc_on,
		tiles = {
				"mega_generator_side.png",
				"technic_machine_bottom.png",
				"mega_generator_side.png^mega_generator_overlay.png",
				"mega_generator_side.png^mega_generator_overlay.png",
				"mega_generator_side.png^mega_generator_overlay.png",
				"mega_generator_side.png^mega_generator_overlay.png"
		},
		paramtype2 = "facedir",
		groups = active_groups,
		connect_sides = {"bottom"},
		legacy_facedir_simple = true,
		sounds = default.node_sound_wood_defaults(),
		drop = "mega_generator:mega_generator",
		can_dig = tech.machine_can_dig,
		after_dig_node = tech.machine_after_dig_node,
		allow_metadata_inventory_put = tech.machine_inventory_put,
		allow_metadata_inventory_take = tech.machine_inventory_take,
		allow_metadata_inventory_move = tech.machine_inventory_move,
		on_construct = function(pos)
			local meta = minetest.get_meta(pos)
			meta:set_string("infotext", desc_on)
		end,
		technic_run = run,
		technic_on_disable = function(pos, node)
			local timer = minetest.get_node_timer(pos)
			timer:start(1)
		end,
		on_timer = function(pos, node)
			local meta = minetest.get_meta(pos)
			local node = minetest.get_node(pos)

			-- Connected back?
			if meta:get_int("LV_EU_timeout") > 0 then
				if node.name ~= "mega_generator" then
					tech.swap_node(pos, "mega_generator:mega_generator")
				end
				if meta:get_int("LV_EU_supply") ~= 0 then
				    meta:set_int("LV_EU_supply", 0)
				    meta:set_int("MV_EU_supply", 0)
				    meta:set_int("HV_EU_supply", 0)
				end
				meta:set_int("LV_EU_supply", 0)
				meta:set_int("MV_EU_supply", 0)
				meta:set_int("HV_EU_supply", 0)
				return false
			else
				if meta:get_int("LV_EU_supply") ~= data.supply_lv then
					meta:set_int("LV_EU_supply", data.supply_lv)
					meta:set_int("MV_EU_supply", data.supply_mv)
					meta:set_int("HV_EU_supply", data.supply_hv)
				end
				if node.name ~= "mega_generator_active" then
					tech.swap_node(pos, "mega_generator:mega_generator_active")
				end
			end
			if meta:get_int("MV_EU_timeout") > 0 then
				if node.name ~= "mega_generator" then
					tech.swap_node(pos, "mega_generator:mega_generator")
				end
				if meta:get_int("MV_EU_supply") ~= 0 then
				    meta:set_int("LV_EU_supply", 0)
				    meta:set_int("MV_EU_supply", 0)
				    meta:set_int("HV_EU_supply", 0)
				end
				meta:set_int("LV_EU_supply", 0)
				meta:set_int("MV_EU_supply", 0)
				meta:set_int("HV_EU_supply", 0)
				return false
			else
				if meta:get_int("MV_EU_supply") ~= data.supply_mv then
					meta:set_int("LV_EU_supply", data.supply_lv)
					meta:set_int("MV_EU_supply", data.supply_mv)
					meta:set_int("HV_EU_supply", data.supply_hv)
				end
				if node.name ~= "mega_generator_active" then
					tech.swap_node(pos, "mega_generator:mega_generator_active")
				end
			end
			if meta:get_int("HV_EU_timeout") > 0 then
				if node.name ~= "mega_generator" then
					tech.swap_node(pos, "mega_generator:mega_generator")
				end
				if meta:get_int("HV_EU_supply") ~= 0 then
				    meta:set_int("LV_EU_supply", 0)
				    meta:set_int("MV_EU_supply", 0)
				    meta:set_int("HV_EU_supply", 0)
				end
				return false
			else
				if meta:get_int("HV_EU_supply") ~= data.supply_hv then
					meta:set_int("LV_EU_supply", data.supply_lv)
					meta:set_int("MV_EU_supply", data.supply_mv)
					meta:set_int("HV_EU_supply", data.supply_hv)
				end
				if node.name ~= "mega_generator_active" then
					tech.swap_node(pos, "mega_generator:mega_generator_active")
				end
			end
		end,
	})

	tech.register_machine("LV", "mega_generator:mega_generator",        tech.producer)
	tech.register_machine("LV", "mega_generator:mega_generator_active", tech.producer)
	tech.register_machine("MV", "mega_generator:mega_generator",        tech.producer)
	tech.register_machine("MV", "mega_generator:mega_generator_active", tech.producer)
	tech.register_machine("HV", "mega_generator:mega_generator",        tech.producer)
	tech.register_machine("HV", "mega_generator:mega_generator_active", tech.producer)
end

