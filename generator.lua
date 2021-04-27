minetest.register_alias("mega_generator", "mega_generator:mega_generator")

if mega_settings.allow_craft == true then
	minetest.register_craft({
		output = 'mega_generator:mega_generator',
		recipe = {
			{'technic:uranium_fuel', 'technic:uranium_fuel',   'technic:uranium_fuel'},
			{'technic:uranium_fuel', 'technic:hv_nuclear_reactor_core', 'technic:uranium_fuel'},
			{'technic:lv_transformer', 'technic:hv_transformer',       'technic:mv_transformer'},
		}
	})
end

tech.register_generator2({
	supply_lv=mega_settings.supply_lv,
	supply_mv=mega_settings.supply_mv,
	supply_hv=mega_settings.supply_hv
})

