--[[ About this mod:
    This mod was made so technic could be playable with fun setups rather than worrying,
    about how much energy a system needs?
    This creates a device that can acheive these goals:
    1. Almost unlimited power for a single block. (No need to make a hugh reactor then convert)
    2. No need to convert the power produced to a set voltage. (This device does it by it's own,
    standards)
    3. No need for any fuel sources.

]]--

-- Setup
local path = minetest.get_modpath("mega_generator")
tech = rawget(_G, "technic") or {}

-- Settings!
mega_settings = {
	-- Can any player craft this item?
	allow_craft=true,
	-- The powers which it produces at?
	supply_lv=1000000, -- 1,000,000 (1m)
	supply_mv=1000000, -- 1,000,000 (1m)
	supply_hv=1000000  -- 1,000,000 (1m)
}

-- Execute
dofile(path.."/register.lua")
dofile(path.."/generator.lua")

--[[ Stats:

Mega Generator:
	LV Supply: 1,000,000 (1m)
	MV Supply: 1,000,000 (1m)
	HV Supply: 1,000,000 (1m)

]]--