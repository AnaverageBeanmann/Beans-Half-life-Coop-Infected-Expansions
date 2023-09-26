MAP.MapAuthor = "Lily McFluffy Butt"

-- default is 100
FUEL_MAX = 100 -- one player can handle
FollowerSpawnTime = 1

/*
if GetConVar("hl1_coop_sv_skill"):GetInt() == 1 then
	FUEL_MAX = 150 -- one player can handle
elseif GetConVar("hl1_coop_sv_skill"):GetInt() == 3 then
	FUEL_MAX = 75 -- one player can handle
elseif GetConVar("hl1_coop_sv_skill"):GetInt() == 4 then
	FUEL_MAX = 50 -- one player can handle
end
*/

function MAP:SpecialDT(ply)
	ply:NetworkVar("Int", 10, "Fuel")
end

generatorPos = Vector(0, 0, 0)

local randomgeneratorspot = math.random(1,7)
if randomgeneratorspot == 2 then
	-- Abandoned Offices Outside
	generatorPos = Vector(3944.6137695313, 4571.5522460938, 16.34646987915)
elseif randomgeneratorspot == 3 then
	-- Outside Church
	generatorPos = Vector(6257.6049804688, 225.67431640625, 208.33351135254)
elseif randomgeneratorspot == 4 then
	-- Church Parking
	generatorPos = Vector(5169.2026367188, 176.46640014648, 200.40168762207)
elseif randomgeneratorspot == 5 then
	-- Outside Church
	generatorPos = Vector(3994.1296386719, 187.93768310547, 208.40603637695)
elseif randomgeneratorspot == 6 then
	-- Inside Church
	generatorPos = Vector(2282.1418457031, 189.9232635498, 210.24209594727)
elseif randomgeneratorspot == 7 then
	-- HERESY
	generatorPos = Vector(3408.6694335938, 10232.302734375, -6799.625)
else
	-- Offices Outside
	generatorPos = Vector(2420.1264648438, 2627.7219238281, 16.384113311768)
end


local musictable = {
    ["PizzaTower.PizzaTime"] = {file = "pizza/It's_Pizza_Time.mp3", dur = 232},
    ["PizzaTower.Mondays"] = {file = "pizza/Mondays.mp3", dur = 157},
    ["PizzaTower.Tombstone"] = {file = "pizza/Tombstone_Arizona.mp3", dur = 221},
    ["PizzaTower.TrashZone"] = {file = "pizza/Tubular_Trash_Zone.mp3", dur = 139},
    ["PizzaTower.Shimbers"] = {file = "pizza/Tunnely_Shimbers.mp3", dur = 240},
    ["PizzaTower.Unearthly"] = {file = "pizza/Unearthly_Blues.mp3", dur = 218},
    ["PizzaTower.Crust"] = {file = "pizza/Bite_The_Crust.mp3", dur = 120},
    ["PizzaTower.ByeBye"] = {file = "pizza/Bye_Bye_There!.mp3", dur = 338},
    ["PizzaTower.Calzone"] = {file = "pizza/Calzonification.mp3", dur = 161},
    ["PizzaTower.Preheat"] = {file = "pizza/Don't_Preheat_Your_Oven_Because_If_You_Do_The_Song_Won't_Play.mp3", dur = 170},
    ["PizzaTower.ColdSp"] = {file = "pizza/Cold_Spaghetti.mp3", dur = 169},
    ["PizzaTower.GoodEat"] = {file = "pizza/Good_Eatin'.mp3", dur = 208},
    ["PizzaTower.HotSp"] = {file = "pizza/Hot_Spaghetti.mp3", dur = 130},
    ["PizzaTower.OregUFO"] = {file = "pizza/Oregano_UFO.mp3", dur = 222},
    ["PizzaTower.SauceMach"] = {file = "pizza/Peppino's_Sauce_Machine.mp3", dur = 125},
    ["PizzaTower.Engineer"] = {file = "pizza/Pizza_Engineer.mp3", dur = 144},
    ["PizzaTower.NeverEnd"] = {file = "pizza/Pizza_Time_Never_Ends.mp3", dur = 317},
    ["PizzaTower.Deservioli"] = {file = "pizza/The_Death_That_I_Deservioli.mp3", dur = 176},
    ["PizzaTower.Bone"] = {file = "pizza/There's_A_Bone_In_My_Spaghetti.mp3", dur = 185},
    ["PizzaTower.Theat"] = {file = "pizza/Theatrical_Shenanigans.mp3", dur = 116},
    ["PizzaTower.Show"] = {file = "pizza/Put_On_A_Show.mp3", dur = 171},
    ["PizzaTower.Freak"] = {file = "pizza/Dungeon_Freakshow.mp3", dur = 212},
    ["PizzaTower.Wud"] = {file = "pizza/Wudpecker.mp3", dur = 209},
    ["PizzaTower.Thousand"] = {file = "pizza/Thousand_March.mp3", dur = 268},
    ["PizzaTower.UnexPart1"] = {file = "pizza/Unexpectancy_Part1.mp3", dur = 158},
    ["PizzaTower.UnexPart2"] = {file = "pizza/Unexpectancy_Part2.mp3", dur = 177},
    ["PizzaTower.Overcooked"] = {file = "pizza/Overcooked_Meat_Lover.mp3", dur = 128},
    ["PizzaTower.Nightmare"] = {file = "pizza/Leaning_Nightmare.mp3", dur = 139},
    ["PizzaTower.Spooky"] = {file = "pizza/Spooky_Apartment_Escape.mp3", dur = 167},
    ["PizzaTower.UnexPart3"] = {file = "pizza/Unexpectancy_Part3.mp3", dur = 237},
    ["PizzaTower.FatAss"] = {file = "pizza/Your_Fat_Ass_Slows_You_Down.mp3", dur = 5},
    ["PizzaTower.Campers"] = {file = "pizza/Okay_Campers,_Rise_And_Shine!.mp3", dur = 53},
    ["PizzaTower.Munch"] = {file = "pizza/Hard_Drive_To_Munch_You.mp3", dur = 39},
    ["PizzaTower.Meatophobia"] = {file = "pizza/Meatophobia.mp3", dur = 51},
    ["PizzaTower.Smackdown"] = {file = "pizza/Time_For_A_Smackdown.mp3", dur = 60},
    ["PizzaTower.Hairline"] = {file = "pizza/Receding_Hairline_Celebration_Party.mp3", dur = 179},
    ["PizzaTower.Pieing"] = {file = "pizza/Pizza_Pie-Ing.mp3", dur = 130},
    ["PizzaTower.Deluxe"] = {file = "pizza/Pizza_Deluxe.mp3", dur = 134},
    ["PizzaTower.Italian"] = {file = "pizza/Hip_To_Be_Italian.mp3", dur = 72},
    ["PizzaTower.Toppings"] = {file = "pizza/Choosing_The_Toppings.mp3", dur = 128},

	["FAITH.Annunciation"] = {file = "faith/intro/anunciation.mp3", dur = 28},

	["FAITH.Church"] = {file = "faith/waves/church.mp3", dur = 336},
	["FAITH.Cornfield"] = {file = "faith/waves/cornfield.mp3", dur = 523},
	["FAITH.Clinic"] = {file = "faith/waves/creepy_clinic.mp3", dur = 58},
	["FAITH.Daycare"] = {file = "faith/waves/daycare.mp3", dur = 216},
	["FAITH.Dropdead"] = {file = "faith/waves/daycare.mp3", dur = 193},
	["FAITH.Etrude"] = {file = "faith/waves/revolutionary_etrude_op_10_no_12.mp3", dur = 133},
	["FAITH.Garyland"] = {file = "faith/waves/garyland.mp3", dur = 353},
	["FAITH.Gnossienne"] = {file = "faith/waves/gnossienne.mp3", dur = 196},
	["FAITH.Heck"] = {file = "faith/waves/heckin_noise_vip_x_soundgoodizer.mp3", dur = 127},
	["FAITH.Knock"] = {file = "faith/waves/knock_knock.mp3", dur = 102},
	["FAITH.Sonata"] = {file = "faith/waves/moonlight_sonata.mp3", dur = 368},
	["FAITH.Waking"] = {file = "faith/waves/the_waking_world.mp3", dur = 85},

	["FAITH.Astaroth"] = {file = "faith/holdout/astaroth.mp3", dur = 148},
	["FAITH.Malphas"] = {file = "faith/holdout/malphas.mp3", dur = 149},
	["FAITH.Miriam"] = {file = "faith/holdout/super_miriam.mp3", dur = 200},

	["FAITH.Vs"] = {file = "faith/final_escape/vs_mode.mp3", dur = 245},

	["FAITH.Forever"] = {file = "faith/escape_fail/they_are_mine_forever.mp3", dur = 69},

	["Mash.Fridays"] = {file = "mash/intro/Fridays.mp3", dur = 159},
	["Mash.Halloweentro"] = {file = "mash/intro/Halloween_Town_Intro.mp3", dur = 140},

	["Mash.Bath"] = {file = "mash/wave/Devil's_Bath_Boys.mp3", dur = 203},
	["Mash.Dive"] = {file = "mash/wave/Dive_to_the_Heart.mp3", dur = 293},
	["Mash.Ravenous"] = {file = "mash/wave/Fast_and_Ravenous.mp3", dur = 157},
	["Mash.Halloweembat"] = {file = "mash/wave/Halloween_Town_Combat.mp3", dur = 131},
	["Mash.Haunted"] = {file = "mash/wave/Haunted_Fortress_2.mp3", dur = 81},
	["Mash.Hideout"] = {file = "mash/wave/Hideout_Assault.mp3", dur = 192},
	["Mash.Dark"] = {file = "mash/wave/Little_Dark_Age.mp3", dur = 298},
	["Mash.Meatnight"] = {file = "mash/wave/Meatnight_Club.mp3", dur = 208},
	["Mash.Misfortune"] = {file = "mash/wave/Misfortune_Teller.mp3", dur = 155},
	["Mash.Monster"] = {file = "mash/wave/Monster_Mash.mp3", dur = 188},
	["Mash.Stake"] = {file = "mash/wave/Peper_Stake.mp3", dur = 136},
	["Mash.Behind"] = {file = "mash/wave/Right_Behind_You.mp3", dur = 100},
	["Mash.Scherzo"] = {file = "mash/wave/Scherzo_de_Notte.mp3", dur = 106},
	["Mash.Snakalm"] = {file = "mash/wave/Snake_Eyes_Calm.mp3", dur = 112},
	["Mash.Watching"] = {file = "mash/wave/Somebody's_Watching_Me.mp3", dur = 236},
	["Mash.Skeletons"] = {file = "mash/wave/Spooky_Scary_Skeletons.mp3", dur = 126},
	["Mash.Rage"] = {file = "mash/wave/Street_of_Rage.mp3", dur = 224},
	["Mash.Mark"] = {file = "mash/wave/The_Mark.mp3", dur = 255},
	["Mash.Spaghetti"] = {file = "mash/wave/There's_A_Bone_In_My_Spaghetti.mp3", dur = 185},
	["Mash.Thriller"] = {file = "mash/wave/Thriller.mp3", dur = 318},
	["Mash.Dracula"] = {file = "mash/wave/Tocatta_and_Fugue_in_D_Minor.mp3", dur = 558},
	["Mash.Arizona"] = {file = "mash/wave/Tombstone_Arizona.mp3", dur = 221},
	["Mash.Shimbers"] = {file = "mash/wave/Tunnely_Shimbers.mp3", dur = 238},
	["Mash.Bustin"] = {file = "mash/wave/Bustin.mp3", dur = 237},
	["Mash.Ghostbusters"] = {file = "mash/wave/Ghostbusters.mp3", dur = 244},

	["Mash.Avatar"] = {file = "mash/holdout/Avatar_Beat.mp3", dur = 179},
	["Mash.Brain"] = {file = "mash/holdout/Brain_Dead.mp3", dur = 128},
	["Mash.Destiny"] = {file = "mash/holdout/Destiny's_Force.mp3", dur = 167},
	["Mash.Orchestra"] = {file = "mash/holdout/Fake_Orchestra.mp3", dur = 180},
	["Mash.Fragments"] = {file = "mash/holdout/Fragments_of_Sorrow.mp3", dur = 135},
	["Mash.Snakcombat"] = {file = "mash/holdout/Snake_Eyes_Combat.mp3", dur = 112},
	["Mash.Gertrude"] = {file = "mash/holdout/The_Incredible_Gertrude.mp3", dur = 161},

	["Mash.Forze"] = {file = "mash/escape/Forze_de_Male.mp3", dur = 213},
	["Mash.Sonata"] = {file = "mash/escape/Moonlight_Sonata_3rd_Movement.mp3", dur = 411},
	["Mash.Fate"] = {file = "mash/escape/Night_of_Fate.mp3", dur = 125},
	["Mash.Unreasonable"] = {file = "mash/escape/Unreasonable_Behavior.mp3", dur = 120},

	["Mash.VeryHard_Altar"] = {file = "mash/very_hard_special/wave/Beneath_the_Altar.mp3", dur = 192},
	["Mash.VeryHard_Cannon"] = {file = "mash/very_hard_special/wave/Hand_Cannon.mp3", dur = 318},
	["Mash.VeryHard_Chaos"] = {file = "mash/very_hard_special/wave/Crypted_Chaos.mp3", dur = 217},
	["Mash.VeryHard_Destruction"] = {file = "mash/very_hard_special/wave/Departure_to_Destruction.mp3", dur = 233},
	["Mash.VeryHard_Dusk"] = {file = "mash/very_hard_special/wave/Dusk.mp3", dur = 161},
	["Mash.VeryHard_Endless"] = {file = "mash/very_hard_special/wave/Endless.mp3", dur = 257},
	["Mash.VeryHard_Erebus"] = {file = "mash/very_hard_special/wave/Erebus_Reaction.mp3", dur = 307},
	["Mash.VeryHard_Gate"] = {file = "mash/very_hard_special/wave/Keepers_of_the_Gate.mp3", dur = 293},
	["Mash.VeryHard_Handgun"] = {file = "mash/very_hard_special/wave/Handgun_Harmony.mp3", dur = 293},
	["Mash.VeryHard_Hell"] = {file = "mash/very_hard_special/wave/Burn_In_Hell.mp3", dur = 240},
	["Mash.VeryHard_Machine"] = {file = "mash/very_hard_special/wave/Murder_Machine_Inc.mp3", dur = 234},
	["Mash.VeryHard_Nowhere"] = {file = "mash/very_hard_special/wave/Nowhere.mp3", dur = 240},
	["Mash.VeryHard_Occultivated"] = {file = "mash/very_hard_special/wave/Occultivated.mp3", dur = 165},
	["Mash.VeryHard_Reflections"] = {file = "mash/very_hard_special/wave/Reflections_of_Violence.mp3", dur = 305},
	["Mash.VeryHard_Tension"] = {file = "mash/very_hard_special/wave/Tension_Ascension.mp3", dur = 278},

	["Mash.VeryHard_Thousand"] = {file = "mash/very_hard_special/wave/Thousand_March.mp3", dur = 268},

	["Mash.VeryHard_Apostasy"] = {file = "mash/very_hard_special/holdout/Altars_of_Apostasy.mp3", dur = 340},
}
 
for k,v in pairs(musictable) do
    sound.Add({
        name = k,
        channel = CHAN_STATIC,
        volume = 1,
        level = 0,
        pitch = 100,
        sound = "*#music/hl1coop_inf/"..v.file
    })
 
    if CLIENT then
        MUSIC_TRACK_DURATION[k] = v.dur
    end
end

if CLIENT then

	function SB_PlayerLineExtra(panel)
		panel.Fuel = panel:Add( "DLabel" )
		panel.Fuel:Dock( RIGHT )
		panel.Fuel:SetWidth( 80 )
		panel.Fuel:SetFont( "HL1Coop_ScoreboardDefault" )
		panel.Fuel:SetTextColor( Color( 93, 93, 93 ) )
		panel.Fuel:SetContentAlignment( 5 )
	end

	function SB_PlayerLineExtra_Think(panel, ply)
		if ( panel.NumFuel == nil || panel.NumFuel != ply:GetFuel() ) then
			panel.NumFuel = ply:GetFuel()
			panel.Fuel:SetText( panel.NumFuel )
		end
	end

	function SB_TitleExtra(panel)
		panel.TitleFuel = panel:Add( "DLabel" )
		panel.TitleFuel:SetFont( "HL1Coop_ScoreboardDefaultTitle" )
		panel.TitleFuel:SetText( "Fuel" )
		panel.TitleFuel:SetTextColor( Color( 255, 240, 0, 255 ) )
		panel.TitleFuel:Dock(TOP)
		panel.TitleFuel:DockMargin( 0, 0, 385, -32 )
		panel.TitleFuel:SetHeight( 32 )
		panel.TitleFuel:SetContentAlignment( 6 )
		panel.TitleFuel:SetExpensiveShadow( 2, Color( 0, 0, 0, 180 ) )
	end

	local icon_barrel = Material("hl1coop_inf/barrel.png")
	local fuel_number = 0

	function MAP:DrawOnScreen()
		local ply = LocalPlayer()
		if GAMEMODE:GetRoundState() == ROUND_PREPARE and ply:Alive() and !ply:IsSuitEquipped() then
			local alpha = math.sin(RealTime() * 10) * 30 + 220
			kewlText(lang.hud_findhev, "HL1Coop_text", ScrW() / 2, ScrH() / 5, Color(255,210,50,alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
		end

		-- fuel
		if GAMEMODE:GetObjective() == 0 and ply:Alive() then
			local taskfont = "HL1Coop_task"
			surface.SetFont(taskfont)
			fuel_number = Lerp(FrameTime() * 5, fuel_number, ply:GetFuel())
			local fuel_text = lang.hud_fuel..": "..math.Round(fuel_number).."/"..FUEL_MAX
			local fuel_text_w, fuel_text_h = surface.GetTextSize(fuel_text)
			local fuel_col = Color(255, 210, 50, 220)
			
			local rectG = 20

			local icon_size = fuel_text_h * 2.2

			local frame_w, frame_h = fuel_text_w + icon_size / 2, fuel_text_h
			local frame_x, frame_y = 20, ScrH() / 4

			local icon_x, icon_y = 0, frame_y - frame_h / 2 - 2
			
			if GSRCHUD and GSRCHUD.isEnabled() then
				local themeCol = GSRCHUD.getCurrentColour()
				fuel_col.r, fuel_col.g, fuel_col.b = themeCol.r, themeCol.g + 30, themeCol.b
			end

			surface.SetDrawColor(0, 0, 0, 100)
			surface.DrawRect(frame_x - rectG / 2, frame_y - rectG / 2, frame_w + rectG, frame_h + rectG)
			draw.OutlinedBox(frame_x - rectG / 2, frame_y - rectG / 2, frame_w + rectG, frame_h + rectG, 3, HintFrameColor())

			surface.SetDrawColor(255,255,255,255)
			surface.SetMaterial(icon_barrel)
			surface.DrawTexturedRect(icon_x, icon_y, icon_size, icon_size)

			kewlText(fuel_text, taskfont, frame_x + icon_size / 2, frame_y, fuel_col, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		end

		--gen
		if ShowPlayerDist and ShowPlayerDist > RealTime() then
			local alpha = math.Clamp((ShowPlayerDist - RealTime()) * 100, 0, 255)
			GAMEMODE:HUDDrawDistance(generatorPos, lang.hud_generator, Color(255, 180, 50, alpha))
		end
	end

else

resource.AddWorkshop("242386747") -- map

MAP.StartingWeapons = {"weapon_crowbar", "weapon_glock"}

MAP.WaveStartTime = 90
MAP.WaveDuration = 180
MAP.EvacuationTime = 90
MAP.PortalPrepareTime = 120

if GetConVar("hl1_coop_sv_skill"):GetInt() == 2 then -- Medium
	MAP.WaveDuration = 240
end
if GetConVar("hl1_coop_sv_skill"):GetInt() == 3 then -- Hard
	MAP.StartingWeapons = {"weapon_crowbar", "weapon_357"}
	MAP.WaveStartTime = 60
	MAP.WaveDuration = 240
end
if GetConVar("hl1_coop_sv_skill"):GetInt() == 4 then -- Very Hard
	MAP.StartingWeapons = {"weapon_crowbar", "weapon_357"}
	MAP.WaveStartTime = 120
	MAP.WaveDuration = 240
	MAP.PortalPrepareTime = 255
end

-- MAP.ZombieSet = 1
	-- 1 = LNR: HL2 - HL2 Zombies
	-- 2 = LNR: HL2 - Rebels
	-- 3 = HLA Antlions
-- if GetConVar("BBoHLCIMCEC_Enemies"):GetInt() == 1 then
	-- 2 = LNR: HL2 - Rebels
	-- MAP.ZombieSet = 2
-- elseif GetConVar("BBoHLCIMCEC_Enemies"):GetInt() == 2 then
	-- 3 = HLA Antlions
	-- MAP.ZombieSet = 3
	-- MAP.MAX_SPAWNED_NPCS = 8
-- elseif GetConVar("BBoHLCIMCEC_Enemies"):GetInt() == 3 then
	-- MAP.ZombieSet = 4
-- else
	-- 1 = LNR: HL2 - HL2 Zombies
	MAP.ZombieSet = 1
-- end

MAP.MapStartMusic = "Mash.Halloweentro"
if math.random(1,2) == 1 then
	MAP.MapStartMusic = "Mash.Fridays"
end
MAP.WaveMusic = {
	"Mash.Bath",
	"Mash.Dive",
	"Mash.Ravenous",
	"Mash.Halloweembat",
	"Mash.Haunted",
	"Mash.Hideout",
	"Mash.Dark",
	"Mash.Meatnight",
	"Mash.Misfortune",
	"Mash.Monster",
	"Mash.Stake",
	-- "Mash.Behind",
	"Mash.Scherzo",
	"Mash.Snakalm",
	"Mash.Watching",
	"Mash.Skeletons",
	"Mash.Rage",
	"Mash.Mark",
	"Mash.Spaghetti",
	"Mash.Dracula",
	"Mash.Arizona",
	"Mash.Thriller",
	"Mash.Bustin",
	"Mash.Ghostbusters",
	"Mash.Shimbers"
}
MAP.EvacMusic = {
	"Mash.Forze",
	"Mash.Sonata",
	"Mash.Fate",
	"Mash.Unreasonable"
}
if GetConVar("hl1_coop_sv_bhlcie_lilyhalloween_music"):GetInt() == 1 then
	MAP.MapStartMusic = "FAITH.Annunciation"
	MAP.WaveMusic = {
		"FAITH.Church",
		"FAITH.Cornfield",
		"FAITH.Clinic",
		"FAITH.Daycare",
		"FAITH.Dropdead",
		"FAITH.Garyland",
		"FAITH.Gnossienne",
		"FAITH.Heck",
		"FAITH.Knock",
		"FAITH.Sonata",
		"FAITH.Etrude",
		"FAITH.Waking"
	}
	MAP.EvacMusic = {
		"FAITH.Vs"
	}
end
if GetConVar("hl1_coop_sv_skill"):GetInt() == 4 then -- special music for very hard
	MAP.MapStartMusic = "FAITH.Forever"
	MAP.WaveMusic = {
		"Mash.VeryHard_Altar",
		"Mash.VeryHard_Cannon",
		"Mash.VeryHard_Chaos",
		"Mash.VeryHard_Destruction",
		"Mash.VeryHard_Dusk",
		"Mash.VeryHard_Endless",
		"Mash.VeryHard_Erebus",
		"Mash.VeryHard_Gate",
		"Mash.VeryHard_Handgun",
		"Mash.VeryHard_Hell",
		"Mash.VeryHard_Machine",
		"Mash.VeryHard_Nowhere",
		"Mash.VeryHard_Occultivated",
		"Mash.VeryHard_Reflections",
		"Mash.VeryHard_Tension",
		"Mash.VeryHard_Thousand"
	}
end

MAP.PortalPoints = {
	Vector(2190.319580, 190.856781, 320.031250),
	Vector(5465.444824, 191.818253, 248.031250),
	Vector(4519.316406, 9490.525391, -6665.026855),
	Vector(3085.665283, 4610.524902, 298.771240),
	Vector(2611.076660, 1779.053467, 350.994202),
	Vector(2862.596436, 872.457703, 144.031250),
	Vector(1878.959961, 2124.636963, -299.968750)
}

MAP.AlienSpawnClasses = {
	"",
}

MAP.AlienSpawnPoints = {
	-- Floor 1
	Vector(-5141,5673,-684),
	Vector(-4773,5685,-684),
	Vector(-5773,6837,-684),
	Vector(-6901,2847,-651),
	Vector(-6712,2316,-687),
	Vector(-6899,2015,-687),
	-- Floor 0
	Vector(-12537,4425,-6082),
	Vector(-8610,4664,-5819),
	Vector(-7227,5801,-5688),
	-- Caves
	Vector(-7580,7019,-7541),
	Vector(-7361,8697,-7563),
	Vector(-9193,5834,-7946),
	Vector(-9552,5261,-7975),
	Vector(-10084,5677,-7945),
	Vector(-8363,3461,-8099),
	Vector(-6774,3207,-8176),
	-- Floor -1
	Vector(-6526,5987,-8384),
	Vector(-6556,4792,-8384)
}

local cvar_maxfuel = CreateConVar("fuel_target", "", FCVAR_NOTIFY, "If set, the generator uses this value")
cvars.AddChangeCallback("fuel_target", function(name, value_old, value_new)
	local ent = ents.FindByClass("hl1_inf_generator")[1]
	if IsValid(ent) then
		if value_new == "" then
			ent:SetupMaxFuel()
			return
		end
		value_new = tonumber(value_new)
		if value_new > 0 then
			ent:SetMaxFuel(value_new)
		else
			ent:SetupMaxFuel()
		end
	end
end)

function MAP:GetMapObjectives()
	local obj = {
		[0] = "#notify_collectfuel",
		[1] = "#notify_activatelocator",
		[2] = "#obj_xen_6"
	}
	return obj
end

function MAP:GetCommonFuel()
	local fuel = 0
	for _, barrel in pairs(ents.FindByClass("hl1_collectable_barrel")) do
		if barrel.Fuel then
			fuel = fuel + barrel.Fuel
		end
	end
	for _, trigger in pairs(ents.FindByClass("hl1_trigger_func")) do
		if trigger.Fuel then
			fuel = fuel + trigger.Fuel
		end
	end
	if IsValid(generatorEnt) then
		fuel = fuel + generatorEnt:GetFuel()
	end
	return fuel
end

function MAP:FuelMultiplier()
	local commonFuel, maxFuel = self:GetCommonFuel(), generatorEnt:GetMaxFuel()
	if commonFuel < maxFuel then
		return maxFuel / commonFuel
	end
	return 1
end

function MAP:OnBarrelExplode(ent)
	if self:GetCommonFuel() - ent.Fuel <= 0 and IsValid(generatorEnt) and !generatorEnt:IsFull() then
		GAMEMODE:GameOver(false, "There is no fuel anymore")
	end
end

local siren
local sirenSnd = Sound("music/hl1coop_inf/pizza/PizzafaceLaugh2.mp3")
function MAP:GameOverEvent()
	local roundState = GAMEMODE:GetRoundState()

	local dummyEnt = ents.Create("item_battery")
	if IsValid(dummyEnt) then
		dummyEnt:SetPos(Vector(1263, -3103, 1874))
		dummyEnt:Spawn()
		dummyEnt:SetMoveType(MOVETYPE_NONE)
		dummyEnt:SetSolid(SOLID_NONE)
		dummyEnt:SetNoDraw(true)

		siren = CreateSound(dummyEnt, sirenSnd)
		siren:SetSoundLevel(0)
		siren:Play()
	end

	GAMEMODE:PlayGlobalMusic("FAITH.Forever")

	timer.Simple(5, function()
		if siren and siren:IsPlaying() then
			siren:Stop()
		end
		if GAMEMODE:GetRoundState() == roundState then
			GAMEMODE:EmitGlobalSound("music/hl1coop_inf/faith/Supermirim1.mp3", 100)
			for k, v in pairs(player.GetAll()) do
				v:ScreenFade(SCREENFADE.IN, Color(255, 255, 255, 255), 3, 1)
				if v:Alive() then
					v:Kill()
				end
			end
			for k, v in pairs(ents.GetAll()) do
				if v:IsNPC() and v:Health() > 0 then
					v:TakeDamage(9999, game.GetWorld(), game.GetWorld())
				end
			end
			GAMEMODE:GameOver(false, "#game_evacfailed")
		end
	end)
end

function MAP:CreateViewPoints()
	GAMEMODE:CreateViewPointEntity(Vector(2112.721436, 3075.480225, 257.789734), Angle(7.310141, -50.321629, 0.000000))
	GAMEMODE:CreateViewPointEntity(Vector(2277.636230, 1673.779053, 185.991486), Angle(13.281831, -47.644657, 0.000000))
	GAMEMODE:CreateViewPointEntity(Vector(4451.585449, 3149.213623, 180.024994), Angle(12.664083, -119.305298, 0.000000))
	GAMEMODE:CreateViewPointEntity(Vector(4659.298340, 4327.850098, 34.110806), Angle(-3.706540, 153.075409, 0.000000))
	GAMEMODE:CreateViewPointEntity(Vector(4538.520020, 193.234238, 295.405090), Angle(-3.397670, -179.948746, 0.000000))
	GAMEMODE:CreateViewPointEntity(Vector(3036.633545, -65.312126, 366.160370), Angle(10.707853, 141.853165, 0.000000))
	GAMEMODE:CreateViewPointEntity(Vector(3843.194336, 8084.050293, -7248.058594), Angle(11.531533, 140.025513, 0.000000))
	GAMEMODE:CreateViewPointEntity(Vector(3718.121582, 8036.161621, -7256.020996), Angle(6.486495, 111.814552, 0.000000))
	GAMEMODE:CreateViewPointEntity(Vector(3689.374023, 9544.483398, -6755.017578), Angle(-1.235524, -144.864822, 0.000000))
	GAMEMODE:CreateViewPointEntity(Vector(2956.134766, 10411.658203, -6764.526855), Angle(-18.223965, -18.377998, 0.000000))	
end

local function CreateSuitEntity(pos, ang)
	local suit = ents.Create("item_suit")
	if IsValid(suit) then
		suit:SetPos(pos)
		suit:SetAngles(ang)
		suit.dontRemove = true
		suit.Respawnable = true
		suit:Spawn()
	end
end

local function CreateBarrel(pos, fuel, ang)
	ang = ang or Angle()
	local ent = ents.Create("hl1_collectable_barrel")
	if IsValid(ent) then
		ent:SetPos(pos + Vector(0,0,32))
		ent:SetAngles(ang)
		ent:Spawn()
		if fuel then
			ent:SetFuel(fuel)
		end
	end
end

local function CreateFuelTrigger(mins, maxs, fuel)
	local fTrig = ents.Create("hl1_trigger_func")
	if IsValid(fTrig) then
		fTrig.Fuel = fuel
		function fTrig:StartTouch(ent)
			if ent:IsPlayer() and ent:Alive() then
				if self.Fuel > 0 then
					self.Fuel = math.ceil(self.Fuel * MAP:FuelMultiplier())
					local plyFuel = ent:GetFuel()
					if plyFuel >= FUEL_MAX then
						ent:TextMessageCenter("#game_cantgetmorefuel", 1.5)
						return
					end
					local num = self.Fuel
					if self.Fuel + plyFuel >= FUEL_MAX then
						num = FUEL_MAX - plyFuel
					end
					ent:SetFuel(plyFuel + num)
					STATS:AddFuel(ent, num)
					ent:TextMessageCenter("#game_yougot "..num.." #game_yougotfuel2", 2)
					self.Fuel = self.Fuel - num
					ent:EmitSound("player/pl_wade"..math.random(1,4)..".wav")
				end
				if self.Fuel <= 0 then
					self:Remove()
				end
			end
		end
		fTrig:Spawn()
		fTrig:SetCollisionBoundsWS(mins, maxs)
	end
end

local function CreateDeadBody_Sci(pos, ang, pose, bodygr)
	ang = ang or Angle()
	pose = pose or 36
	bodygr = bodygr or math.random(0, 4)
	local ent = ents.Create("prop_dynamic")
	if IsValid(ent) then
		ent:SetPos(pos)
		ent:SetAngles(ang)
		ent:SetModel("models/scientist.mdl")
		ent:SetBodygroup(1, bodygr)
		if bodygr == 2 then
			ent:SetSkin(1)
		end
		ent:Spawn()
		ent:SetSequence(pose)
	end
end

function MAP:FixMapEntities()
	local npcs = ents.FindByClass("npc_*")
	table.Add(npcs, ents.FindByClass("monster_*"))
	for k, v in pairs(npcs) do
		v:AddFlags(FL_NOTARGET)
	end
end

local function CreateButtonSprite(button, name)
	local sprite = ents.Create("env_sprite")
	if IsValid(sprite) then
		sprite:SetPos(button:GetPos())
		sprite:SetParent(button)
		sprite:SetKeyValue("model", "sprites/glow08.vmt")
		sprite:SetKeyValue("scale", ".15")
		sprite:SetKeyValue("rendermode", "9")
		sprite:SetKeyValue("rendercolor", "100 200 100")
		sprite:Spawn()
		sprite:Activate()
		sprite:SetName(name)
		sprite:Fire("HideSprite")
		button:Fire("AddOutput", "OnIn "..name..":ShowSprite:0:-1")
		button:Fire("AddOutput", "OnOut "..name..":HideSprite:0:-1")
	end
end

function GM:BHLCIE_CreateSpawner(pos, ang, ztype, freq)
	ztype = ztype or 0
	freq = freq or 1
	local ent = ents.Create("ent_bhlcie_lily_halloween")
	if IsValid(ent) then
		ent:SetZombieType(ztype)
		ent:SetSpawnFrequency(freq)
		ent:SetPos(pos)
		ent:SetAngles(ang)
		ent:Spawn()
		debugPrint("Created zombie spawner", ent, pos, ang, ztype, freq)
	end
end

function GM:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(pos, ang, ztype, freq)
	ztype = ztype or 0
	freq = freq or 1
	local ent = ents.Create("ent_bhlcie_hl1_modified")
	if IsValid(ent) then
		ent:SetZombieType(ztype)
		ent:SetSpawnFrequency(freq)
		ent:SetPos(pos)
		ent:SetAngles(ang)
		ent:Spawn()
		debugPrint("Created zombie spawner", ent, pos, ang, ztype, freq)
	end
end

function MAP:ModifyMapEntities()
	-- local randomspawnpoints = math.random(1,10)
	-- if randomspawnpoints == 1 then
		-- GAMEMODE:CreateCoopSpawnpoints(Vector(-7957,5378,196), Angle(9,74,0))
	-- elseif randomspawnpoints == 2 then
		-- GAMEMODE:CreateCoopSpawnpoints(Vector(-3564,6390,-652), Angle(6,169,0))
	-- elseif randomspawnpoints == 3 then
		-- GAMEMODE:CreateCoopSpawnpoints(Vector(-6742,6782,-5689), Angle(4,-92,0))
	-- elseif randomspawnpoints == 4 then
		-- GAMEMODE:CreateCoopSpawnpoints(Vector(-12659,4517,-6082), Angle(3,-25,0))
	-- elseif randomspawnpoints == 5 then
		-- GAMEMODE:CreateCoopSpawnpoints(Vector(-8147,4005,-5885), Angle(0,0,0))
	-- elseif randomspawnpoints == 6 then
		-- GAMEMODE:CreateCoopSpawnpoints(Vector(-7559,6744,-7521), Angle(-1,93,0))
	-- elseif randomspawnpoints == 7 then
		-- GAMEMODE:CreateCoopSpawnpoints(Vector(-9416,5541,-7977), Angle(-3,-118,0))
	-- elseif randomspawnpoints == 8 then
		-- GAMEMODE:CreateCoopSpawnpoints(Vector(-6543,5286,-8385), Angle(-0,117,0))
	-- elseif randomspawnpoints == 9 then
		-- GAMEMODE:CreateCoopSpawnpoints(Vector(-5742,3004,592), Angle(2,177,0))
	-- else
		-- GAMEMODE:CreateCoopSpawnpoints(Vector(-6335,5642,-687), Angle(2,169,0))
	-- end

	GAMEMODE:CreateCoopSpawnpoints(Vector(2129.787354, 2627.297852, 64.031250), Angle(0,0,0))
	-- GAMEMODE:CreateCoopSpawnpoints(Vector(4013.361328, 5117.553711, 64.383469), Angle(0,0,0))
	-- GAMEMODE:CreateCoopSpawnpoints(Vector(6461.334961, 221.365097, 256.031250), Angle(0,0,0))
	-- GAMEMODE:CreateCoopSpawnpoints(Vector(2328.089355, 191.393036, 256.031250), Angle(0,0,0))
	-- GAMEMODE:CreateCoopSpawnpoints(Vector(3449.708008, 10256.290039, -6751.315430), Angle(0,0,0))

	michaledavvie = ents.Create("npc_bhlcie_michael")
	if IsValid(michaledavvie) then
		michaledavvie:SetPos(Vector(6950.597656, -2198.454834, 384.031250))
		michaledavvie:SetAngles(Angle(0,0,0))
		michaledavvie:Spawn()
	end

	abandonedofficeboardbreakingbarrelbastard = ents.Create("prop_physics")
	if IsValid(abandonedofficeboardbreakingbarrelbastard) then
		abandonedofficeboardbreakingbarrelbastard:SetModel("models/props_c17/oildrum001_explosive.mdl")
		abandonedofficeboardbreakingbarrelbastard:SetPos(Vector(2941.2880859375, 4416.580078125, 32.3759765625))
		abandonedofficeboardbreakingbarrelbastard:SetAngles(Angle(0,0,0))
		abandonedofficeboardbreakingbarrelbastard:Spawn()
		abandonedofficeboardbreakingbarrelbastard:Ignite(60)
	end

	if GetConVar("hl1_coop_sv_skill"):GetInt() == 2 then
		FollowerSpawnTime = math.random(180,600)
	elseif GetConVar("hl1_coop_sv_skill"):GetInt() == 3 then
		FollowerSpawnTime = math.random(60,500)
	elseif GetConVar("hl1_coop_sv_skill"):GetInt() == 4 then
		FollowerSpawnTime = math.random(5,10)
	else
		FollowerSpawnTime = math.random(300,1200)
	end
	timer.Simple(FollowerSpawnTime,function() if !IsValid(thefollower) then
		thefollower = ents.Create("npc_bhlcie_follower")
		if IsValid(thefollower) then
			thefollower:SetPos(Vector(6704.903320, -2236.514160, 384.031250))
			thefollower:SetAngles(Angle(0,0,0))
			thefollower:Spawn()
		end
	end end)

	locatorEnt = ents.Create("hl1_inf_locator")
	if IsValid(locatorEnt) then
		locatorEnt:SetPos(Vector(3234.922119, 192.128387, 512.031250))
		locatorEnt:SetAngles(Angle(0,-135,-180))
		locatorEnt:Spawn()
	end
	generatorEnt = ents.Create("hl1_inf_generator")
	if IsValid(generatorEnt) then
		generatorEnt:SetPos(generatorPos)
		if randomgeneratorspot == 2 then
			generatorEnt:SetAngles(Angle(0,263,0))
		elseif randomgeneratorspot == 3 then
			generatorEnt:SetAngles(Angle(0,90,0))
		elseif randomgeneratorspot == 6 then
			generatorEnt:SetAngles(Angle(0,-90,0))
		elseif randomgeneratorspot == 7 then
			generatorEnt:SetAngles(Angle(0,-90,0))
		else
			generatorEnt:SetAngles(Angle(0,173,0))
		end
		generatorEnt:Spawn()
		local cvar_int = cvar_maxfuel:GetInt()
		if cvar_int > 0 then
			generatorEnt:SetMaxFuel(cvar_int)
		end
	end
	panelEnt = ents.Create("hl1_inf_panel")
	if IsValid(panelEnt) then
		if randomgeneratorspot == 2 then
			-- Abandoned Offices Outside
			panelEnt:SetPos(Vector(3940.9086914063, 4530.583984375, 50.464893341064))
			panelEnt:SetAngles(Angle(-3.5763947963715, -96.483848571777, 0.0517578125))
		elseif randomgeneratorspot == 3 then
			-- Outside Church
			panelEnt:SetPos(Vector(6257.9482421875, 177.44621276855, 242.3681640625))
			panelEnt:SetAngles(Angle(-3.5754549503326, -93.354995727539, 0.0011329707922414))
		elseif randomgeneratorspot == 4 then
			-- Church Parking
			panelEnt:SetPos(Vector(5120.8383789063, 175.91633605957, 234.2946472168))
			panelEnt:SetAngles(Angle(-3.6172413825989, -180.98170471191, -0.0179443359375))
		elseif randomgeneratorspot == 5 then
			-- Infront of Church
			panelEnt:SetPos(Vector(3949.6708984375, 192.32247924805, 242.38980102539))
			panelEnt:SetAngles(Angle(-3.4424676895142, 176.61100769043, -0.000579833984375))
		elseif randomgeneratorspot == 6 then
			-- Inside Church
			panelEnt:SetPos(Vector(2248.1418457031, 189.9232635498, 260.24209594727))
			panelEnt:SetAngles(Angle(22.671382904053, 0.35688257217407, 0.14841391146183))
		elseif randomgeneratorspot == 7 then
			-- HERESY
			panelEnt:SetPos(Vector(3370.255859375, 10231.678710938, -6765.6796875))
			panelEnt:SetAngles(Angle(-3.531031370163, -179.82649230957, -0.01434326171875))
		else
			-- Offices Outside
			panelEnt:SetPos(Vector(2468.5112304688, 2628.0573730469, 50.286380767822))
			panelEnt:SetAngles(Angle(-3.5681574344635, -0.3117094039917, 0.0036558688152581))
		end
		panelEnt:Spawn()
		panelEnt:SetGenerator(generatorEnt)
		panelEnt:SetLocator(locatorEnt)
	end

	function panelEnt:Use(activator)
		if self.NextUse > CurTime() then return end
		self.NextUse = CurTime() + 1
		if activator:IsPlayer() then
			if !IsValid(self.GeneratorEnt) or !self.GeneratorEnt:IsEnabled() then
				self:EmitSound("buttons/button2.wav")
			elseif self.Activated and IsValid(self.LocatorEnt) and !self.LocatorEnt:IsActivated() then
				GAMEMODE:SetObjective(2)
				self:EmitSound("buttons/button5.wav")
				self.LocatorEnt:On()
				self.RadioTime = CurTime() + 5
			
				NO_WAVE_MUSIC = true

				if GetConVar("hl1_coop_sv_skill"):GetInt() == 4 then -- Very Hard
					GAMEMODE:PlayGlobalMusic("Mash.VeryHard_Apostasy")
				else
					if GetConVar("hl1_coop_sv_bhlcie_lilyhalloween_music"):GetInt() == 1 then
						local PanelMusic = math.random(1,3)
						if PanelMusic == 1 then
							GAMEMODE:PlayGlobalMusic("FAITH.Astaroth")
						elseif PanelMusic == 2 then
							GAMEMODE:PlayGlobalMusic("FAITH.Malphas")
						else
							GAMEMODE:PlayGlobalMusic("FAITH.Miriam")
						end
					else
						local PanelMusic = math.random(1,7)
						if PanelMusic == 1 then
							GAMEMODE:PlayGlobalMusic("Mash.Brain")
						elseif PanelMusic == 2 then
							GAMEMODE:PlayGlobalMusic("Mash.Destiny")
						elseif PanelMusic == 3 then
							GAMEMODE:PlayGlobalMusic("Mash.Orchestra")
						elseif PanelMusic == 4 then
							GAMEMODE:PlayGlobalMusic("Mash.Fragments")
						elseif PanelMusic == 5 then
							GAMEMODE:PlayGlobalMusic("Mash.Snakcombat")
						elseif PanelMusic == 6 then
							GAMEMODE:PlayGlobalMusic("Mash.Gertrude")
						else
							GAMEMODE:PlayGlobalMusic("Mash.Avatar")
						end
					end
				end

				self.glowSprite:SetKeyValue("rendercolor", "0 255 0")

				shepherd = ents.Create("npc_bhlcie_shepherd")
				if IsValid(shepherd) then
					shepherd:SetPos(Vector(2313.034180, 192.687256, 256.031250))
					shepherd:SetAngles(Angle(0,0,0))
					shepherd:Spawn()
				end

				/*
				if MAP.Zombieset == 4 then
					local gonarchboss = ents.Create("npc_vj_hlr1_gonarch")
					-- if IsValid(gonarchboss) then
						gonarchboss:SetPos(Vector(-6822, 2405, -213))
						gonarchboss:Spawn()
						gonarchboss:SetHealth(math.min(1000 * player.GetCount(), 5000))
						gonarchboss:EmitSound("vj_hlr/hl1_npc/gonarch/gon_alert"..math.random(1,3)..".wav",180,100)
						-- gonarchboss:SetCollisionBounds(Vector(-40, -40, 0), Vector(40, 40, 200))
					-- end		
				end
				*/

			end
		end	
	end

	-- for k, v in pairs(ents.FindByName("elevator_model")) do
		-- v:SetKeyValue("speed", "1000")
	-- end

	-- we need more fuel sources!
	-- write down where these all are!

	---- -= Topside =-
	--- Offices Outside
	-- Next to Shack
	CreateBarrel(Vector(2022.6009521484, 3410.8078613281, 32.375450134277), math.random(5,10))
	CreateBarrel(Vector(2060.0964355469, 3454.5017089844, 32.445976257324), math.random(5,10))
	CreateBarrel(Vector(2116.5778808594, 3475.7038574219, 32.396118164063), math.random(5,10))
	CreateBarrel(Vector(2177.4755859375, 3472.8896484375, 32.450878143311), math.random(5,10))
	-- Next to Electric Fence
	CreateBarrel(Vector(2926.2563476563, 3449.7534179688, 32.370956420898), math.random(15,20))
	CreateBarrel(Vector(2913.4692382813, 3389.7409667969, 32.412414550781), math.random(15,20))
	-- Next to Office Main Entrance
	CreateBarrel(Vector(3429.4206542969, 1850.4152832031, 32.441677093506), math.random(5,10))
	CreateBarrel(Vector(3399.7145996094, 1781.0930175781, 32.454418182373), math.random(5,10))
	-- Next to Office Side Entrance
	CreateBarrel(Vector(2021.970581, 1405.019775, 64.031250), math.random(15,20))
	CreateBarrel(Vector(2040.162109, 1339.376953, 64.031250), math.random(15,20))
	CreateBarrel(Vector(2098.413818, 1329.238403, 64.031250), math.random(15,20))
	-- Office Roof
	CreateBarrel(Vector(2686.117188, 1423.362915, 310.031250), math.random(5,10), Angle(27, 90, 90))
	-- Offices
	CreateBarrel(Vector(2144.8166503906, 1012.2333984375, 112.48658752441), math.random(30,35))
	-- Furnace Room
	CreateBarrel(Vector(2403.6555175781, 1800.8238525391, -339.51629638672), math.random(5,10))
	CreateBarrel(Vector(2464.9909667969, 1799.0443115234, -339.50076293945), math.random(5,10))
	CreateBarrel(Vector(2524.1938476563, 1795.2333984375, -339.56326293945), math.random(5,10))
	-- Mine
	CreateBarrel(Vector(1809.9936523438, 2345.2097167969, -335.63763427734), math.random(5,10))
	CreateBarrel(Vector(1942.3728027344, 2159.0739746094, -335.59921264648), math.random(5,10))
	CreateBarrel(Vector(1814.1279296875, 2017.2261962891, -335.56460571289), math.random(5,10))
	-- Abandoned Offices Outside
	CreateBarrel(Vector(3122.3212890625, 5334.5854492188, 32.355308532715), math.random(5,10))
	CreateBarrel(Vector(3174.3435058594, 5376.6494140625, 32.341556549072), math.random(5,10))
	CreateBarrel(Vector(3115.5493164063, 5399.2016601563, 32.343982696533), math.random(5,10))
	CreateBarrel(Vector(3121.1584472656, 5515.2138671875, 32.364730834961), math.random(5,10))
	CreateBarrel(Vector(3193.345703125, 5486.603515625, -11), math.random(5,10), Angle(27, 0, 90))
	-- Abandoned Offices - First Floor
	CreateBarrel(Vector(1864.2143554688, 4529.408203125, 64.28125), math.random(30,35))
	CreateBarrel(Vector(1859.8726806641, 4601.4223632813, 64.281257629395), math.random(30,35))
	CreateBarrel(Vector(2383.6896972656, 4819.2719726563, 64.281257629395), math.random(30,35))
	CreateBarrel(Vector(2391.4567871094, 4880.2387695313, 64.43563079834), math.random(30,35))
	CreateBarrel(Vector(2392.9252929688, 4941.9609375, 64.28125), math.random(30,35))
	CreateBarrel(Vector(1870.4594726563, 4893.3681640625, 64.28125), math.random(30,35))
	CreateBarrel(Vector(1862.8728027344, 4816.7646484375, 64.28125), math.random(30,35))
	-- Abandoned Offices - Second Floor
	CreateBarrel(Vector(2167.3193359375, 4760.3872070313, 272.44964599609), math.random(30,35))
	CreateBarrel(Vector(2111.5886230469, 4766.5634765625, 272.40405273438), math.random(30,35))
	CreateBarrel(Vector(2133.1733398438, 5071.6752929688, 272.28125), math.random(30,35))
	CreateBarrel(Vector(2089.0046386719, 5120.2397460938, 272.28125), math.random(30,35))
	CreateBarrel(Vector(2047.9669189453, 5163.0151367188, 272.28125), math.random(30,35))
	CreateBarrel(Vector(2012.9548339844, 5211.6323242188, 272.28125), math.random(30,35))
	CreateBarrel(Vector(2206.9528808594, 5256.3481445313, 272.28125), math.random(30,35))
	CreateBarrel(Vector(2282.619140625, 5243.0698242188, 272.28125), math.random(30,35))
	-- Abandoned Offices - Second Floor, Rooms with Big Boarded Windows
	CreateBarrel(Vector(2930.090088, 4614.696289, 229.031250), math.random(20,25), Angle(27, 0, 90))
	CreateBarrel(Vector(2889.7170410156, 4523.5776367188, 272.42233276367), math.random(20,25))
	CreateBarrel(Vector(2836.8034667969, 4522.0390625, 272.43612670898), math.random(20,25))
	CreateBarrel(Vector(2783.2741699219, 4525.2783203125, 272.4700012207), math.random(20,25))
	CreateBarrel(Vector(2920.6806640625, 4129.3833007813, 272.49700927734), math.random(20,25))
	CreateBarrel(Vector(2918.1247558594, 4291.7529296875, 272.49978637695), math.random(20,25))
	CreateBarrel(Vector(2872.6728515625, 4326.9155273438, 272.49978637695), math.random(20,25))
	-- Church Area Outside
	CreateBarrel(Vector(6722.645508, 223.765244, 220.031250), math.random(5,10))
	CreateBarrel(Vector(6625.1801757813, 1395.3504638672, 224.4630279541), math.random(5,10))
	CreateBarrel(Vector(6672.73828125, 1362.9908447266, 224.37812805176), math.random(5,10))
	CreateBarrel(Vector(6696.8120117188, 1306.4624023438, 224.39973449707), math.random(5,10))
	CreateBarrel(Vector(3410.4814453125, 678.54278564453, 224.42781066895), math.random(30,35))
	CreateBarrel(Vector(3408.6264648438, 735.86614990234, 224.49980163574), math.random(30,35))
	CreateBarrel(Vector(3149.2473144531, 734.75311279297, 224.47836303711), math.random(30,35))
	CreateBarrel(Vector(3150.8171386719, 677.20220947266, 224.48756408691), math.random(30,35))
	-- forgot to add these ones oops
	CreateBarrel(Vector(5697.358398, 677.705627, 256.031250), math.random(5,10))
	CreateBarrel(Vector(3144.861328, 378.626617, 256.031250), math.random(5,10))
	CreateBarrel(Vector(3145.501465, 5.214431, 256.031250), math.random(5,10))
	-- Church
	CreateBarrel(Vector(2096.7182617188, -78.070442199707, 248.4387512207), math.random(10,15))
	CreateBarrel(Vector(2060.1118164063, -24.837366104126, 248.37886047363), math.random(10,15))
	CreateBarrel(Vector(2064.9641113281, 403.09384155273, 248.40707397461), math.random(10,15))
	CreateBarrel(Vector(2065.9331054688, 455.02911376953, 248.4852142334), math.random(10,15))
	CreateBarrel(Vector(3043.478515625, 449.7805480957, 224.46621704102), math.random(10,15))
	CreateBarrel(Vector(3045.2077636719, -67.73551940918, 224.43380737305), math.random(10,15))
	-- Tunnel to HERESY
	CreateBarrel(Vector(7033.7690429688, -2033.9742431641, 352.42657470703), math.random(5,10))
	CreateBarrel(Vector(7102.919921875, -2042.5626220703, 352.47546386719), math.random(5,10))
	-- -= HERESY =-
	-- Cells between Lava Cave and Main Area
	CreateBarrel(Vector(3757.8640136719, 9243.8876953125, -7391.6538085938), math.random(20,25))
	CreateBarrel(Vector(3756.7922363281, 9185.9306640625, -7391.6000976563), math.random(20,25))
	CreateBarrel(Vector(3302.8752441406, 9642.8837890625, -7391.6459960938), math.random(20,25))
	CreateBarrel(Vector(3354.0974121094, 9645.1708984375, -7391.5776367188), math.random(20,25))
	CreateBarrel(Vector(2698.0551757813, 9315.3408203125, -7327.71875), math.random(20,25))
	-- CreateBarrel(Vector(2698.0551757813, 9295.3408203125, -7327.71875), math.random(20,25))
	CreateBarrel(Vector(2751.0949707031, 9297.2109375, -7327.71875), math.random(20,25))
	CreateBarrel(Vector(2515.9453125, 9477.3740234375, -7327.71875), math.random(20,25))
	CreateBarrel(Vector(2519.2219238281, 9532.564453125, -7327.71875), math.random(20,25))
	CreateBarrel(Vector(2443.3801269531, 9892.0751953125, -7263.71875), math.random(20,25))
	CreateBarrel(Vector(2440.2963867188, 9947.3388671875, -7263.71875), math.random(20,25))
	CreateBarrel(Vector(2683.2255859375, 10737.953125, -7039.71875), math.random(20,25))
	CreateBarrel(Vector(2625.3981933594, 10743.091796875, -7039.71875), math.random(20,25))
	CreateBarrel(Vector(1794.0731201172, 10995.50390625, -6911.71875), math.random(20,25))
	CreateBarrel(Vector(1851.0379638672, 10996.262695313, -6911.71875), math.random(20,25))
	CreateBarrel(Vector(1798.1772460938, 10325.333984375, -6911.71875), math.random(20,25))
	CreateBarrel(Vector(1850.9223632813, 10329.447265625, -6911.71875), math.random(20,25))
	-- Main Area
	CreateBarrel(Vector(2776.9291992188, 10710.875976563, -6783.59375), math.random(20,25))
	CreateBarrel(Vector(2721.5744628906, 10712.282226563, -6783.546875), math.random(20,25))
	CreateBarrel(Vector(2665.69921875, 10717.690429688, -6783.5473632813), math.random(20,25))
	CreateBarrel(Vector(2614.8669433594, 10719.263671875, -6783.5668945313), math.random(20,25))
	CreateBarrel(Vector(2719.2919921875, 9342.46484375, -6783.5375976563), math.random(20,25))
	CreateBarrel(Vector(4196.9438476563, 9339.9072265625, -6783.5341796875), math.random(20,25))
	CreateBarrel(Vector(4198.3212890625, 9389.11328125, -6783.5004882813), math.random(20,25))
	CreateBarrel(Vector(4197.0522460938, 9438.826171875, -6783.552734375), math.random(20,25))
	CreateBarrel(Vector(3868.6987304688, 10529.676757813, -6783.6357421875), math.random(20,25))
	CreateBarrel(Vector(2914.3352050781, 10529.889648438, -6783.5854492188), math.random(20,25))
	CreateBarrel(Vector(2912.4592285156, 9953.5654296875, -6783.6513671875), math.random(20,25))
	CreateBarrel(Vector(3872.2463378906, 9953.365234375, -6783.6484375), math.random(20,25))
	-- Bone Pile
	CreateBarrel(Vector(4957.94921875, 9367.876953125, -6783.6391601563), math.random(20,25))
	CreateBarrel(Vector(4904.2319335938, 9365.6572265625, -6783.6206054688), math.random(20,25))
	--
	CreateBarrel(Vector(4911.1865234375, 10724.53125, -6783.5112304688), math.random(20,25))
	CreateBarrel(Vector(4960.1791992188, 10721.536132813, -6783.5625), math.random(20,25))
	CreateBarrel(Vector(4967.0610351563, 10672.543945313, -6783.609375), math.random(20,25))
	CreateBarrel(Vector(4032.1892089844, 10720.916015625, -6783.7358398438), math.random(20,25))
	-- Exit Portal Room
	CreateBarrel(Vector(4603.001465, 10121.070313, -6787.968750), math.random(10,15))
	CreateBarrel(Vector(4365.931152, 10118.141602, -6787.968750), math.random(10,15))
	CreateBarrel(Vector(4362.618164, 10348.539063, -6787.968750), math.random(10,15))
	CreateBarrel(Vector(4586.942383, 10348.427734, -6787.968750), math.random(10,15))

	GAMEMODE:CreateStaticDecoration("models/lilyhl1/logoless_suv.mdl", Vector(3697.3674316406, 4655.6616210938, 0.3916609287262), Angle(-0.020528916269541, 90.80590057373, 0.015813767910004))
	CreateFuelTrigger(Vector(3754.754150, 4581.943359, 64.031250), Vector(3754.134521, 4620.388672, 28.031162), math.random(10,15))
	

	GAMEMODE:CreateStaticDecoration("models/props/hlvehicles/forklift.mdl", Vector(3308.2497558594, 5236.3481445313, 64.504913330078), Angle(-2.974090662633e-08, -134.50144958496, -0.073974609375))
	GAMEMODE:CreateStaticDecoration("models/props/hlvehicles/deliver.mdl", Vector(3144.4143066406, 5701.8364257813, 67.475807189941), Angle(0.044408202171326, 91.149673461914, 0.069362938404083))

	GAMEMODE:CreatePhysicsDecoration("models/lilyhl1/red_monitor_broken.mdl", Vector(2164.8779296875, 4317.6787109375, 248.53015136719), Angle(89.728858947754, -161.35890197754, 126.46437835693))
	GAMEMODE:CreateStaticDecoration("models/halflife/props/file_cabinet.mdl", Vector(2055.9946289063, 4305.9907226563, 254.21342468262), Angle(89.953186035156, -144.45150756836, 180))
	GAMEMODE:CreateStaticDecoration("models/halflife/props/file_cabinet.mdl", Vector(2105.1181640625, 4275.5024414063, 241.84509277344), Angle(0.88793325424194, 72.40202331543, 5.8262028694153))
	GAMEMODE:CreateStaticDecoration("models/halflife/props/file_cabinet.mdl", Vector(2053.8286132813, 4275.4975585938, 251.21801757813), Angle(24.781921386719, 65.795516967773, 27.24979019165))
	GAMEMODE:CreateStaticDecoration("models/props/fifties/recorder_three.mdl", Vector(2025.6719970703, 4340.1411132813, 297.12020874023), Angle(0.0083532575517893, -32.968242645264, 0.20933423936367))
	GAMEMODE:CreateStaticDecoration("models/props/fifties/recorder_two.mdl", Vector(2066.3725585938, 4442.4697265625, 285.79934692383), Angle(-56.885524749756, 115.79551696777, -0.68936157226563))
	GAMEMODE:CreateStaticDecoration("models/props/fifties/wooden_desk.mdl", Vector(2156.5004882813, 4448.2504882813, 264.55917358398), Angle(-0.040043789893389, 47.930160522461, 82.996932983398))
	GAMEMODE:CreatePhysicsDecoration("models/lilyhl1/keyboard.mdl", Vector(2196.4291992188, 4406.3139648438, 240.48724365234), Angle(-0.22881089150906, -12.316379547119, 0.15932463109493))
	GAMEMODE:CreatePhysicsDecoration("models/props/portedprops3/chair.mdl", Vector(2130.8303222656, 4460.2978515625, 303.50866699219), Angle(-56.587547302246, 159.27694702148, -13.340759277344))

	GAMEMODE:CreateStaticDecoration("models/props/fifties/wooden_desk.mdl", Vector(2180.986328125, 4606.4956054688, 258.72717285156), Angle(0.00039757986087352, -89.615005493164, -0.59548950195313))
	GAMEMODE:CreatePhysicsDecoration("models/lilyhl1/red_monitor_broken.mdl", Vector(2192.6962890625, 4626.1665039063, 277.10504150391), Angle(0.55135136842728, -21.852416992188, -0.2249755859375))
	GAMEMODE:CreatePhysicsDecoration("models/props/portedprops3/chair.mdl", Vector(2052.445801, 4577.699707, 304.031250), Angle(-0.59812092781067, 179.75880432129, -0.014556884765625))
	GAMEMODE:CreatePhysicsDecoration("models/lilyhl1/keyboard.mdl", Vector(2175.5415039063, 4598.8901367188, 277.27679443359), Angle(-0.59812092781067, 179.75880432129, -0.014556884765625))
	GAMEMODE:CreateStaticDecoration("models/props/fifties/recorder_two.mdl", Vector(2002.4816894531, 4757.0854492188, 296.99899291992), Angle(-0.066295184195042, -0.44192126393318, -0.025115966796875))
	GAMEMODE:CreateStaticDecoration("models/props/fifties/recorder_three.mdl", Vector(2001.6811523438, 4672.5336914063, 296.99722290039), Angle(6.5936895055074e-08, -0.24753268063068, -0.003509521484375))
	GAMEMODE:CreateStaticDecoration("models/halflife/props/file_cabinet.mdl", Vector(1999.3780517578, 4618.921875, 240.26832580566), Angle(0.017968369647861, 0.42592141032219, 0.074319191277027))
	GAMEMODE:CreateStaticDecoration("models/halflife/props/file_cabinet.mdl", Vector(1999.6915283203, 4595.6928710938, 240.36973571777), Angle(0.0078342435881495, 0.086856499314308, 0.10128080099821))
	GAMEMODE:CreateStaticDecoration("models/halflife/props/file_cabinet.mdl", Vector(1999.4708251953, 4572.5703125, 240.36663818359), Angle(-0.0064866654574871, 0.010083113797009, 0.10618117451668))
	GAMEMODE:CreateStaticDecoration("models/props_debris/wood_board05a.mdl", Vector(2202.5578613281, 4734.2138671875, 306.70922851563), Angle(4.3229622840881, -179.56324768066, -58.114807128906))
	GAMEMODE:CreateStaticDecoration("models/props_debris/wood_board05a.mdl", Vector(2204.7521972656, 4733.6196289063, 310.61672973633), Angle(5.5183463096619, -179.25494384766, 88.566383361816))
	GAMEMODE:CreateStaticDecoration("models/props_debris/wood_board05a.mdl", Vector(2206.5270996094, 4731.8505859375, 291.28646850586), Angle(0.077574923634529, -179.98695373535, -91.080108642578))
	GAMEMODE:CreateStaticDecoration("models/props_debris/wood_board05a.mdl", Vector(2206.6359863281, 4726.9111328125, 324.14346313477), Angle(0.019482353702188, 179.96125793457, -82.270904541016))
	GAMEMODE:CreateStaticDecoration("models/props/hl4props/metalbox01.mdl", Vector(2136.9187011719, 4595.4912109375, 256.49975585938), Angle(-8.2420010585338e-05, 176.73442077637, 0))
	GAMEMODE:CreateStaticDecoration("models/props/hl4props/metalbox01.mdl", Vector(2142.5993652344, 4665.23046875, 256.49609375), Angle(0.0053251790814102, 151.55767822266, -0.0052490234375))
	GAMEMODE:CreateStaticDecoration("models/props/hl4props/metalbox01.mdl", Vector(2142.86328125, 4634.0517578125, 291.86624145508), Angle(0.26941093802452, -91.508735656738, 8.4756555557251))

	GAMEMODE:CreateStaticDecoration("models/props/fifties/wooden_desk.mdl", Vector(2823.9458007813, 4124.6147460938, 258.45953369141), Angle(-0, 177.3857421875, 0))
	GAMEMODE:CreateStaticDecoration("models/props/fifties/wooden_desk.mdl", Vector(2864.5593261719, 4704.43359375, 258.49224853516), Angle(-0.010269370861351, 0.1538901925087, 0))
	GAMEMODE:CreateStaticDecoration("models/halflife/props/file_cabinet.mdl", Vector(2928.3327636719, 4718.9985351563, 240.36834716797), Angle(0.083672031760216, -92.626525878906, -0.002197265625))
	GAMEMODE:CreateStaticDecoration("models/halflife/props/file_cabinet.mdl", Vector(2955.6843261719, 4718.947265625, 240.31823730469), Angle(0.0025823831092566, -94.666725158691, 0.40607488155365))

	if math.random(1,3) == 1 then
		GAMEMODE:CreateStaticDecoration("models/lilyhl1/logoless_suv.mdl", Vector(4755.025390625, -44.715423583984, 184.4024810791), Angle(-0.039527211338282, -91.37198638916, 0.028667839244008))
		CreateFuelTrigger(Vector(4700.383789, 31.009872, 248.031250), Vector(4699.791016, 6.263349, 212.031250), math.random(10,15))
	end
	if math.random(1,3) == 1 then
		GAMEMODE:CreateStaticDecoration("models/lilyhl1/logoless_suv.mdl", Vector(4912.9389648438, -43.961795806885, 184.44290161133), Angle(0.013499295338988, -90.24439239502, 0.018198953941464))
		CreateFuelTrigger(Vector(4857.146484, 32.239902, 248.031250), Vector(4857.024902, 3.275601, 212.031250), math.random(10,15))
	end
	if math.random(1,3) == 1 then
		GAMEMODE:CreateStaticDecoration("models/lilyhl1/logoless_suv.mdl", Vector(5074.8950195313, -38.786037445068, 184.37425231934), Angle(0.0031802165322006, -91.002235412598, 0.0035482731182128))
		CreateFuelTrigger(Vector(5019.893555, 36.592064, 248.031082), Vector(5019.456055, 11.537156, 212.029678), math.random(10,15))
	end
	if math.random(1,3) == 1 then
		GAMEMODE:CreateStaticDecoration("models/lilyhl1/logoless_suv.mdl", Vector(5234.9951171875, -39.986957550049, 184.46000671387), Angle(-0.022424448281527, -90.848121643066, 0.016657603904605))
		CreateFuelTrigger(Vector(5179.805664, 33.885651, 248.031158), Vector(5179.455566, 10.655038, 212.031158), math.random(10,15))
	end
	if math.random(1,3) == 1 then
		GAMEMODE:CreateStaticDecoration("models/lilyhl1/logoless_suv.mdl", Vector(5393.2973632813, -42.075672149658, 184.46084594727), Angle(0.019475378096104, -89.886245727539, 0.026578404009342))
		CreateFuelTrigger(Vector(5337.056152, 34.681168, 248.031250), Vector(5337.112793, 6.091341, 212.031250), math.random(10,15))
	end
	if math.random(1,3) == 1 then
		GAMEMODE:CreateStaticDecoration("models/lilyhl1/logoless_suv.mdl", Vector(5553.2900390625, -40.135570526123, 184.39097595215), Angle(-0.024858331307769, -90.775505065918, 0.0064839557744563))
		CreateFuelTrigger(Vector(5498.063965, 36.085583, 248.031082), Vector(5497.707031, 9.554736, 212.029846), math.random(10,15))
	end
	if math.random(1,3) == 1 then
		GAMEMODE:CreateStaticDecoration("models/lilyhl1/logoless_suv.mdl", Vector(5550.1821289063, 429.52786254883, 184.37405395508), Angle(-0.0070228762924671, 90.001579284668, 0.011530768126249))
		CreateFuelTrigger(Vector(5606.225098, 352.110352, 248.031250), Vector(5606.222656, 383.317780, 212.031250), math.random(10,15))
	end
	if math.random(1,3) == 1 then
		GAMEMODE:CreateStaticDecoration("models/lilyhl1/logoless_suv.mdl", Vector(5388.3071289063, 423.77435302734, 184.49978637695), Angle(1.6293050464355e-08, 89.023101806641, 0))
		CreateFuelTrigger(Vector(5443.292969, 346.131287, 248.031174), Vector(5443.804199, 376.143799, 212.030869), math.random(10,15))
	end
	if math.random(1,3) == 1 then
		GAMEMODE:CreateStaticDecoration("models/lilyhl1/logoless_suv.mdl", Vector(5233.4399414063, 425.52731323242, 184.35597229004), Angle(0.0036436058580875, 89.280754089355, 0.0040655792690814))
		CreateFuelTrigger(Vector(5288.694824, 347.159882, 248.029770), Vector(5289.062988, 376.584198, 212.028809), math.random(10,15))
	end
	if math.random(1,3) == 1 then
		GAMEMODE:CreateStaticDecoration("models/lilyhl1/logoless_suv.mdl", Vector(5067.2006835938, 428.31567382813, 184.43264770508), Angle(0.064112670719624, 89.897636413574, 0))
		CreateFuelTrigger(Vector(5123.123047, 351.001648, 248.028809), Vector(5123.175293, 380.863953, 212.027802), math.random(10,15))
	end
	if math.random(1,3) == 1 then
		GAMEMODE:CreateStaticDecoration("models/lilyhl1/logoless_suv.mdl", Vector(4918.5908203125, 423.10791015625, 184.39022827148), Angle(0.0027757685165852, 89.435302734375, 0.0030967427883297))
		CreateFuelTrigger(Vector(4974.007813, 344.379028, 248.025909), Vector(4974.325195, 376.620911, 212.023026), math.random(10,15))
	end
	if math.random(1,3) == 1 then
		GAMEMODE:CreateStaticDecoration("models/lilyhl1/logoless_suv.mdl", Vector(4751.525390625, 425.39068603516, 184.33992004395), Angle(0.004050187766552, 88.663146972656, 0.0045195329003036))
		CreateFuelTrigger(Vector(4806.120605, 347.275269, 248.021500), Vector(4806.797363, 376.294373, 212.020706), math.random(10,15))
	end

	---- Batch 2
	-- Outside Offices - Army Trucks
	GAMEMODE:CreateStaticDecoration("models/props/hl7props/hecutruck00.mdl", Vector(2613.154296875, 3238.7863769531, 59.99983215332), Angle(-0.008134875446558, 171.05857849121, 0.0048006405122578))
	GAMEMODE:CreateStaticDecoration("models/props/hl7props/hecutruck.mdl", Vector(2596.55859375, 2205.4104003906, 73.861328125), Angle(-0.019985068589449, 65.774635314941, -0.001220703125))

	GAMEMODE:CreatePhysicsDecoration("models/props/halflifeoneprops1/smallcrate.mdl", Vector(2596.9157714844, 2205.3271484375, 63.756481170654), Angle(0.016523564234376, 155.85440063477, 0.010500091128051))
	GAMEMODE:CreatePhysicsDecoration("models/props/halflifeoneprops1/smallcrate.mdl", Vector(2610.3999023438, 2234.7631835938, 63.741703033447), Angle(-0.027438877150416, 155.73526000977, -0.03155517578125))
	GAMEMODE:CreatePhysicsDecoration("models/props/halflifeoneprops1/smallcrate.mdl", Vector(2581.642578125, 2249.6203613281, 63.769832611084), Angle(0.0070870500057936, 155.80078125, 0.12792173027992))
	GAMEMODE:CreatePhysicsDecoration("models/props/halflifeoneprops1/smallcrate.mdl", Vector(2454.3107910156, 2322.4936523438, 12.369481086731), Angle(0.014049286954105, 160.95248413086, 0.014049273915589))

	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/can.mdl", Vector(2465.2568359375, 2330.2387695313, 26.971313476563), Angle(-85.935394287109, 111.48226928711, 0.12268148362637))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/can.mdl", Vector(2453.3647460938, 2328.2868652344, 25.292848587036), Angle(3.8006725311279, 131.56465148926, -14.558532714844))

	-- Outside Offices - Supply Cache
	GAMEMODE:CreateStaticDecoration("models/props/hlprops/metalcrate00.mdl", Vector(1958.9738769531, 2877.0307617188, 24.338500976563), Angle(0.023968733847141, -94.364967346191, -0.003662109375))
	GAMEMODE:CreateStaticDecoration("models/props/hlprops/metalcrate00.mdl", Vector(1960.4141845703, 2959.8562011719, 24.37197303772), Angle(0.015618034638464, 91.474937438965, 0.07532773911953))
	GAMEMODE:CreateStaticDecoration("models/props/halflifeoneprops1/crate00.mdl", Vector(1957.1368408203, 3034.3432617188, 24.362049102783), Angle(0.013005224056542, -3.2033190727234, -0.012359619140625))
	GAMEMODE:CreateStaticDecoration("models/props/halflifeoneprops1/bigradio.mdl", Vector(1953.7215576172, 3120.5466308594, 47.433792114258), Angle(0.0012211804278195, -105.08248138428, 0.034973815083504))
	GAMEMODE:CreateStaticDecoration("models/props/fifties/wep_ammo.mdl", Vector(2074.2824707031, 2835.3664550781, 16.331192016602), Angle(0.0014265849022195, 0.59338343143463, 0.038611277937889))
	GAMEMODE:CreateStaticDecoration("models/props/fifties/wep_crate.mdl", Vector(2074.2717285156, 2883.9006347656, 16.889963150024), Angle(0.056614138185978, 0.59344685077667, 0.0039688502438366))
	GAMEMODE:CreateStaticDecoration("models/props/fifties/wep_crate.mdl", Vector(2073.5646972656, 2967.4270019531, 16.912029266357), Angle(-0.079102106392384, 179.53837585449, -0.016845703125))
	GAMEMODE:CreateStaticDecoration("models/props/hl18props/metalbox01.mdl", Vector(2185.5092773438, 2888.4353027344, 18.415477752686), Angle(-0.031936388462782, 179.99299621582, 0.011180409230292))
	GAMEMODE:CreateStaticDecoration("models/props/hl18props/metalbox01.mdl", Vector(2185.310546875, 2968.8806152344, 18.497800827026), Angle(0.0019151151645929, 179.99324035645, -0.00091552734375))
	GAMEMODE:CreatePhysicsDecoration("models/props/halflifeoneprops1/smallcrate.mdl", Vector(2175.7419433594, 3030.4978027344, 12.336194038391), Angle(-0.023582637310028, -161.88092041016, -0.009490966796875))
	GAMEMODE:CreatePhysicsDecoration("models/props/halflifeoneprops1/smallcrate.mdl", Vector(2156.8098144531, 3063.4462890625, 12.35546875), Angle(-0.010588018223643, -142.08497619629, -0.043701171875))
	GAMEMODE:CreatePhysicsDecoration("models/props/hl19props/metalboxpart00.mdl", Vector(2227.9504394531, 2885.6335449219, 28.646638870239), Angle(-32.209201812744, -0.026342948898673, 179.99934387207))
	GAMEMODE:CreatePhysicsDecoration("models/props/hl19props/metalboxpart00.mdl", Vector(2225.9304199219, 2970.2978515625, 29.054071426392), Angle(-24.55464553833, -0.83946639299393, 179.99917602539))

	GAMEMODE:CreateStaticDecoration("models/props/hl18props/metalbox01.mdl", Vector(2260.4912109375, 1944.3845214844, 18.50022315979), Angle(0.10565933585167, 89.954727172852, 0.060324497520924))
	GAMEMODE:CreateStaticDecoration("models/props/fifties/wep_crate.mdl", Vector(2174.3264160156, 1939.7222900391, 16.900188446045), Angle(-0.054504223167896, 89.953765869141, -0.0103759765625))
	GAMEMODE:CreatePhysicsDecoration("models/props/hl19props/metalboxpart00.mdl", Vector(2335.5905761719, 1946.8581542969, 29.737333297729), Angle(-60.382808685303, 0.15712311863899, 90.009071350098))
	GAMEMODE:CreateStaticDecoration("models/props/hl5props/hecuradio.mdl", Vector(2165.7802734375, 1932.3218994141, 80.795112609863), Angle(0.26970991492271, -89.956161499023, -0.10922241210938))
	GAMEMODE:CreateStaticDecoration("models/props/hlprops/metalcrate00.mdl", Vector(2181.3010253906, 2347.21875, 24.384925842285), Angle(-0.0089357383549213, 89.316764831543, 0.01354706287384))

	-- Outside Offices - Party Aftermath
	GAMEMODE:CreatePhysicsDecoration("models/props/halflifeoneprops5/table.mdl", Vector(3189.0056152344, 2779.5505371094, 18.327783584595), Angle(0.045722838491201, -86.555534362793, 0.032914415001869))
	GAMEMODE:CreatePhysicsDecoration("models/props/halflifeoneprops5/table.mdl", Vector(3293.8933105469, 2782.0656738281, 18.341032028198), Angle(-0.0092055518180132, -97.476432800293, 0.001110450248234))

	GAMEMODE:CreatePhysicsDecoration("models/props/halflifeoneprops1/smallcrate.mdl", Vector(3114.6838378906, 2766.568359375, 12.297403335571), Angle(0.11552593111992, -78.390907287598, -0.006195068359375))
	GAMEMODE:CreatePhysicsDecoration("models/props/halflifeoneprops1/smallcrate.mdl", Vector(3060.7785644531, 2470.7268066406, 12.342581748962), Angle(0.10797339677811, 37.944320678711, 0.0063985246233642))
	GAMEMODE:CreatePhysicsDecoration("models/props/halflifeoneprops1/smallcrate.mdl", Vector(3087.48828125, 2445.3193359375, 12.38781452179), Angle(0.043280396610498, 55.467910766602, -0.42379760742188))

	GAMEMODE:CreatePhysicsDecoration("models/props/portedprops1/coollaptop.mdl", Vector(3092.8264160156, 2450.7353515625, 33.862003326416), Angle(0.1308087259531, -117.774559021, 0.44366499781609))

	GAMEMODE:CreatePhysicsDecoration("models/decay/props/pizza.mdl", Vector(3166.8225097656, 2777.3503417969, 36.643230438232), Angle(0.031268958002329, -84.825103759766, -0.089599609375))
	GAMEMODE:CreatePhysicsDecoration("models/decay/props/pizza.mdl", Vector(3291.2280273438, 2785.4125976563, 36.764068603516), Angle(-0.12457264959812, -105.27590942383, -0.12124633789063))

	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/styrocup.mdl", Vector(3254.5654296875, 2767.380859375, 38.968017578125), Angle(-88.702293395996, -83.193939208984, 82.487937927246))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/styrocup.mdl", Vector(3218.7404785156, 2767.2885742188, 38.90843963623), Angle(-85.954902648926, 10.827359199524, -0.076263427734375))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/styrocup.mdl", Vector(3208.2470703125, 2775.9970703125, 38.949211120605), Angle(-88.642715454102, -12.683856964111, 52.733573913574))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/styrocup.mdl", Vector(3205.4860839844, 2762.6916503906, 38.896492004395), Angle(-85.919212341309, 26.678750991821, -0.29861450195313))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/styrocup.mdl", Vector(3211.1257324219, 2757.326171875, 40.742317199707), Angle(-6.5322561264038, -114.88809967041, 161.63403320313))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/styrocup.mdl", Vector(3191.5419921875, 2737.8979492188, -0.0042708227410913), Angle(0.88760638237, 30.6676902771, 16.097774505615))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/styrocup.mdl", Vector(3327.63671875, 2740.5708007813, 3.769082069397), Angle(-5.0445160865784, 83.182838439941, -123.6286315918))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/styrocup.mdl", Vector(3335.3986816406, 2734.1188964844, 4.449604511261), Angle(-7.5196294784546, 129.98588562012, 162.59312438965))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/styrocup.mdl", Vector(3247.0168457031, 2122.7180175781, 4.3655524253845), Angle(-7.4098644256592, -142.89128112793, 159.44422912598))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/styrocup.mdl", Vector(3143.1491699219, 2071.232421875, 3.7778651714325), Angle(-5.4005880355835, 158.13093566895, -124.2373046875))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/styrocup.mdl", Vector(3156.6286621094, 2032.0352783203, -0.062517046928406), Angle(0.15197192132473, -87.366508483887, 16.773603439331))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/styrocup.mdl", Vector(3218.3564453125, 1952.7224121094, -0.0063862008973956), Angle(1.297327041626, -153.19850158691, 19.379125595093))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/styrocup.mdl", Vector(3020.4350585938, 1973.3204345703, 2.1097497940063), Angle(-4.0642790794373, -167.59158325195, 91.679077148438))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/styrocup.mdl", Vector(3108.0329589844, 1894.5236816406, 1.9761654138565), Angle(-3.0826399326324, 35.101417541504, 87.345245361328))

	GAMEMODE:CreatePhysicsDecoration("models/cs16/props/lv_bottle.mdl", Vector(3315.3464355469, 2762.0129394531, 36.61930847168), Angle(0.53978860378265, 5.8895463943481, -1.8198547363281))
	GAMEMODE:CreatePhysicsDecoration("models/cs16/props/lv_bottle.mdl", Vector(3261.9072265625, 2792.0595703125, 36.699592590332), Angle(0.37362286448479, -82.286613464355, 0.17207938432693))
	GAMEMODE:CreatePhysicsDecoration("models/cs16/props/lv_bottle.mdl", Vector(3199.9782714844, 2769.0615234375, 36.509124755859), Angle(0.06520190089941, 7.9239497184753, -0.74774169921875))

	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/can.mdl", Vector(3029.841796875, 2843.4401855469, 1.006566286087), Angle(4.6378121376038, -84.587120056152, -15.140197753906))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/can.mdl", Vector(3073.8059082031, 2779.6931152344, 2.8687393665314), Angle(0.099043048918247, 125.68895721436, 88.570220947266))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/can.mdl", Vector(3105.7163085938, 2765.8039550781, 27.025993347168), Angle(-85.893348693848, 35.723194122314, -3.1267395019531))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/can.mdl", Vector(3111.6440429688, 2750.2346191406, 27.095073699951), Angle(-86.055595397949, -142.71214294434, 3.1800091266632))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/can.mdl", Vector(3093.7702636719, 2751.09375, 2.5554928779602), Angle(-86.288597106934, -52.084865570068, -1.9304809570313))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/can.mdl", Vector(3091.5212402344, 2758.8037109375, 1.1587606668472), Angle(3.1680617332458, -138.04013061523, 37.373798370361))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/can.mdl", Vector(3114.1623535156, 2718.6350097656, 4.3309726715088), Angle(-1.6890857219696, -20.774696350098, -113.86585998535))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/can.mdl", Vector(3229.2983398438, 2674.9560546875, 0.95624440908432), Angle(3.8720569610596, -177.77275085449, -13.72216796875))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/can.mdl", Vector(3122.2570800781, 2592.4907226563, 0.94345498085022), Angle(3.8833730220795, 59.442153930664, -13.871520996094))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/can.mdl", Vector(3335.1362304688, 2517.1162109375, 4.3044037818909), Angle(-1.3635032176971, 10.899479866028, -112.80099487305))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/can.mdl", Vector(3282.1130371094, 2500.375, 2.3459689617157), Angle(1.769819021225, 137.63507080078, -63.529022216797))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/can.mdl", Vector(3202.1169433594, 2531.4069824219, 1.2079037427902), Angle(2.931075334549, -144.78521728516, 42.31591796875))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/can.mdl", Vector(3064.5739746094, 2512.3178710938, 2.4172842502594), Angle(1.6410958766937, -48.824493408203, -65.605682373047))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/can.mdl", Vector(3076.2907714844, 2469.0021972656, 26.892232894897), Angle(-86.345848083496, -52.042987823486, 8.6560611724854))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/can.mdl", Vector(3224.5778808594, 2394.4807128906, 8.8421325683594), Angle(-3.0488350391388, -171.53434753418, 140.53596496582))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/can.mdl", Vector(3002.6127929688, 2348.7429199219, 2.8153569698334), Angle(0.14316520094872, 161.42434692383, 87.742279052734))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/can.mdl", Vector(3112.4135742188, 2316.6301269531, 5.5360264778137), Angle(-3.857488155365, 136.79637145996, -167.18530273438))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/can.mdl", Vector(3270.5202636719, 2279.4360351563, 0.94184672832489), Angle(3.8270070552826, -34.379535675049, -15.377288818359))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/can.mdl", Vector(3165.662109375, 2259.7570800781, 2.8150117397308), Angle(0.15506365895271, 175.11521911621, 87.744621276855))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/can.mdl", Vector(3041.7526855469, 2200.1691894531, 1.0555635690689), Angle(3.2681248188019, 70.666870117188, 35.133335113525))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/can.mdl", Vector(3299.3757324219, 2010.0885009766, 4.4447064399719), Angle(-1.8785569667816, 174.71650695801, -116.89659118652))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/can.mdl", Vector(3139.5283203125, 2027.1098632813, 0.93912643194199), Angle(3.8400599956512, 66.545867919922, -15.592712402344))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/can.mdl", Vector(2895.5861816406, 2029.2775878906, 4.8913917541504), Angle(-3.1561105251312, -119.30879211426, 142.33160400391))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/can.mdl", Vector(3153.8813476563, 1897.7536621094, 2.9017853736877), Angle(0.066023923456669, 30.239461898804, 89.079032897949))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/can.mdl", Vector(3350.9885253906, 1866.1553955078, 4.8788738250732), Angle(-3.1181070804596, -143.19436645508, 141.3381652832))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/can.mdl", Vector(3083.6159667969, 1824.2819824219, 3.0160081386566), Angle(-0.14813534915447, -91.830177307129, 92.797981262207))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/can.mdl", Vector(3264.1032714844, 1828.6418457031, 5.4586029052734), Angle(-3.849184513092, -3.4125421047211, -164.32676696777))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/can.mdl", Vector(3272.0419921875, 1741.2810058594, 4.4383506774902), Angle(-1.8442716598511, 65.909820556641, -116.36001586914))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/can.mdl", Vector(3077.2377929688, 1696.8759765625, 325.45959472656),Angle(-4.4086313247681, 50.98127746582, -166.98330688477))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/can.mdl", Vector(3055.4213867188, 1657.80859375, 325.48944091797), Angle(-3.9028465747833, -45.687728881836, -165.27558898926))

	-- Outside Offices - Dumpsters
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/styrocup.mdl", Vector(2190.935546875, 1466.9699707031, 7.0052919387817), Angle(-5.4545254707336, 12.727937698364, 106.37300872803))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/styrocup.mdl", Vector(2199.9116210938, 1428.8586425781, 6.0080275535583), Angle(-4.7633647918701, -115.65139770508, 89.662490844727))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/styrocup.mdl", Vector(2219.345703125, 1425.4891357422, 8.44846534729), Angle(-7.5374298095703, -105.79780578613, 161.49406433105))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/styrocup.mdl", Vector(2219.1057128906, 1414.8262939453, 3.9793953895569), Angle(0.27732917666435, -177.95114135742, 17.810497283936))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/styrocup.mdl", Vector(2222.7355957031, 1453.7729492188, 6.0691981315613), Angle(-4.0820164680481, 94.915184020996, 89.710945129395))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/sandwich.mdl", Vector(2220.2048339844, 1448.9830322266, 7.4874000549316), Angle(0.018739385530353, -36.160972595215, -179.83102416992))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/apple.mdl", Vector(2191.3605957031, 1446.4998779297, 4.5383810997009), Angle(0.68719363212585, -153.45227050781, -0.64801025390625))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/apple.mdl", Vector(2193.5161132813, 1421.5477294922, 4.4815826416016), Angle(1.6295275688171, 44.029937744141, -1.4492797851563))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/banana.mdl", Vector(2203.1975097656, 1461.4104003906, 4.4995055198669), Angle(-0.61499905586243, -128.74412536621, 0.7424989938736))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/can.mdl", Vector(2215.8510742188, 1459.2458496094, 5.2993588447571), Angle(3.611124753952, 44.457347869873, 41.117176055908))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/book/book6.mdl", Vector(2206.9680175781, 1422.6851806641, 7.3820219039917), Angle(-10.339299201965, -27.309635162354, 165.34756469727))

	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/can.mdl", Vector(2223.8298339844, 1327.6047363281, 6.9735941886902), Angle(-0.060349445790052, 172.80885314941, 90.688041687012))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/can.mdl", Vector(2208.4873046875, 1328.4561767578, 6.3114113807678), Angle(1.8444300889969, 72.067039489746, -62.924621582031))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/can.mdl", Vector(2209.9072265625, 1368.2479248047, 6.8215894699097), Angle(0.10182636231184, -101.48955535889, 88.068534851074))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/can.mdl", Vector(2199.3273925781, 1350.5295410156, 8.8962736129761), Angle(-3.1922883987427, -149.78959655762, 143.31768798828))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/styrocup.mdl", Vector(2191.5041503906, 1341.41796875, 3.9912941455841), Angle(0.095402128994465, -81.26537322998, 18.651678085327))

	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/styrocup.mdl", Vector(2195.6955566406, 1490.5999755859, 9.2245674133301), Angle(-5.2186880111694, -147.62481689453, 0.014700428582728))

	-- Offices
	GAMEMODE:CreatePhysicsDecoration("models/props/fifties/couch_chair_yel.mdl", Vector(2499.3083496094, 1576.181640625, 103.33305358887), Angle(0.036890339106321, 178.75637817383, -0.19461059570313))
	GAMEMODE:CreatePhysicsDecoration("models/props/portedprops4/tvforniture.mdl", Vector(2436.1940917969, 1565.3255615234, 93.359680175781), Angle(-0.017000382766128, 89.941032409668, 0.037110142409801))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/book/book1.mdl", Vector(2424.2897949219, 1567.8103027344, 85.200897216797), Angle(-0.022288458421826, -148.67324829102, -0.033905029296875))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/book/book2.mdl", Vector(2448.9250488281, 1570.6350097656, 85.186111450195), Angle(-0.0183518640697, -141.3864440918, -0.036468505859375))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/book/book3.mdl", Vector(2426.7124023438, 1568.9466552734, 98.258880615234), Angle(0.25065970420837, -35.687026977539, -179.77484130859))
	GAMEMODE:CreatePhysicsDecoration("models/props/hl20props/openbook00.mdl", Vector(2447.1052246094, 1566.8780517578, 107.85250854492), Angle(-0.005678285844624, 73.95777130127, 0.04011233150959))

	GAMEMODE:CreatePhysicsDecoration("models/props/halflifeoneprops1/smallcrate.mdl", Vector(2656.4741210938, 1460.8895263672, 92.464462280273), Angle(-0.031546004116535, 0.45171707868576, 0.094978213310242))
	GAMEMODE:CreatePhysicsDecoration("models/props/halflifeoneprops5/table.mdl", Vector(2666.8552246094, 1297.8524169922, 98.370635986328), Angle(-0.041814543306828, -0.43479597568512, -0.009002685546875))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/can.mdl", Vector(2680.291015625, 1451.9066162109, 82.443489074707), Angle(1.5294011831284, -110.44021606445, -67.37353515625))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/can.mdl", Vector(2694.8737792969, 1469.3669433594, 80.938591003418), Angle(4.924985408783, 116.95623016357, -10.850372314453))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/can.mdl", Vector(2669.7165527344, 1449.6920166016, 106.95487976074), Angle(-86.02759552002, -3.9539475440979, -3.5982666015625))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/styrocup.mdl", Vector(2670.0305175781, 1359.595703125, 84.443870544434), Angle(-7.4942922592163, 55.047828674316, 163.35754394531))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/styrocup.mdl", Vector(2667.234375, 1340.4614257813, 118.967918396), Angle(-87.685707092285, 43.979782104492, 15.727038383484))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/styrocup.mdl", Vector(2673.6782226563, 1335.2827148438, 118.97253417969), Angle(-85.919204711914, 137.92742919922, -0.29861450195313))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/styrocup.mdl", Vector(2683.234375, 1341.6895751953, 118.97832489014), Angle(-85.940887451172, 98.454383850098, -0.570068359375))
	GAMEMODE:CreatePhysicsDecoration("models/halflife/gibs/food/styrocup.mdl", Vector(2686.2678222656, 1328.5616455078, 118.98279571533), Angle(-85.950340270996, 85.82731628418, -0.6002197265625))
	GAMEMODE:CreatePhysicsDecoration("models/cs16/props/lv_bottle.mdl", Vector(2655.6921386719, 1330.6391601563, 116.7208404541), Angle(1.8740621805191, 14.866167068481, 0.1282182186842))
	GAMEMODE:CreatePhysicsDecoration("models/decay/props/pizza.mdl", Vector(2667.3659667969, 1275.4862060547, 116.69254302979), Angle(-0.0017615901306272, -91.853569030762, -0.0362548828125))

	-- Vehicle Tunnel
	-- GAMEMODE:CreateStaticDecoration("models/props/hlvehicles/cstruck.mdl", Vector(4170.5786132813, 2682.5615234375, 88.540237426758), Angle(0.0011222957400605, -50.980949401855, -0.11239624023438))
	-- GAMEMODE:CreateStaticDecoration("models/props/hlvehicles/hugetruck.mdl", Vector(4170.5786132813, 2682.5615234375, 88.540237426758), Angle(0.0011222957400605, -50.980949401855, -0.11239624023438))

	-- Outside Church
	-- GAMEMODE:CreateStaticDecoration("models/props/hlvehicles/hugetruck.mdl", Vector(4428.3754882813, 1549.7108154297, 95.83814239502), Angle(-0.0025892925914377, -155.5744934082, 0.001432359800674))
	-- GAMEMODE:CreateStaticDecoration("models/props/hlvehicles/hugetruck.mdl", Vector(6361.3852539063, 892.60461425781, 287.96627807617), Angle(0.014325338415802, -164.44711303711, -0.017486572265625))


	CreateDeadBody_Sci(Vector(3183.321289, 3000.839111, 0), Angle(0, -122, 0), 38)
	CreateDeadBody_Sci(Vector(2176.268066, 1140.985474, 80), Angle(0, -88, 0), 38)
	CreateDeadBody_Sci(Vector(2839.280273, 810.031250, 80), Angle(0, 90, 0), 38)

	GAMEMODE:CreateStaticDecoration("models/lilyhl1/logoless_suv.mdl", Vector(5133.87890625, 1111.8410644531, 34.682384490967), Angle(-9.4690437316895, -0.62079894542694, 0.10661364346743))
	CreateFuelTrigger(Vector(5075.686035, 1056.159790, 91.316147), Vector(5049.607422, 1056.442505, 50.966301), math.random(10,15))

	-- remove the suvs outside the offices so we can replace them with static ones
	for k, v in pairs(ents.FindInBox(Vector(2961.312744, 2370.314697, 64.031250), Vector(3425.408447, 1998.080933, 109.595276))) do
		if v:GetClass() == "prop_physics" && v:GetModel() == "models/lilyhl1/logoless_suv.mdl" then
			v:Remove()
		end		
	end

	GAMEMODE:CreateStaticDecoration("models/lilyhl1/logoless_suv.mdl", Vector(3391.955078125, 2128.2944335938, 0.47318530082703), Angle(-0.013503198511899, -0.01461121533066, 0.0022506259847432))
	CreateFuelTrigger(Vector(3315.882080, 2072.276367, 64.030945), Vector(3345.807129, 2072.268555, 28.030685), math.random(10,15))
	GAMEMODE:CreateStaticDecoration("models/lilyhl1/logoless_suv.mdl", Vector(3391.9533691406, 2288.2941894531, 0.48643484711647), Angle(-0.0063646794296801, -0.014380681328475, 0.0011050649918616))
	CreateFuelTrigger(Vector(3315.905518, 2232.276611, 64.031006), Vector(3343.641357, 2232.270508, 28.028236), math.random(10,15))
	GAMEMODE:CreateStaticDecoration("models/lilyhl1/logoless_suv.mdl", Vector(3008.0451660156, 2287.7048339844, 0.47616872191429), Angle(-0.011922191828489, 179.98533630371, 0.0019271802157164))
	CreateFuelTrigger(Vector(3084.339355, 2343.722656, 64.030991), Vector(3054.621826, 2343.727295, 28.028320), math.random(10,15))
	GAMEMODE:CreateStaticDecoration("models/lilyhl1/logoless_suv.mdl", Vector(3008.0446777344, 2128.2983398438, 0.47117546200752), Angle(-0.014640600420535, -179.98475646973, -0.00238037109375))
	CreateFuelTrigger(Vector(3084.477051, 2184.351318, 64.031250), Vector(3056.943604, 2184.345703, 28.031250), math.random(10,15))

	for k, v in pairs(ents.FindByClass("prop_physics")) do
		if v:GetModel() == "models/halflife/gibs/food/styrocup.mdl" or v:GetModel() == "models/halflife/gibs/food/can.mdl" then
			v:SetCollisionGroup(1)
		end
	end

	-- Easy Mode Exclusives
	-- Planks in the secret area
	if GetConVar("hl1_coop_sv_skill"):GetInt() == 1 then
		GAMEMODE:CreateStaticDecoration("models/props_debris/wood_board05a.mdl", Vector(4216.3984375, 905.80322265625, -430.50454711914), Angle(-89.998634338379, 89.999473571777, 180))
		GAMEMODE:CreateStaticDecoration("models/props_debris/wood_board05a.mdl", Vector(4216.1762695313, 1021.0776977539, -429.40353393555), Angle(88.441993713379, -72.639106750488, 16.118961334229))
		GAMEMODE:CreateStaticDecoration("models/props_debris/wood_board05a.mdl", Vector(4170.2084960938, 1135.8226318359, -431.50799560547), Angle(-89.592559814453, 56.507186889648, -119.40399169922))
		GAMEMODE:CreateStaticDecoration("models/props_debris/wood_board05a.mdl", Vector(4122.2236328125, 1228.9322509766, -429.66387939453), Angle(89.533363342285, -88.67529296875, 153.26473999023))
		GAMEMODE:CreateStaticDecoration("models/props_debris/wood_board05a.mdl", Vector(4086.8493652344, 1294.6390380859, -428.31311035156), Angle(-87.384567260742, 109.45048522949, -169.81646728516))
		GAMEMODE:CreateStaticDecoration("models/props_debris/wood_board05a.mdl", Vector(4081.0822753906, 1441.8677978516, -430.5588684082), Angle(-89.44856262207, -157.37545776367, 35.60619354248))
		GAMEMODE:CreateStaticDecoration("models/props_debris/wood_board05a.mdl", Vector(4131.9658203125, 1530.2720947266, -426.57208251953), Angle(88.884254455566, 43.762386322021, 161.70375061035))
		GAMEMODE:CreateStaticDecoration("models/props_debris/wood_board05a.mdl", Vector(4177.5346679688, 1610.2022705078, -425.39331054688), Angle(-84.900810241699, 56.496223449707, -175.80157470703))
		GAMEMODE:CreateStaticDecoration("models/props_debris/wood_board05a.mdl", Vector(4173.6220703125, 1764.9810791016, -427.92474365234), Angle(-86.73917388916, -61.124134063721, 1.8744788169861))
		GAMEMODE:CreateStaticDecoration("models/props_debris/wood_board05a.mdl", Vector(4115.8818359375, 1863.9150390625, -424.48187255859), Angle(-87.001922607422, 123.32921600342, 178.23114013672))
		GAMEMODE:CreateStaticDecoration("models/props_debris/wood_board05a.mdl", Vector(4065.3903808594, 1946.056640625, -427.29983520508), Angle(-86.651542663574, 129.48126220703, 172.06628417969))
		GAMEMODE:CreateStaticDecoration("models/props_debris/wood_board05a.mdl", Vector(4054.2766113281, 2091.1643066406, -432.27593994141), Angle(-89.142219543457, 90.019020080566, 169.69798278809))
		GAMEMODE:CreateStaticDecoration("models/props_debris/wood_board05a.mdl", Vector(4069.5979003906, 2190.7087402344, -430.44805908203), Angle(-89.723678588867, 8.372950553894, -106.7776184082))
	end

	if GetConVar("hl1_coop_sv_skill"):GetInt() == 4 then

		-- red fog
		local thefogiscoming = ents.Create("edit_fog")
		if IsValid(thefogiscoming) then
			thefogiscoming:SetPos(Vector(3378.548828125, 191.96705627441, 458.44061279297))
			thefogiscoming:SetAngles(Angle(0,0,0))
			thefogiscoming:Spawn()
			
			thefogiscoming:SetFogStart( 0.0 )
			thefogiscoming:SetFogEnd( 1463.16 )
			thefogiscoming:SetDensity( 1.0 )
			thefogiscoming:SetFogColor( Vector( 0.45, 0.0, 0.0 ) )
		end

		/*
		-- lock this door on very hard
		for k, v in pairs(ents.FindInBox(Vector(3281.171143, 795.531250, 256.031250), Vector(3277.789551, 756.468750, 256.031250))) do
			if v:GetClass() == "func_door_rotating" then
				v:Fire("lock")
				-- v:Fire(Lock,nil,0,v,
			end
		end
		*/

		-- remove the church gates
		for k, v in pairs(ents.FindInBox(Vector(5879.323730, 288.148407, 256.031250), Vector(5664.578613, 62.167233, 298.993256))) do
			if v:GetClass() == "func_door" then
				v:Remove()
			end
		end



	end

	-- GAMEMODE:CreatePhysicsDecoration("", Vector(), Angle())

	/*
	if MAP.ZombieSet == 2 then

		-- Resident Evil Cold Blood
		-- Offices Outside
		GAMEMODE:BHLCIE_CreateSpawner(Vector(2390.944580, 3022.607666, 64.068001), Angle(), 1, 1)
		GAMEMODE:BHLCIE_CreateSpawner(Vector(2433.629883, 2122.903076, 64.031250), Angle(), 1, 1)
		GAMEMODE:BHLCIE_CreateSpawner(Vector(3235.016113, 2620.722168, 64.031250), Angle(), 1, 1)
		GAMEMODE:BHLCIE_CreateSpawner(Vector(2136.622314, 1436.394043, 10), Angle(), 1, 1)
		-- Offices
		GAMEMODE:BHLCIE_CreateSpawner(Vector(2996.527100, 1523.994995, 84.031250), Angle(), 1, 1)
		GAMEMODE:BHLCIE_CreateSpawner(Vector(2513.736816, 1179.057007, 84.031250), Angle(), 1, 1)
		GAMEMODE:BHLCIE_CreateSpawner(Vector(2513.736816, 1614.435791, 80.031250), Angle(), 1, 1)
		GAMEMODE:BHLCIE_CreateSpawner(Vector(2384.626465, 1183.453369, 84.031250), Angle(), 1, 1)
		GAMEMODE:BHLCIE_CreateSpawner(Vector(3058.484375, 1253.220337, 70.031250), Angle(), 1, 1)
		-- Vehicle Tunnel
		GAMEMODE:BHLCIE_CreateSpawner(Vector(3870.591797, 2605.938477, 0.031250), Angle(), 1, 1)
		GAMEMODE:BHLCIE_CreateSpawner(Vector(4332.046387, 2258.768311, 0.031250), Angle(), 1, 1)
		GAMEMODE:BHLCIE_CreateSpawner(Vector(4354.608887, 3436.380371, 0.031250), Angle(), 1, 1)
		GAMEMODE:BHLCIE_CreateSpawner(Vector(4335.038086, 2256.738037, 0.031250), Angle(), 1, 1)
		-- Abandoned Offices Outside
		GAMEMODE:BHLCIE_CreateSpawner(Vector(4192.713379, 4874.968750, 0.031250), Angle(), 1, 1)
		GAMEMODE:BHLCIE_CreateSpawner(Vector(3395.019043, 4372.447754, 0.031250), Angle(), 1, 1)
		-- Abandoned Offices
		GAMEMODE:BHLCIE_CreateSpawner(Vector(2355.584473, 4410.699707, 46.031250), Angle(), 1, 1)
		GAMEMODE:BHLCIE_CreateSpawner(Vector(1692.188843, 4066.072754, 158.031250), Angle(), 1, 1)
		GAMEMODE:BHLCIE_CreateSpawner(Vector(2319.202881, 4409.510254, 254.031250), Angle(), 1, 1)
		-- Church Outside
		GAMEMODE:BHLCIE_CreateSpawner(Vector(4529.850586, 1251.144775, 0.031250), Angle(), 1, 1)
		GAMEMODE:BHLCIE_CreateSpawner(Vector(6244.919922, 1189.830688, 206.031250), Angle(), 1, 1)
		GAMEMODE:BHLCIE_CreateSpawner(Vector(6486.012207, 175.280975, 206.031250), Angle(), 1, 1)
		GAMEMODE:BHLCIE_CreateSpawner(Vector(6475.668945, -893.354065, 307.364288), Angle(), 1, 1)
		GAMEMODE:BHLCIE_CreateSpawner(Vector(6036.860352, -868.889038, 301.251770), Angle(), 1, 1)
		GAMEMODE:BHLCIE_CreateSpawner(Vector(5369.437012, 181.950119, 208.031250), Angle(), 1, 1) -- Parking Lot
		GAMEMODE:BHLCIE_CreateSpawner(Vector(4172.881348, 194.964142, 206.031342), Angle(), 1, 1) -- Infront of Church
		GAMEMODE:BHLCIE_CreateSpawner(Vector(1937.267212, 169.444550, 206.031250), Angle(), 1, 1) -- Behind Church
		-- Church
		GAMEMODE:BHLCIE_CreateSpawner(Vector(2766.938477, 193.152130, 206.031250), Angle(), 1, 1)
		-- Portal to HERESY
		GAMEMODE:BHLCIE_CreateSpawner(Vector(6813.631348, -2081.557861, 344.031250), Angle(), 1, 1)
		-- HERESY
		GAMEMODE:BHLCIE_CreateSpawner(Vector(3537.548828, 8951.824219, -7420.968750), Angle(), 1, 1)
		GAMEMODE:BHLCIE_CreateSpawner(Vector(2719.767578, 9505.716797, -7350.968750), Angle(), 1, 1)
		GAMEMODE:BHLCIE_CreateSpawner(Vector(2642.456543, 10555.260742, -7067.968750), Angle(), 1, 1)
		GAMEMODE:BHLCIE_CreateSpawner(Vector(1801.810791, 10711.543945, -6939.968750), Angle(), 1, 1)
		GAMEMODE:BHLCIE_CreateSpawner(Vector(2655.082031, 10556.724609, -7067.968750), Angle(), 1, 1)
		GAMEMODE:BHLCIE_CreateSpawner(Vector(2649.021729, 10449.067383, -6811.968750), Angle(), 1, 1)
		GAMEMODE:BHLCIE_CreateSpawner(Vector(2794.906982, 9495.152344, -6811.968750), Angle(), 1, 1)
		GAMEMODE:BHLCIE_CreateSpawner(Vector(3199.390869, 10245.243164, -6811.968750), Angle(), 1, 1)
		GAMEMODE:BHLCIE_CreateSpawner(Vector(3015.751465, 10619.413086, -6811.968750), Angle(), 1, 1)
		GAMEMODE:BHLCIE_CreateSpawner(Vector(3009.863037, 9845.065430, -6811.968750), Angle(), 1, 1)
		GAMEMODE:BHLCIE_CreateSpawner(Vector(3653.265869, 10238.319336, -6811.968750), Angle(), 1, 1)
		GAMEMODE:BHLCIE_CreateSpawner(Vector(3778.140381, 10618.083008, -6811.968750), Angle(), 1, 1)
		GAMEMODE:BHLCIE_CreateSpawner(Vector(3782.743164, 9854.017578, -6811.968750), Angle(), 1, 1)
		GAMEMODE:BHLCIE_CreateSpawner(Vector(3773.689697, 10606.888672, -6811.968750), Angle(), 1, 1)
		GAMEMODE:BHLCIE_CreateSpawner(Vector(4131.134766, 10622.812500, -6811.968750), Angle(), 1, 1)
		GAMEMODE:BHLCIE_CreateSpawner(Vector(4848.227539, 10567.101563, -6811.968750), Angle(), 1, 1)
		GAMEMODE:BHLCIE_CreateSpawner(Vector(4631.407227, 9539.171875, -6772.512695), Angle(), 1, 1)
		GAMEMODE:BHLCIE_CreateSpawner(Vector(4444.366699, 9552.232422, -6751.972656), Angle(), 1, 1)
		GAMEMODE:BHLCIE_CreateSpawner(Vector(4434.746094, 9418.627930, -6754.395508), Angle(), 1, 1)
		GAMEMODE:BHLCIE_CreateSpawner(Vector(4618.332520, 9420.189453, -6766.551758), Angle(), 1, 1)

	else
	*/

		-- -=< Default Zombies >=-

		if GetConVar("hl1_coop_sv_skill"):GetInt() == 1 then -- Easy
			---- -=< Topside >=- ----
			--- Outside Offices
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(2390.944580, 3022.607666, 64.068001), Angle(), 2, 0.5) -- Infront of Shack / Scientists, Barneys and HECUs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(2370.381592, 2044.245728, 64.031250), Angle(), 2, 0.5) -- Near Furnace Room Entrance / Scientists, Barneys and HECUs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(3235.016113, 2620.722168, 64.031250), Angle(), 2, 0.5) -- Party Aftermath Area / Scientists, Barneys and HECUs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(2136.622314, 1436.394043, 2), Angle(), 2, 0.5) -- Dumpsters / Scientists, Barneys and HECUs
			--- Offices
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(2996.527100, 1523.994995, 84.031250), Angle(), 2, 0.5) -- Reception / Scientists, Barneys and HECUs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(2513.736816, 1179.057007, 84.031250), Angle(), 2, 0.5) -- Bustin' Makes Me Feel Good / Scientists, Barneys and HECUs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(2586.712646, 1615.526733, 84.031250), Angle(), 2, 0.5) -- Yellow Chair / Scientists, Barneys and HECUs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(3058.484375, 1253.220337, 70.031250), Angle(), 2, 0.5) -- Power Room? / Scientists, Barneys and HECUs
			-- Furnace Room
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(2793.667236, 1948.566650, -303.968750), Angle(), 5, 0.5) -- Furnace Room / Barneys
			-- Vehicle Tunnel
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(3836.025146, 2646.441162, 64.031250), Angle(), 1, 0.5) -- Next to Outside Offices Gate / Scientists and Barneys
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(4332.046387, 2258.768311, 0.031250), Angle(), 1, 0.5) -- Next to Outside Church Gate / Scientists and Barneys
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(4354.608887, 3436.380371, 0.031250), Angle(), 1, 0.5) -- Next to Outside Abandoned Offices Gate / Scientists and Barneys
			-- Abandoned Offices Outside
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(4192.713379, 4874.968750, 0.031250), Angle(), 1, 0.5) -- Street Lamp (not the one near the fuel barrels) / Scientists and Barneys
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(3395.019043, 4372.447754, 0.031250), Angle(), 1, 0.5) -- Parking Lot/Infront of Abandoned Offices / Scientists and Barneys
			-- Abandoned Offices
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(2355.584473, 4410.699707, 46.031250), Angle(), 1, 0.5) -- Reception / Scientists and Barneys
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(1692.188843, 4066.072754, 158.031250), Angle(), 1, 0.5) -- Stairwell / Scientists and Barneys
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(2319.202881, 4409.510254, 254.031250), Angle(), 1, 0.5) -- Upper Floor / Scientists and Barneys
			-- Church Outside
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(4716.083496, 1188.934814, 64.038895), Angle(), 1, 0.5) -- Near Vehicle Tunnel Gate / Scientists and Barneys
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(6398.260254, 1306.271973, 256.031250), Angle(), 1, 0.5) -- Bend between Church Gate and Tunnel Gate / Scientists and Barneys
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(6486.012207, 175.280975, 206.031250), Angle(), 1, 0.5) -- Across from Church Gate / Scientists and Barneys
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(6052.550293, -370.338562, 220.031250), Angle(), 5, 0.5) -- Security Booth / Barneys
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(6317.812500, -953.812805, 322.482391), Angle(), 1, 0.5) -- Near Gate to Hell Portal / Scientists and Barneys
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(5369.437012, 181.950119, 208.031250), Angle(), 1, 0.5) -- Parking Lot / Scientists and Barneys
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(4172.881348, 194.964142, 206.031342), Angle(), 1, 0.5) -- Infront of Church / Scientists and Barneys
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(1937.267212, 169.444550, 206.031250), Angle(), 1, 0.5) -- Behind Church / Scientists and Barneys
			-- Church
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(2766.938477, 193.152130, 206.031250), Angle(), 1, 0.5) -- Inside the Church / Scientists and Barneys
			-- Portal to HERESY
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(6813.631348, -2081.557861, 344.031250), Angle(), 6, 0.5) -- Near Hell Portal / HEVs
			---- -=< HERESY >=- ----
			-- Lava Room / Barrel Hallway
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(3537.548828, 8951.824219, -7420.968750), Angle(), 6, 0.5) -- Lava Room / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(2719.767578, 9505.716797, -7350.968750), Angle(), 6, 0.5) -- Barrel Cell Hallway / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(2642.456543, 10555.260742, -7067.968750), Angle(), 6, 0.5) -- Barrel Cell Hallway / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(1801.810791, 10711.543945, -6939.968750), Angle(), 6, 0.5) -- Barrel Cell Hallway / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(2655.082031, 10556.724609, -7067.968750), Angle(), 6, 0.5) -- Barrel Cell Hallway / HEVs
			-- Main Area
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(2649.021729, 10449.067383, -6811.968750), Angle(), 6, 0.5) -- Main Area, Next to Barrel Cell Hallway / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(2794.906982, 9495.152344, -6811.968750), Angle(), 6, 0.5) -- Main Area, Next to Spikes / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(4131.134766, 10622.812500, -6811.968750), Angle(), 6, 0.5) -- Main Area, Near Jail Cells Courtyard / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(4848.227539, 10567.101563, -6811.968750), Angle(), 6, 0.5) -- Main Area, Across from Bone Pile / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(3199.390869, 10245.243164, -6811.968750), Angle(), 6, 0.5) -- Jail Cells Courtyard / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(3653.265869, 10238.319336, -6811.968750), Angle(), 6, 0.5) -- Jail Cells Courtyard / HEVs
			-- Cells
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(3015.751465, 10619.413086, -6811.968750), Angle(), 6, 0.5) -- Tau Cannon / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(3009.863037, 9845.065430, -6811.968750), Angle(), 6, 0.5) -- M249 / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(3782.743164, 9854.017578, -6811.968750), Angle(), 6, 0.5) -- Crossbow / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(3773.689697, 10606.888672, -6811.968750), Angle(), 6, 0.5) -- RPG / HEVs
			-- Bone Pile
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(4631.407227, 9539.171875, -6772.512695), Angle(), 6, 0.5) -- Bone Pile / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(4444.366699, 9552.232422, -6751.972656), Angle(), 6, 0.5) -- Bone Pile / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(4434.746094, 9418.627930, -6754.395508), Angle(), 6, 0.5) -- Bone Pile / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(4618.332520, 9420.189453, -6766.551758), Angle(), 6, 0.5) -- Bone Pile / HEVs
		end
		if GetConVar("hl1_coop_sv_skill"):GetInt() == 2 then -- Medium
			---- -=< Topside >=- ----
			--- Outside Offices
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(2390.944580, 3022.607666, 64.068001), Angle(), 2, 0.65) -- Infront of Shack / Scientists, Barneys and HECUs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(2370.381592, 2044.245728, 64.031250), Angle(), 2, 0.65) -- Near Furnace Room Entrance / Scientists, Barneys and HECUs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(3235.016113, 2620.722168, 64.031250), Angle(), 2, 0.65) -- Party Aftermath Area / Scientists, Barneys and HECUs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(2136.622314, 1436.394043, 2), Angle(), 2, 1) -- Dumpsters / Scientists, Barneys and HECUs
			--- Offices
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(2996.527100, 1523.994995, 84.031250), Angle(), 2, 0.65) -- Reception / Scientists, Barneys and HECUs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(2513.736816, 1179.057007, 84.031250), Angle(), 2, 0.85) -- Bustin' Makes Me Feel Good / Scientists, Barneys and HECUs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(2586.712646, 1615.526733, 84.031250), Angle(), 2, 0.65) -- Yellow Chair / Scientists, Barneys and HECUs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(3058.484375, 1253.220337, 70.031250), Angle(), 2, 0.65) -- Power Room? / Scientists, Barneys and HECUs
			-- Furnace Room
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(2793.667236, 1948.566650, -303.968750), Angle(), 5, 0.5) -- Furnace Room / Barneys
			-- Vehicle Tunnel
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(3836.025146, 2646.441162, 64.031250), Angle(), 1, 0.85) -- Next to Outside Offices Gate / Scientists and Barneys
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(4332.046387, 2258.768311, 0.031250), Angle(), 1, 0.65) -- Next to Outside Church Gate / Scientists and Barneys
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(4354.608887, 3436.380371, 0.031250), Angle(), 1, 0.85) -- Next to Outside Abandoned Offices Gate / Scientists and Barneys
			-- Abandoned Offices Outside
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(4192.713379, 4874.968750, 0.031250), Angle(), 1, 0.85) -- Street Lamp (not the one near the fuel barrels) / Scientists and Barneys
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(3395.019043, 4372.447754, 0.031250), Angle(), 1, 0.85) -- Parking Lot/Infront of Abandoned Offices / Scientists and Barneys
			-- Abandoned Offices
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(2355.584473, 4410.699707, 46.031250), Angle(), 1, 0.85) -- Reception / Scientists and Barneys
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(1692.188843, 4066.072754, 158.031250), Angle(), 1, 0.85) -- Stairwell / Scientists and Barneys
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(2319.202881, 4409.510254, 254.031250), Angle(), 1, 0.85) -- Upper Floor / Scientists and Barneys
			-- Church Outside
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(4716.083496, 1188.934814, 64.038895), Angle(), 1, 0.85) -- Near Vehicle Tunnel Gate / Scientists and Barneys
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(6398.260254, 1306.271973, 256.031250), Angle(), 1, 0.85) -- Bend between Church Gate and Tunnel Gate / Scientists and Barneys
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(6486.012207, 175.280975, 206.031250), Angle(), 1, 0.85) -- Across from Church Gate / Scientists and Barneys
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(6052.550293, -370.338562, 220.031250), Angle(), 5, 0.85) -- Security Booth / Barneys
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(6317.812500, -953.812805, 322.482391), Angle(), 1, 0.85) -- Near Gate to Hell Portal / Scientists and Barneys
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(5369.437012, 181.950119, 208.031250), Angle(), 1, 0.85) -- Parking Lot / Scientists and Barneys
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(4172.881348, 194.964142, 206.031342), Angle(), 1, 0.85) -- Infront of Church / Scientists and Barneys
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(1937.267212, 169.444550, 206.031250), Angle(), 1, 0.85) -- Behind Church / Scientists and Barneys
			-- Church
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(2766.938477, 193.152130, 206.031250), Angle(), 1, 0.85) -- Inside the Church / Scientists and Barneys
			-- Portal to HERESY
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(6813.631348, -2081.557861, 344.031250), Angle(), 6, 0.85) -- Near Hell Portal / HEVs
			---- -=< HERESY >=- ----
			-- Lava Room / Barrel Hallway
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(3537.548828, 8951.824219, -7420.968750), Angle(), 6, 0.85) -- Lava Room / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(2719.767578, 9505.716797, -7350.968750), Angle(), 6, 0.65) -- Barrel Cell Hallway / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(2642.456543, 10555.260742, -7067.968750), Angle(), 6, 0.65) -- Barrel Cell Hallway / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(1801.810791, 10711.543945, -6939.968750), Angle(), 6, 0.65) -- Barrel Cell Hallway / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(2655.082031, 10556.724609, -7067.968750), Angle(), 6, 0.65) -- Barrel Cell Hallway / HEVs
			-- Main Area
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(2649.021729, 10449.067383, -6811.968750), Angle(), 6, 0.65) -- Main Area, Next to Barrel Cell Hallway / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(2794.906982, 9495.152344, -6811.968750), Angle(), 6, 0.65) -- Main Area, Next to Spikes / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(4131.134766, 10622.812500, -6811.968750), Angle(), 6, 0.65) -- Main Area, Near Jail Cells Courtyard / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(4848.227539, 10567.101563, -6811.968750), Angle(), 6, 0.65) -- Main Area, Across from Bone Pile / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(3199.390869, 10245.243164, -6811.968750), Angle(), 6, 0.65) -- Jail Cells Courtyard / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(3653.265869, 10238.319336, -6811.968750), Angle(), 6, 0.65) -- Jail Cells Courtyard / HEVs
			-- Cells
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(3015.751465, 10619.413086, -6811.968750), Angle(), 6, 1) -- Tau Cannon / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(3009.863037, 9845.065430, -6811.968750), Angle(), 6, 1) -- M249 / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(3782.743164, 9854.017578, -6811.968750), Angle(), 6, 1) -- Crossbow / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(3773.689697, 10606.888672, -6811.968750), Angle(), 6, 1) -- RPG / HEVs
			-- Bone Pile
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(4631.407227, 9539.171875, -6772.512695), Angle(), 6, 0.85) -- Bone Pile / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(4444.366699, 9552.232422, -6751.972656), Angle(), 6, 0.85) -- Bone Pile / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(4434.746094, 9418.627930, -6754.395508), Angle(), 6, 0.85) -- Bone Pile / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(4618.332520, 9420.189453, -6766.551758), Angle(), 6, 0.85) -- Bone Pile / HEVs
		end
		if GetConVar("hl1_coop_sv_skill"):GetInt() == 3 then -- Hard
			---- -=< Topside >=- ----
			--- Outside Offices
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(2390.944580, 3022.607666, 64.068001), Angle(), 3, 1) -- Infront of Shack / Scientists, Barneys, HECUs and HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(2370.381592, 2044.245728, 64.031250), Angle(), 3, 1) -- Near Furnace Room Entrance / Scientists, Barneys, HECUs and HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(3235.016113, 2620.722168, 64.031250), Angle(), 3, 1) -- Party Aftermath Area / Scientists, Barneys, HECUs and HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(2136.622314, 1436.394043, 2), Angle(), 3, 1) -- Dumpsters / Scientists, Barneys, HECUs and HEVs
			--- Offices
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(2996.527100, 1523.994995, 84.031250), Angle(), 3, 1) -- Reception / Scientists, Barneys, HECUs and HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(2513.736816, 1179.057007, 84.031250), Angle(), 3, 1) -- Bustin' Makes Me Feel Good / Scientists, Barneys, HECUs and HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(2586.712646, 1615.526733, 84.031250), Angle(), 3, 1) -- Yellow Chair / Scientists, Barneys, HECUs and HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(3058.484375, 1253.220337, 70.031250), Angle(), 3, 1) -- Power Room? / Scientists, Barneys, HECUs and HEVs
			-- Furnace Room
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(2793.667236, 1948.566650, -303.968750), Angle(), 5, 1) -- Furnace Room / Barneys
			-- Vehicle Tunnel
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(3836.025146, 2646.441162, 64.031250), Angle(), 7, 1) -- Next to Outside Offices Gate / Scientists, Barneys and HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(4332.046387, 2258.768311, 0.031250), Angle(), 7, 1) -- Next to Outside Church Gate / Scientists, Barneys and HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(4354.608887, 3436.380371, 0.031250), Angle(), 7, 1) -- Next to Outside Abandoned Offices Gate / Scientists, Barneys and HEVs
			-- Abandoned Offices Outside
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(4192.713379, 4874.968750, 0.031250), Angle(), 7, 1) -- Street Lamp (not the one near the fuel barrels) / Scientists, Barneys and HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(3395.019043, 4372.447754, 0.031250), Angle(), 7, 1) -- Parking Lot/Infront of Abandoned Offices / Scientists, Barneys and HEVs
			-- Abandoned Offices
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(2355.584473, 4410.699707, 46.031250), Angle(), 7, 1) -- Reception / Scientists, Barneys and HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(1692.188843, 4066.072754, 158.031250), Angle(), 7, 1) -- Stairwell / Scientists, Barneys and HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(2319.202881, 4409.510254, 254.031250), Angle(), 7, 1) -- Upper Floor / Scientists, Barneys and HEVs
			-- Church Outside
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(4716.083496, 1188.934814, 64.038895), Angle(), 7, 1) -- Near Vehicle Tunnel Gate / Scientists, Barneys and HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(6398.260254, 1306.271973, 256.031250), Angle(), 7, 1) -- Bend between Church Gate and Tunnel Gate / Scientists, Barneys and HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(6486.012207, 175.280975, 206.031250), Angle(), 7, 1) -- Across from Church Gate / Scientists, Barneys and HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(6052.550293, -370.338562, 220.031250), Angle(), 5, 1) -- Security Booth / Barneys
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(6317.812500, -953.812805, 322.482391), Angle(), 7, 1) -- Near Gate to Hell Portal / Scientists, Barneys and HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(5369.437012, 181.950119, 208.031250), Angle(), 7, 1) -- Parking Lot / Scientists, Barneys and HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(4172.881348, 194.964142, 206.031342), Angle(), 7, 1) -- Infront of Church / Scientists, Barneys and HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(1937.267212, 169.444550, 206.031250), Angle(), 7, 1) -- Behind Church / Scientists, Barneys and HEVs
			-- Church
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(2766.938477, 193.152130, 206.031250), Angle(), 7, 1) -- Inside the Church / Scientists, Barneys and HEVs
			-- Portal to HERESY
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(6813.631348, -2081.557861, 344.031250), Angle(), 6, 1) -- Near Hell Portal / HEVs
			---- -=< HERESY >=- ----
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(3537.548828, 8951.824219, -7420.968750), Angle(), 6, 1) -- Lava Room / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(2719.767578, 9505.716797, -7350.968750), Angle(), 6, 1) -- Barrel Cell Hallway / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(2642.456543, 10555.260742, -7067.968750), Angle(), 6, 1) -- Barrel Cell Hallway / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(1801.810791, 10711.543945, -6939.968750), Angle(), 6, 1) -- Barrel Cell Hallway / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(2655.082031, 10556.724609, -7067.968750), Angle(), 6, 1) -- Barrel Cell Hallway / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(2649.021729, 10449.067383, -6811.968750), Angle(), 6, 1) -- Main Area, Next to Barrel Cell Hallway / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(2794.906982, 9495.152344, -6811.968750), Angle(), 6, 1) -- Main Area, Next to Spikes / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(4131.134766, 10622.812500, -6811.968750), Angle(), 6, 1) -- Main Area, Near Jail Cells Courtyard / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(4848.227539, 10567.101563, -6811.968750), Angle(), 6, 1) -- Main Area, Across from Bone Pile / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(3199.390869, 10245.243164, -6811.968750), Angle(), 6, 1) -- Jail Cells Courtyard / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(3653.265869, 10238.319336, -6811.968750), Angle(), 6, 1) -- Jail Cells Courtyard / HEVs
			-- Cells
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(3015.751465, 10619.413086, -6811.968750), Angle(), 6, 1.5) -- Tau Cannon / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(3009.863037, 9845.065430, -6811.968750), Angle(), 6, 1.5) -- M249 / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(3782.743164, 9854.017578, -6811.968750), Angle(), 6, 1.5) -- Crossbow / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(3773.689697, 10606.888672, -6811.968750), Angle(), 6, 1.5) -- RPG / HEVs
			-- Bone Pile
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(4631.407227, 9539.171875, -6772.512695), Angle(), 6, 2) -- Bone Pile / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(4444.366699, 9552.232422, -6751.972656), Angle(), 6, 2) -- Bone Pile / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(4434.746094, 9418.627930, -6754.395508), Angle(), 6, 2) -- Bone Pile / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(4618.332520, 9420.189453, -6766.551758), Angle(), 6, 2) -- Bone Pile / HEVs
		end
		if GetConVar("hl1_coop_sv_skill"):GetInt() == 4 then -- Very Hard
			---- -=< Topside >=- ----
			--- Outside Offices
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(2390.944580, 3022.607666, 64.068001), Angle(), 6, 1) -- Infront of Shack / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(2370.381592, 2044.245728, 64.031250), Angle(), 6, 1) -- Near Furnace Room Entrance / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(3235.016113, 2620.722168, 64.031250), Angle(), 6, 1) -- Party Aftermath Area / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(2136.622314, 1436.394043, 2), Angle(), 6, 1.5) -- Dumpsters / HEVs
			--- Offices
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(2996.527100, 1523.994995, 84.031250), Angle(), 6, 1) -- Reception / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(2513.736816, 1179.057007, 84.031250), Angle(), 6, 1.5) -- Bustin' Makes Me Feel Good / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(2586.712646, 1615.526733, 84.031250), Angle(), 6, 1) -- Yellow Chair / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(3058.484375, 1253.220337, 70.031250), Angle(), 6, 1) -- Power Room? / HEVs
			-- Furnace Room
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(2793.667236, 1948.566650, -303.968750), Angle(), 6, 1) -- Furnace Room / HEVs
			-- Vehicle Tunnel
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(3836.025146, 2646.441162, 64.031250), Angle(), 6, 1) -- Next to Outside Offices Gate / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(4332.046387, 2258.768311, 0.031250), Angle(), 6, 1) -- Next to Outside Church Gate / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(4354.608887, 3436.380371, 0.031250), Angle(), 6, 1) -- Next to Outside Abandoned Offices Gate / HEVs
			-- Abandoned Offices Outside
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(4192.713379, 4874.968750, 0.031250), Angle(), 6, 2) -- Street Lamp (not the one near the fuel barrels) / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(3395.019043, 4372.447754, 0.031250), Angle(), 6, 2) -- Parking Lot/Infront of Abandoned Offices / HEVs
			-- Abandoned Offices
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(2355.584473, 4410.699707, 46.031250), Angle(), 6, 2) -- Reception / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(1692.188843, 4066.072754, 158.031250), Angle(), 6, 2) -- Stairwell / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(2319.202881, 4409.510254, 254.031250), Angle(), 6, 2) -- Upper Floor / HEVs
			-- Church Outside
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(4716.083496, 1188.934814, 64.038895), Angle(), 6, 2) -- Near Vehicle Tunnel Gate / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(6398.260254, 1306.271973, 256.031250), Angle(), 6, 2) -- Bend between Church Gate and Tunnel Gate / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(6486.012207, 175.280975, 206.031250), Angle(), 6, 2) -- Across from Church Gate / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(6052.550293, -370.338562, 220.031250), Angle(), 6, 2) -- Security Booth / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(6317.812500, -953.812805, 322.482391), Angle(), 6, 2) -- Near Gate to Hell Portal / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(5369.437012, 181.950119, 208.031250), Angle(), 6, 2) -- Parking Lot / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(4172.881348, 194.964142, 206.031342), Angle(), 6, 2) -- Infront of Church / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(1937.267212, 169.444550, 206.031250), Angle(), 6, 2) -- Behind Church / HEVs
			-- Church
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(2766.938477, 193.152130, 206.031250), Angle(), 6, 1) -- Inside the Church / HEVs
			-- Portal to HERESY
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(6813.631348, -2081.557861, 344.031250), Angle(), 6, 2) -- Near Hell Portal / HEVs
			---- -=< HERESY >=- ----
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(3537.548828, 8951.824219, -7420.968750), Angle(), 6, 1) -- Lava Room / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(2719.767578, 9505.716797, -7350.968750), Angle(), 6, 1) -- Barrel Cell Hallway / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(2642.456543, 10555.260742, -7067.968750), Angle(), 6, 1) -- Barrel Cell Hallway / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(1801.810791, 10711.543945, -6939.968750), Angle(), 6, 1) -- Barrel Cell Hallway / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(2655.082031, 10556.724609, -7067.968750), Angle(), 6, 1) -- Barrel Cell Hallway / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(2649.021729, 10449.067383, -6811.968750), Angle(), 6, 1) -- Main Area, Next to Barrel Cell Hallway / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(2794.906982, 9495.152344, -6811.968750), Angle(), 6, 1) -- Main Area, Next to Spikes / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(4131.134766, 10622.812500, -6811.968750), Angle(), 6, 1) -- Main Area, Near Jail Cells Courtyard / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(4848.227539, 10567.101563, -6811.968750), Angle(), 6, 1) -- Main Area, Across from Bone Pile / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(3199.390869, 10245.243164, -6811.968750), Angle(), 6, 1) -- Jail Cells Courtyard / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(3653.265869, 10238.319336, -6811.968750), Angle(), 6, 1) -- Jail Cells Courtyard / HEVs
			-- Cells
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(3015.751465, 10619.413086, -6811.968750), Angle(), 6, 2) -- Tau Cannon / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(3009.863037, 9845.065430, -6811.968750), Angle(), 6, 2) -- M249 / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(3782.743164, 9854.017578, -6811.968750), Angle(), 6, 2) -- Crossbow / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(3773.689697, 10606.888672, -6811.968750), Angle(), 6, 2) -- RPG / HEVs
			-- Bone Pile
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(4631.407227, 9539.171875, -6772.512695), Angle(), 6, 3) -- Bone Pile / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(4444.366699, 9552.232422, -6751.972656), Angle(), 6, 3) -- Bone Pile / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(4434.746094, 9418.627930, -6754.395508), Angle(), 6, 3) -- Bone Pile / HEVs
			GAMEMODE:BHLCIE_CreateSpawner_ModifiedBaseZombSpawner(Vector(4618.332520, 9420.189453, -6766.551758), Angle(), 6, 3) -- Bone Pile / HEVs
		end

	-- end

end

function MAP:AddItemPickups()

	/*
	special weapons
	
	weapon_ak47
	weapon_m16
	weapon_doublebarrel
	weapon_m249
	weapon_sniperrifle
	weapon_rocketlauncher
	weapon_minigun
	*/

	--/ Shack across from Offices
	if GetConVar("hl1_coop_sv_skill"):GetInt() == 3 or GetConVar("hl1_coop_sv_skill"):GetInt() == 4 then
		GAMEMODE:CreateWeaponEntity("weapon_doublebarrel", Vector(2284.041260, 3420.636230, 28.031250), Angle(0, -90, 0))
	else
		GAMEMODE:CreateWeaponEntity("weapon_shotgun", Vector(2284.041260, 3420.636230, 28.031250), Angle(0, -90, 0))
	end
	GAMEMODE:CreatePickupEntity("ammo_buckshot", Vector(2270.316162, 3405.223877, 36.031250), Angle())

	--/ Boiler Room (more like a furnace room but whatever)
	GAMEMODE:CreateWeaponEntity("weapon_handgrenade", Vector(2721.590820, 2122.607178, -337.418701), Angle())

	--/ Mines
	GAMEMODE:CreateWeaponEntity("weapon_satchel", Vector(1920.107666, 2390.736328, -337.290161), Angle())
	GAMEMODE:CreateWeaponEntity("weapon_satchel", Vector(1947.272827, 2363.850342, -321.888306), Angle())

	--/ Outside Offices
	if GetConVar("hl1_coop_sv_skill"):GetInt() == 4 then
		GAMEMODE:CreateWeaponEntity("weapon_m16", Vector(3156.703369, 2995.734619, 28.031250), Angle())
	else
		GAMEMODE:CreateWeaponEntity("weapon_mp5", Vector(3156.703369, 2995.734619, 28.031250), Angle())
	end
	GAMEMODE:CreatePickupEntity("item_healthkit", Vector(3211.044678, 2963.252197, 28.031250), Angle())

	GAMEMODE:CreatePickupEntity("item_battery", Vector(2151.611328, 1512.001221, 228.031250), Angle())

	GAMEMODE:CreatePickupEntity("weapon_doublebarrel", Vector(2848.142578, 1822.902954, 476.031250), Angle())
	GAMEMODE:CreatePickupEntity("ammo_buckshot", Vector(2946.992920, 1920.101440, 476.031250), Angle(0, 45, 0))
	GAMEMODE:CreatePickupEntity("ammo_buckshot", Vector(2750.026855, 1924.098389, 476.031250), Angle(0, 135, 0))
	GAMEMODE:CreatePickupEntity("ammo_buckshot", Vector(2747.840576, 1722.439331, 476.031250), Angle(0, -135, 0))
	GAMEMODE:CreatePickupEntity("ammo_buckshot", Vector(2945.315918, 1723.916626, 476.031250), Angle(0, -45, 0))

	GAMEMODE:CreateWeaponEntity("weapon_m16", Vector(2866.373535, 2627.269043, 348.031250), Angle())
	GAMEMODE:CreatePickupEntity("ammo_mp5grenades", Vector(2831.452148, 2687.641357, 348.031250), Angle())
	GAMEMODE:CreatePickupEntity("ammo_mp5grenades", Vector(2831.217041, 2559.963623, 342.723480), Angle())

	-- Weapon Caches

	if GetConVar("hl1_coop_sv_skill"):GetInt() == 4 then
		GAMEMODE:CreateWeaponEntity("weapon_doublebarrel", Vector(2063.476807, 2884.340576, 61.441383), Angle(0, 90, 0))
		GAMEMODE:CreateWeaponEntity("weapon_doublebarrel", Vector(2083.476807, 2884.340576, 61.441383), Angle(0, -90, 0))
		GAMEMODE:CreateWeaponEntity("weapon_m16", Vector(2063.476807, 2969.340576, 61.441383), Angle(0, 180, 0))
		GAMEMODE:CreateWeaponEntity("weapon_m16", Vector(2083.476807, 2969.340576, 61.441383), Angle(0, 0, 0))
	else
		if GetConVar("hl1_coop_sv_skill"):GetInt() == 1 or GetConVar("hl1_coop_sv_skill"):GetInt() == 4 then
			GAMEMODE:CreateWeaponEntity("weapon_shotgun", Vector(2063.476807, 2864.340576, 61.441383), Angle(0, 90, 0))
			GAMEMODE:CreateWeaponEntity("weapon_shotgun", Vector(2083.476807, 2904.340576, 61.441383), Angle(0, -90, 0))
			GAMEMODE:CreateWeaponEntity("weapon_mp5", Vector(2063.476807, 2989.340576, 61.441383), Angle(0, 180, 0))
			GAMEMODE:CreateWeaponEntity("weapon_mp5", Vector(2083.476807, 2949.340576, 61.441383), Angle(0, 0, 0))
		end
		if GetConVar("hl1_coop_sv_skill"):GetInt() != 3 then
			GAMEMODE:CreateWeaponEntity("weapon_shotgun", Vector(2083.476807, 2864.340576, 61.441383), Angle(0, -90, 0))
			GAMEMODE:CreateWeaponEntity("weapon_mp5", Vector(2063.476807, 2949.340576, 61.441383), Angle(0, 180, 0))
		end
		GAMEMODE:CreateWeaponEntity("weapon_shotgun", Vector(2063.476807, 2904.340576, 61.441383), Angle(0, 90, 0))
		GAMEMODE:CreateWeaponEntity("weapon_mp5", Vector(2083.476807, 2989.340576, 61.441383), Angle(0, 0, 0))
	end

	if GetConVar("hl1_coop_sv_skill"):GetInt() == 1 or GetConVar("hl1_coop_sv_skill"):GetInt() == 4 then
		GAMEMODE:CreateWeaponEntity("weapon_rpg", Vector(2173.035156, 2889.813477, 64.459694), Angle(0, 90, 0))
		GAMEMODE:CreatePickupEntity("ammo_rpgclip", Vector(2145.466553, 2855.245361, 28.031250), Angle())
		GAMEMODE:CreatePickupEntity("ammo_rpgclip", Vector(2145.466553, 2870.245361, 28.031250), Angle())
		GAMEMODE:CreatePickupEntity("ammo_rpgclip", Vector(2145.466553, 2885.245361, 28.031250), Angle())
		GAMEMODE:CreatePickupEntity("ammo_rpgclip", Vector(2145.466553, 2900.245361, 28.031250), Angle())
	end

	if GetConVar("hl1_coop_sv_skill"):GetInt() == 1 or GetConVar("hl1_coop_sv_skill"):GetInt() == 4 then
		GAMEMODE:CreateWeaponEntity("weapon_satchel", Vector(2182.790039, 2989.430176, 64.528397), Angle(0, 0, 0))
	end
	GAMEMODE:CreateWeaponEntity("weapon_satchel", Vector(2182.790039, 2969.430176, 64.528397), Angle(0, 0, 0))
	if GetConVar("hl1_coop_sv_skill"):GetInt() != 3 then
		GAMEMODE:CreateWeaponEntity("weapon_satchel", Vector(2182.790039, 2949.430176, 64.528397), Angle(0, 0, 0))
	end

	if GetConVar("hl1_coop_sv_skill"):GetInt() == 1 or GetConVar("hl1_coop_sv_skill"):GetInt() == 4 then

		GAMEMODE:CreateWeaponEntity("weapon_sniperrifle", Vector(1973.101807, 2875.420654, 112.374535), Angle(0, -90, 0))
		GAMEMODE:CreateWeaponEntity("weapon_m249", Vector(1973.101807, 2955.420654, 112.374535), Angle(0, -90, 0))

		GAMEMODE:CreatePickupEntity("ammo_sniper", Vector(1999.954834, 2832.554688, 28.031208), Angle())
		GAMEMODE:CreatePickupEntity("ammo_sniper", Vector(1999.954834, 2852.554688, 28.031208), Angle())
		GAMEMODE:CreatePickupEntity("ammo_sniper", Vector(1999.954834, 2872.554688, 28.031208), Angle())
		GAMEMODE:CreatePickupEntity("ammo_sniper", Vector(1999.954834, 2892.554688, 28.031208), Angle())
		GAMEMODE:CreatePickupEntity("ammo_556", Vector(2001.498413, 2931.163818, 28.031250), Angle())
		GAMEMODE:CreatePickupEntity("ammo_556", Vector(2001.498413, 2961.163818, 28.031250), Angle())
		GAMEMODE:CreatePickupEntity("ammo_556", Vector(2001.498413, 2991.163818, 28.031250), Angle())
		GAMEMODE:CreatePickupEntity("ammo_556", Vector(2001.498413, 3021.163818, 28.031250), Angle())

	end
	
	if GetConVar("hl1_coop_sv_skill"):GetInt() == 1 or GetConVar("hl1_coop_sv_skill"):GetInt() == 4 then
		GAMEMODE:CreatePickupEntity("ammo_buckshot", Vector(2038.501343, 2911.543213, 28.031250), Angle(0, 180, 0))
		GAMEMODE:CreatePickupEntity("ammo_buckshot", Vector(2109.492432, 2912.997314, 28.031250), Angle())
		GAMEMODE:CreatePickupEntity("ammo_mp5clip", Vector(2037.880737, 2952.524658, 28.031250), Angle(0, 180, 0))
		GAMEMODE:CreatePickupEntity("ammo_mp5clip", Vector(2038.416138, 3010.031982, 28.031250), Angle(0, 180, 0))
		GAMEMODE:CreatePickupEntity("ammo_mp5clip", Vector(2108.855469, 2942.477295, 28.031250), Angle())
	end
	if GetConVar("hl1_coop_sv_skill"):GetInt() != 3 then
		GAMEMODE:CreatePickupEntity("ammo_buckshot", Vector(2038.919922, 2867.411377, 28.031250), Angle(0, 180, 0))
		GAMEMODE:CreatePickupEntity("ammo_mp5clip", Vector(2109.047852, 2966.356201, 28.031250), Angle())
		GAMEMODE:CreatePickupEntity("ammo_mp5clip", Vector(2109.248535, 3001.188721, 28.031250), Angle())
	end
	GAMEMODE:CreatePickupEntity("ammo_buckshot", Vector(2109.985596, 2865.400391, 28.031250), Angle())
	GAMEMODE:CreatePickupEntity("ammo_mp5clip", Vector(2038.165039, 2978.855713, 28.031250), Angle(0, 180, 0))

	if GetConVar("hl1_coop_sv_skill"):GetInt() == 1 or GetConVar("hl1_coop_sv_skill"):GetInt() == 4 then
		GAMEMODE:CreateWeaponEntity("weapon_tripmine", Vector(2191.555420, 2369.812744, 76.422218), Angle(0, 0, 0))
	end
	GAMEMODE:CreateWeaponEntity("weapon_tripmine", Vector(2191.555420, 2349.812744, 76.422218), Angle(0, 0, 0))
	if GetConVar("hl1_coop_sv_skill"):GetInt() != 3 then
		GAMEMODE:CreateWeaponEntity("weapon_tripmine", Vector(2191.555420, 2329.812744, 76.422218), Angle(0, 0, 0))
	end
	if GetConVar("hl1_coop_sv_skill"):GetInt() == 1 or GetConVar("hl1_coop_sv_skill"):GetInt() == 4 then
		GAMEMODE:CreateWeaponEntity("weapon_handgrenade", Vector(2171.555420, 2369.812744, 76.422218), Angle(0, 0, 0))
	end
	GAMEMODE:CreateWeaponEntity("weapon_handgrenade", Vector(2171.555420, 2349.812744, 76.422218), Angle(0, 0, 0))
	if GetConVar("hl1_coop_sv_skill"):GetInt() != 3 then
		GAMEMODE:CreateWeaponEntity("weapon_handgrenade", Vector(2171.555420, 2329.812744, 76.422218), Angle(0, 0, 0))
	end

	if GetConVar("hl1_coop_sv_skill"):GetInt() == 1 or GetConVar("hl1_coop_sv_skill"):GetInt() == 4 then
		GAMEMODE:CreateWeaponEntity("weapon_minigun", Vector(2259.563232, 1942.734619, 64.523567), Angle(0, 90, 0))
		GAMEMODE:CreatePickupEntity("ammo_minigun", Vector(2197.933838, 1979.283447, 28.031250), Angle(0, 90, 0))
		GAMEMODE:CreatePickupEntity("ammo_minigun", Vector(2156.512451, 1977.859009, 28.031250), Angle(0, 90, 0))
	end

	--/ Offices
	if GetConVar("hl1_coop_sv_skill"):GetInt() == 3 or GetConVar("hl1_coop_sv_skill"):GetInt() == 4 then
		GAMEMODE:CreateWeaponEntity("weapon_357", Vector(2995.878906, 1444.335449, 144.031250), Angle())
		GAMEMODE:CreatePickupEntity("ammo_357", Vector(2975.295654, 1447.925171, 144.031250), Angle())
		GAMEMODE:CreatePickupEntity("ammo_357", Vector(2984.549072, 1462.781250, 108.031250), Angle(0, 45, 0))
	else
		GAMEMODE:CreateWeaponEntity("weapon_glock", Vector(2995.878906, 1444.335449, 144.031250), Angle())
		GAMEMODE:CreatePickupEntity("ammo_9mmclip", Vector(2975.295654, 1447.925171, 144.031250), Angle())
		GAMEMODE:CreatePickupEntity("ammo_9mmclip", Vector(2984.549072, 1462.781250, 108.031250), Angle(0, 45, 0))
	end

	if GetConVar("hl1_coop_sv_skill"):GetInt() != 3 then
		GAMEMODE:CreateWeaponEntity("weapon_tripmine", Vector(2282.281738, 1317.875732, 144.031250), Angle(0, -90, 0))
	end
	GAMEMODE:CreateWeaponEntity("weapon_tripmine", Vector(2277.151611, 1284.741333, 108.031250), Angle(0, -90, 0))
	if GetConVar("hl1_coop_sv_skill"):GetInt() == 1 or GetConVar("hl1_coop_sv_skill"):GetInt() == 4 then
		GAMEMODE:CreateWeaponEntity("weapon_tripmine", Vector(2307.269775, 1267.123901, 108.031250), Angle(0, -90, 0))
	end

	GAMEMODE:CreateWeaponEntity("weapon_handgrenade", Vector(2425.617188, 1316.552979, 144.031250), Angle())
	GAMEMODE:CreatePickupEntity("ammo_mp5grenades", Vector(2404.257080, 1315.488403, 144.031250), Angle())

	if GetConVar("hl1_coop_sv_skill"):GetInt() == 3 or GetConVar("hl1_coop_sv_skill"):GetInt() == 4 then
		GAMEMODE:CreateWeaponEntity("weapon_357", Vector(2542.707275, 1313.333862, 144.031250), Angle())
		GAMEMODE:CreatePickupEntity("ammo_357", Vector(2527.514893, 1320.154907, 144.031250), Angle())
		GAMEMODE:CreatePickupEntity("ammo_357", Vector(2550.270752, 1295.999023, 108.031250), Angle())
	else
		GAMEMODE:CreateWeaponEntity("weapon_glock", Vector(2542.707275, 1313.333862, 144.031250), Angle())
		GAMEMODE:CreatePickupEntity("ammo_9mmclip", Vector(2527.514893, 1320.154907, 144.031250), Angle())
		GAMEMODE:CreatePickupEntity("ammo_9mmclip", Vector(2550.270752, 1295.999023, 108.031250), Angle())
	end

	GAMEMODE:CreatePickupEntity("item_healthkit", Vector(2315.772461, 1457.659424, 108.031250), Angle())
	GAMEMODE:CreatePickupEntity("item_healthkit", Vector(2280.340332, 1519.968750, 144.031250), Angle())

	GAMEMODE:CreatePickupEntity("ammo_gaussclip", Vector(2433.122803, 1497.718750, 90.031250), Angle())
	GAMEMODE:CreatePickupEntity("item_battery", Vector(2417.305176, 1508.720947, 144.584259), Angle())
	GAMEMODE:CreatePickupEntity("item_battery", Vector(2400.287354, 1509.717773, 144.031250), Angle())

	if GetConVar("hl1_coop_sv_skill"):GetInt() == 1 or GetConVar("hl1_coop_sv_skill"):GetInt() == 4 then
		GAMEMODE:CreatePickupEntity("ammo_buckshot", Vector(2561.412842, 1493.967773, 108.031250), Angle(0, -90, 0))
	end
	GAMEMODE:CreatePickupEntity("ammo_buckshot", Vector(2549.531738, 1512.920166, 144.031250), Angle(0, -90, 0))
	if GetConVar("hl1_coop_sv_skill"):GetInt() != 3 then
		GAMEMODE:CreatePickupEntity("ammo_buckshot", Vector(2525.281738, 1513.138184, 144.031250), Angle(0, -90, 0))
	end
	if GetConVar("hl1_coop_sv_skill"):GetInt() == 3 or GetConVar("hl1_coop_sv_skill"):GetInt() == 4 then
		GAMEMODE:CreateWeaponEntity("weapon_doublebarrel", Vector(2562.031250, 1462.267700, 108.031250), Angle(0, 0, 0))
	else
		GAMEMODE:CreateWeaponEntity("weapon_shotgun", Vector(2542.031250, 1462.267700, 108.031250), Angle(0, 0, 0))
	end

	GAMEMODE:CreatePickupEntity("ammo_gaussclip", Vector(2416.031250, 1039.509644, 108.031250), Angle())
	GAMEMODE:CreatePickupEntity("weapon_satchel", Vector(2420.283691, 880.420959, 133.031250), Angle())
	GAMEMODE:CreatePickupEntity("item_battery", Vector(3023.968750, 976.031250, 108.031250), Angle())
	GAMEMODE:CreateWeaponEntity("weapon_357", Vector(3023.968750, 848.031250, 108.031250), Angle())
	GAMEMODE:CreatePickupEntity("ammo_357", Vector(3018.651855, 879.887329, 133.031250), Angle())
	GAMEMODE:CreatePickupEntity("ammo_357", Vector(2971.009277, 853.705200, 108.031250), Angle())

	if GetConVar("hl1_coop_sv_skill"):GetInt() == 3 or GetConVar("hl1_coop_sv_skill"):GetInt() == 4 then
		GAMEMODE:CreateWeaponEntity("weapon_doublebarrel", Vector(2996.727539, 1156.074707, 131.885742), Angle())
	else
		GAMEMODE:CreateWeaponEntity("weapon_shotgun", Vector(2996.727539, 1156.074707, 131.885742), Angle())
	end
	GAMEMODE:CreatePickupEntity("ammo_buckshot", Vector(3039.951904, 1180.031250, 92.031250), Angle(0, 90, 0))
	GAMEMODE:CreateWeaponEntity("weapon_satchel", Vector(3212.967529, 800.031250, 276.031250), Angle(0, -90, 0))

	GAMEMODE:CreatePickupEntity("ammo_mp5grenades", Vector(2337.202881, 1039.819458, 144.031250), Angle())
	GAMEMODE:CreatePickupEntity("ammo_rpgclip", Vector(2268.253418, 1060.127686, 108.031250), Angle())
	if GetConVar("hl1_coop_sv_skill"):GetInt() == 4 then
		GAMEMODE:CreateWeaponEntity("weapon_m16", Vector(2295.871094, 1036.879761, 144.031250), Angle())
	else
		GAMEMODE:CreateWeaponEntity("weapon_mp5", Vector(2295.871094, 1036.879761, 144.031250), Angle())
	end
	if GetConVar("hl1_coop_sv_skill"):GetInt() != 3 then
		GAMEMODE:CreatePickupEntity("ammo_9mmbox", Vector(2364.446777, 1037.665283, 108.031250), Angle())
	end

	if GetConVar("hl1_coop_sv_skill"):GetInt() == 3 or GetConVar("hl1_coop_sv_skill"):GetInt() == 4 then
		GAMEMODE:CreateWeaponEntity("weapon_357", Vector(2197.501953, 1132.094604, 108.031250), Angle())
	else
		GAMEMODE:CreateWeaponEntity("weapon_glock", Vector(2197.501953, 1132.094604, 108.031250), Angle())
	end

	if GetConVar("hl1_coop_sv_skill"):GetInt() == 1 or GetConVar("hl1_coop_sv_skill"):GetInt() == 4 then
		-- Bustin' makes me feel good.
		GAMEMODE:CreateWeaponEntity("weapon_egon", Vector(2512.255127, 1108.225464, 172.031250), Angle(0, 90, 0))
	end

	GAMEMODE:CreateWeaponEntity("weapon_crossbow", Vector(2164.743896, 1872.764648, 332.031250), Angle(0, 45, 0))
	GAMEMODE:CreatePickupEntity("ammo_crossbow", Vector(2214.178955, 1875.013916, 332.031250), Angle())
	GAMEMODE:CreatePickupEntity("ammo_crossbow", Vector(2251.127197, 1875.130371, 332.031250), Angle())

	GAMEMODE:CreateWeaponEntity("weapon_handgrenade", Vector(2788.205811, 1882.675903, 332.031250), Angle())
	GAMEMODE:CreatePickupEntity("weapon_satchel", Vector(2816.565186, 1883.229248, 332.031250), Angle())
	GAMEMODE:CreatePickupEntity("weapon_tripmine", Vector(2846.931396, 1883.045166, 332.031250), Angle())

	--/ Outside Abandoned Offices
	GAMEMODE:CreatePickupEntity("ammo_9mmbox", Vector(4646.136719, 4118.850098, 28.031250), Angle())
	if GetConVar("hl1_coop_sv_skill"):GetInt() == 4 then
		GAMEMODE:CreateWeaponEntity("weapon_m16", Vector(4653.636719, 4153.156250, 64.031250), Angle(0, 90, 0))
	else
		GAMEMODE:CreateWeaponEntity("weapon_mp5", Vector(4653.636719, 4153.156250, 64.031250), Angle())
	end
	if GetConVar("hl1_coop_sv_skill"):GetInt() == 3 or GetConVar("hl1_coop_sv_skill"):GetInt() == 4 then
		GAMEMODE:CreateWeaponEntity("weapon_doublebarrel", Vector(4650.338379, 4130.875977, 64.031250), Angle())
	else
		GAMEMODE:CreateWeaponEntity("weapon_shotgun", Vector(4680.338379, 4130.875977, 64.031250), Angle())
	end
	GAMEMODE:CreatePickupEntity("ammo_buckshot", Vector(4597.372070, 4173.748535, 64.031250), Angle(0, 90, 0))
	GAMEMODE:CreatePickupEntity("ammo_buckshot", Vector(4617.163086, 4172.647461, 64.031250), Angle(0, 90, 0))
	GAMEMODE:CreatePickupEntity("ammo_mp5clip", Vector(4635.342285, 4173.589844, 64.031250), Angle(0, 90, 0))
	GAMEMODE:CreatePickupEntity("ammo_mp5clip", Vector(4652.871094, 4174.498535, 64.031250), Angle(0, 90, 0))
	GAMEMODE:CreatePickupEntity("ammo_mp5clip", Vector(4643.332031, 4174.003418, 64.031250), Angle(0, 90, 0))

	GAMEMODE:CreatePickupEntity("item_battery", Vector(3093.693848, 4776.099609, 228.031250), Angle())

	GAMEMODE:CreateWeaponEntity("weapon_ak47", Vector(4693.933105, 4185.435547, 140.031250), Angle())
	GAMEMODE:CreatePickupEntity("ammo_mp5clip", Vector(4574.579590, 4289.540039, 140.031250), Angle())

	--/ Abandoned Offices
	GAMEMODE:CreatePickupEntity("item_healthkit", Vector(2354.899170, 4231.578613, 60.031250), Angle())

	GAMEMODE:CreateWeaponEntity("weapon_snark", Vector(2188.015137, 4032.441162, 60.031250), Angle())

	GAMEMODE:CreateWeaponEntity("weapon_snark", Vector(2070.329590, 5017.151367, 60.031250), Angle())

	GAMEMODE:CreatePickupEntity("ammo_9mmbox", Vector(2048.964600, 4774.357422, 268.031250), Angle())
	GAMEMODE:CreatePickupEntity("ammo_buckshot", Vector(2050.059570, 4724.086914, 268.031250), Angle())
	GAMEMODE:CreateWeaponEntity("weapon_handgrenade", Vector(2051.350098, 4664.859375, 268.031250), Angle())
	GAMEMODE:CreateWeaponEntity("weapon_snark", Vector(2100.479492, 4705.812500, 268.031250), Angle())

	GAMEMODE:CreatePickupEntity("item_battery", Vector(2078.235352, 4387.504883, 268.019379), Angle())
	GAMEMODE:CreatePickupEntity("item_battery", Vector(2135.952637, 4374.155273, 268.019379), Angle())

	GAMEMODE:CreateWeaponEntity("weapon_snark", Vector(2863.900146, 4701.345215, 304.507965), Angle())

	GAMEMODE:CreateWeaponEntity("weapon_snark", Vector(2845.193604, 4138.449219, 304.507355), Angle())
	GAMEMODE:CreatePickupEntity("ammo_gaussclip", Vector(2782.050293, 4173.498535, 268.031250), Angle(0, 90, 0))

	--/ Outside Church
	GAMEMODE:CreatePickupEntity("ammo_mp5clip", Vector(6737.968750, 154.523392, 244.031250), Angle())

	GAMEMODE:CreateWeaponEntity("weapon_357", Vector(6156.016113, -419.582733, 220.031250), Angle())
	GAMEMODE:CreatePickupEntity("ammo_357", Vector(6126.568848, -419.602997, 220.031250), Angle())

	GAMEMODE:CreatePickupEntity("ammo_rpgclip", Vector(5769.884277, -591.905212, 248.031250), Angle())

	--/ Graves
	GAMEMODE:CreateWeaponEntity("weapon_handgrenade", Vector(4372.219238, 375.280365, 160.031250), Angle())
	GAMEMODE:CreateWeaponEntity("weapon_rpg", Vector(3611.076416, 363.443665, 160.031250), Angle(0, 90, 0))
	GAMEMODE:CreateWeaponEntity("weapon_gauss", Vector(4392.057129, 7.666440, 160.031250), Angle(0, 90, 0))
	GAMEMODE:CreateWeaponEntity("weapon_357", Vector(3604.528809, 8.450029, 160.440247), Angle(0, 90, 0))
	
	--/ Behind Church
	GAMEMODE:CreatePickupEntity("ammo_357", Vector(1985.475464, 374.821289, 220.031250), Angle())
	GAMEMODE:CreatePickupEntity("ammo_buckshot", Vector(1985.447632, 307.230438, 220.031250), Angle())
	GAMEMODE:CreatePickupEntity("ammo_rpgclip", Vector(1985.426025, 256.865601, 220.031250), Angle())
	GAMEMODE:CreatePickupEntity("ammo_9mmbox", Vector(1985.403809, 203.969757, 220.031250), Angle())
	GAMEMODE:CreatePickupEntity("ammo_gaussclip", Vector(1985.384399, 157.495728, 220.031250), Angle())
	GAMEMODE:CreatePickupEntity("ammo_mp5grenades", Vector(1985.361328, 103.215904, 220.031250), Angle())
	GAMEMODE:CreatePickupEntity("ammo_crossbow", Vector(1985.335083, 41.361958, 220.031250), Angle())

	--/ Church
	GAMEMODE:CreatePickupEntity("item_healthkit", Vector(2181.308838, 192.065918, 284.031250), Angle())
	GAMEMODE:CreatePickupEntity("item_healthkit", Vector(2144.446777, 221.611206, 244.031250), Angle())
	GAMEMODE:CreatePickupEntity("item_healthkit", Vector(2144.446777, 167.611206, 244.031250), Angle())
	GAMEMODE:CreatePickupEntity("item_healthkit", Vector(2104.446777, 221.611206, 244.031250), Angle())
	GAMEMODE:CreatePickupEntity("item_healthkit", Vector(2104.034180, 167.246948, 244.031250), Angle())

	-- Balcony
	GAMEMODE:CreateWeaponEntity("weapon_crossbow", Vector(3056.124268, 192.301758, 364.031250), Angle(0, 90, 0))
	GAMEMODE:CreatePickupEntity("ammo_crossbow", Vector(3056.239258, 95.482040, 364.031250), Angle())
	GAMEMODE:CreatePickupEntity("ammo_crossbow", Vector(3055.089355, 288.454102, 364.031250), Angle())

	-- Pews
	GAMEMODE:CreatePickupEntity("ammo_buckshot", Vector(2937.286865, 283.959259, 236.031250), Angle(0, 180, 0))
	GAMEMODE:CreateWeaponEntity("weapon_rpg", Vector(2937.286865, 350.959259, 236.031250), Angle(0, 90, 0))
	GAMEMODE:CreatePickupEntity("ammo_crossbow", Vector(2935.254639, 69.584511, 236.031250), Angle(0, 90, 0))
	GAMEMODE:CreatePickupEntity("item_battery", Vector(2837.708740, 103.367867, 236.031250), Angle(0, 0, 0))
	GAMEMODE:CreatePickupEntity("item_battery", Vector(2835.986084, -1.011921, 236.031250), Angle(0, 0, 0))
	GAMEMODE:CreatePickupEntity("item_battery", Vector(2838.162109, 387.280029, 236.031250), Angle(0, 0, 0))
	GAMEMODE:CreatePickupEntity("ammo_rpgclip", Vector(2839.833496, 286.113922, 236.031250), Angle(0, 0, 0))
	GAMEMODE:CreatePickupEntity("ammo_gaussclip", Vector(2742.906494, 338.420715, 236.031250), Angle(0, 0, 0))
	GAMEMODE:CreateWeaponEntity("weapon_handgrenade", Vector(2747.517090, 107.967819, 252.031250), Angle(0, 0, 0))
	if GetConVar("hl1_coop_sv_skill"):GetInt() == 3 or GetConVar("hl1_coop_sv_skill"):GetInt() == 4 then
		GAMEMODE:CreateWeaponEntity("weapon_357", Vector(2647.683838, 81.246803, 236.031250), Angle(0, 90, 0))
	else
		GAMEMODE:CreateWeaponEntity("weapon_glock", Vector(2647.683838, 81.246803, 236.031250), Angle(0, 90, 0))
	end
	GAMEMODE:CreatePickupEntity("ammo_9mmclip", Vector(2647.986328, 17.011812, 236.031250), Angle(0, 90, 0))
	GAMEMODE:CreateWeaponEntity("weapon_357", Vector(2646.861084, 314.158966, 236.031250), Angle(0, 90, 0))
	GAMEMODE:CreatePickupEntity("ammo_357", Vector(2646.134033, 369.987488, 236.031250), Angle(0, 180, 0))
	GAMEMODE:CreatePickupEntity("ammo_357", Vector(2551.246338, 370.677643, 236.031250), Angle(0, 180, 0))	
	if GetConVar("hl1_coop_sv_skill"):GetInt() == 3 or GetConVar("hl1_coop_sv_skill"):GetInt() == 4 then
		GAMEMODE:CreateWeaponEntity("weapon_doublebarrel", Vector(2551.503906, 311.859375, 236.031250), Angle(0, 90, 0))
	else
		GAMEMODE:CreateWeaponEntity("weapon_shotgun", Vector(2551.503906, 311.859375, 236.031250), Angle(0, 90, 0))
	end
	GAMEMODE:CreateWeaponEntity("weapon_gauss", Vector(2556.435303, 49.061440, 236.031250), Angle(0, 90, 0))
	GAMEMODE:CreatePickupEntity("ammo_mp5clip", Vector(2452.717041, -2.261291, 236.031250), Angle(0, 90, 0))
	GAMEMODE:CreatePickupEntity("ammo_mp5grenades", Vector(2455.796143, 45.281487, 236.031250), Angle(0, 0, 0))
	if GetConVar("hl1_coop_sv_skill"):GetInt() == 4 then
		GAMEMODE:CreateWeaponEntity("weapon_m16", Vector(2454.332275, 87.418251, 236.031250), Angle(0, 0, 0))
	else
		GAMEMODE:CreateWeaponEntity("weapon_mp5", Vector(2454.332275, 97.418251, 236.031250), Angle(0, 0, 0))
	end
	GAMEMODE:CreateWeaponEntity("weapon_doublebarrel", Vector(2459.400391, 344.261688, 236.031250), Angle(0, 90, 0))
	GAMEMODE:CreateWeaponEntity("weapon_satchel", Vector(2359.002197, 378.936096, 236.031250), Angle(0, 0, 0))
	GAMEMODE:CreateWeaponEntity("weapon_satchel", Vector(2358.750732, 337.489258, 236.031250), Angle(0, 0, 0))
	GAMEMODE:CreateWeaponEntity("weapon_satchel", Vector(2358.426758, 284.043488, 236.031250), Angle(0, 0, 0))
	GAMEMODE:CreateWeaponEntity("weapon_tripmine", Vector(2356.437500, 90.721573, 236.031250), Angle(0, 180, 0))
	GAMEMODE:CreateWeaponEntity("weapon_tripmine", Vector(2356.749023, 42.970894, 236.031250), Angle(0, 180, 0))
	GAMEMODE:CreateWeaponEntity("weapon_tripmine", Vector(2357.073730, -6.861578, 236.030334), Angle(0, 180, 0))

	--/ Dumpsters
	GAMEMODE:CreatePickupEntity("ammo_9mmclip", Vector(2208.689453, 1351.719238, 32.031250), Angle())
	GAMEMODE:CreatePickupEntity("ammo_357", Vector(2207.577148, 1439.916504, 32.031250), Angle()) -- move this back so you can't grab it through the dumpster wall
	GAMEMODE:CreatePickupEntity("item_battery", Vector(4640.435059, 4055.653320, 32.031250), Angle())

	---- HERESY
	GAMEMODE:CreateWeaponEntity("weapon_gauss", Vector(3164.729492, 10696.791016, -6755.968750), Angle())
	GAMEMODE:CreatePickupEntity("ammo_gaussclip", Vector(3104.729492, 10696.791016, -6755.968750), Angle(0, 90, 0))
	GAMEMODE:CreatePickupEntity("ammo_gaussclip", Vector(3050.729492, 10696.791016, -6755.968750), Angle(0, 90, 0))
	GAMEMODE:CreatePickupEntity("ammo_gaussclip", Vector(3200.729492, 10696.791016, -6755.968750), Angle(0, 90, 0))
	GAMEMODE:CreatePickupEntity("ammo_gaussclip", Vector(3230.729492, 10696.791016, -6755.968750), Angle(0, 90, 0))

	GAMEMODE:CreateWeaponEntity("weapon_rpg", Vector(3629.509277, 10695.869141, -6755.968750), Angle())
	GAMEMODE:CreatePickupEntity("ammo_rpgclip", Vector(3574.509277, 10695.869141, -6755.968750), Angle())
	GAMEMODE:CreatePickupEntity("ammo_rpgclip", Vector(3559.509277, 10695.869141, -6755.968750), Angle())
	GAMEMODE:CreatePickupEntity("ammo_rpgclip", Vector(3544.509277, 10695.869141, -6755.968750), Angle())
	GAMEMODE:CreatePickupEntity("ammo_rpgclip", Vector(3679.509277, 10695.869141, -6755.968750), Angle())
	GAMEMODE:CreatePickupEntity("ammo_rpgclip", Vector(3690.509277, 10695.869141, -6755.968750), Angle())

	GAMEMODE:CreateWeaponEntity("weapon_crossbow", Vector(3620.232910, 9784.808594, -6755.968750), Angle())
	GAMEMODE:CreatePickupEntity("ammo_crossbow", Vector(3650.232910, 9784.808594, -6755.968750), Angle())
	GAMEMODE:CreatePickupEntity("ammo_crossbow", Vector(3670.232910, 9784.808594, -6755.968750), Angle())
	GAMEMODE:CreatePickupEntity("ammo_crossbow", Vector(3600.232910, 9784.808594, -6755.968750), Angle())
	GAMEMODE:CreatePickupEntity("ammo_crossbow", Vector(3580.232910, 9784.808594, -6755.968750), Angle())
	GAMEMODE:CreatePickupEntity("ammo_crossbow", Vector(3560.232910, 9784.808594, -6755.968750), Angle())

	GAMEMODE:CreateWeaponEntity("weapon_m249", Vector(3153.071289, 9784.366211, -6755.968750), Angle())
	GAMEMODE:CreatePickupEntity("ammo_556", Vector(3103.071289, 9784.366211, -6755.968750), Angle(0, 90, 0))
	GAMEMODE:CreatePickupEntity("ammo_556", Vector(3053.071289, 9784.366211, -6755.968750), Angle(0, 90, 0))
	GAMEMODE:CreatePickupEntity("ammo_556", Vector(3203.071289, 9784.366211, -6755.968750), Angle(0, 90, 0))
	GAMEMODE:CreatePickupEntity("ammo_556", Vector(3238.071289, 9784.366211, -6755.968750), Angle(0, 90, 0))

	--/ Secret Area	
	GAMEMODE:CreatePickupEntity("item_battery", Vector(4223.317383, 1055.371338, -404.468750), Angle())
	GAMEMODE:CreatePickupEntity("item_battery", Vector(4032.678711, 1376.115845, -404.468750), Angle())
	GAMEMODE:CreatePickupEntity("item_battery", Vector(4223.123535, 1695.740723, -404.468750), Angle())
	GAMEMODE:CreatePickupEntity("item_battery", Vector(4032.800049, 2015.744629, -404.468750), Angle())

	GAMEMODE:CreateWeaponEntity("weapon_handgrenade", Vector(3437.026367, 2434.932861, -383.968750), Angle())
	GAMEMODE:CreateWeaponEntity("weapon_hornetgun", Vector(2184.070557, 2433.480225, -335.968750), Angle())

end

function MAP:OnPlayerSpawnPre(ply)
end

function MAP:OnPlayerSpawn(ply)
	if GAMEMODE:GetRound() > 0 then
		ply:Give("weapon_glock")
	end
	ply:SetGravity(1)
	if ply.FirstSpawn then
		local timerId = "ObjectiveHint_"..ply:UserID()
		timer.Create(timerId, 10, 0, function()
			if IsValid(ply) and ply.canTakeDamage then
				GAMEMODE:ShowObjective(ply)
				timer.Stop(timerId)
			end
		end)
	else
		GAMEMODE:ShowObjective(ply)
	end
end

function GM:OnPlayerTeleportToCheckpoint(ply)
	ply:SetGravity(1)
	ply:KillNPCsInRadius(96)
end

function GM:OnSuitPickup(ply)
	if !cvars.Bool("hl1_coop_sv_custommodels") then
		ply:SetModel(DEFAULT_PLAYERMODEL_PATH)
	end
end

function MAP:OnMapRestart()
	GAMEMODE:SetObjective(0, true)
	for k, v in pairs(player.GetAll()) do
		v:SetFuel(0)
	end
	NO_WAVE_MUSIC = false
end

-- function MAP:GetRestartFromCheckpointPos(num)
	-- return Vector(-6501,5759,-666), Angle(0, 180, 0)
-- end

function MAP:OnRestartFromCheckpoint(num)
	if num == 1 then
		for k, v in pairs(ents.FindByClass("hl1_collectable_barrel")) do
			v.Fuel = 0
		end
		for k, v in pairs(ents.FindByClass("hl1_trigger_func")) do
			if v.Fuel then
				v:Remove()
			end
		end
		if IsValid(generatorEnt) then
			generatorEnt:SetFuel(generatorEnt:GetMaxFuel())
			generatorEnt.Enabled = true
			generatorEnt:StartSound()
		end
		if IsValid(locatorEnt) then
			locatorEnt:On()
			locatorEnt:SetPortalTime(self.PortalPrepareTime)
		end
		NO_WAVE_MUSIC = true

		if GetConVar("hl1_coop_sv_bhlcie_lilyhalloween_music"):GetInt() == 1 then
			local PanelMusic = math.random(1,3)
			if PanelMusic == 1 then
				GAMEMODE:PlayGlobalMusic("FAITH.Astaroth")
			elseif PanelMusic == 2 then
				GAMEMODE:PlayGlobalMusic("FAITH.Malphas")
			else
				GAMEMODE:PlayGlobalMusic("FAITH.Miriam")
			end
		else
			local PanelMusic = math.random(1,7)
			if PanelMusic == 1 then
				GAMEMODE:PlayGlobalMusic("Mash.Brain")
			elseif PanelMusic == 2 then
				GAMEMODE:PlayGlobalMusic("Mash.Destiny")
			elseif PanelMusic == 3 then
				GAMEMODE:PlayGlobalMusic("Mash.Orchestra")
			elseif PanelMusic == 4 then
				GAMEMODE:PlayGlobalMusic("Mash.Fragments")
			elseif PanelMusic == 5 then
				GAMEMODE:PlayGlobalMusic("Mash.Snakcombat")
			elseif PanelMusic == 6 then
				GAMEMODE:PlayGlobalMusic("Mash.Gertrude")
			else
				GAMEMODE:PlayGlobalMusic("Mash.Avatar")
			end
		end

		shepherd = ents.Create("npc_bhlcie_shepherd")
		if IsValid(shepherd) then
			shepherd:SetPos(Vector(2313.034180, 192.687256, 256.031250))
			shepherd:SetAngles(Angle(0,0,0))
			shepherd:Spawn()
		end

	end
	for k, v in pairs(player.GetAll()) do
		v:EquipSuit()
	end
end

-- function MAP:OnGameEnd()
	-- local endmusic = math.random(1,6)
	-- if endmusic == 1 then
		-- GAMEMODE:PlayGlobalMusic("PizzaTower.Smackdown")
	-- elseif endmusic == 2 then
		-- GAMEMODE:PlayGlobalMusic("PizzaTower.Hairline")
	-- elseif endmusic == 3 then
		-- GAMEMODE:PlayGlobalMusic("PizzaTower.Pieing")
	-- elseif endmusic == 4 then
		-- GAMEMODE:PlayGlobalMusic("PizzaTower.Deluxe")
	-- elseif endmusic == 5 then
		-- GAMEMODE:PlayGlobalMusic("PizzaTower.Italian")
	-- else
		-- GAMEMODE:PlayGlobalMusic("PizzaTower.Toppings")
	-- end	
-- end

end