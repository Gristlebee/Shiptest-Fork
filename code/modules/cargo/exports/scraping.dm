/datum/export/landmine
	unit_name = "defused landmines"
	desc = "The Confederated League maintains an active bounty program for the disposal of UXO. Make the frontier a safer place today!"
	cost = 750
	elasticity_coeff = 0.1
	export_types = list(/obj/item/mine/pressure/explosive)

/datum/export/anomaly
	unit_name = "stabilized anomaly core"
	cost = 3000
	elasticity_coeff = 0.1
	export_types = list(/obj/item/assembly/signaler/anomaly)

/datum/export/anomaly/New(...)
	. = ..()
	desc = "[SSmissions.get_researcher_name()] has requested that we [pick(list("procure", "grab", "acquire", "find", "locate"))] \
	anomaly cores for [pick(list("research", "analysis", "technical development", "closer inspection", "some reason"))]."

// Circuit boards, spare parts, etc.

/datum/export/solar/assembly
	cost = 50
	desc = "One solar panel assembly. Green energy, especially towards the inner system."
	unit_name = "solar panel assembly"
	export_types = list(/obj/item/solar_assembly)

/datum/export/solar/tracker_board
	cost = 150
	desc = "One solar tracking circuit. Allows a solar array to work far more efficiently."
	unit_name = "solar tracker board"
	export_types = list(/obj/item/electronics/tracker)

/datum/export/solar/control_board
	cost = 150
	desc = "The master control board for a solar array."
	unit_name = "solar panel control board"
	export_types = list(/obj/item/circuitboard/computer/solar_control)

/datum/export/thruster_parts
	cost = 200
	desc = "Electric, plasma, combustion, whatever. If it makes a shuttle fly, we'll take it."
	unit_name = "engine thruster and heater boards"
	export_types = list(/obj/item/circuitboard/machine/shuttle/engine,
						/obj/item/circuitboard/machine/shuttle/heater,
						/obj/item/circuitboard/machine/shuttle/fire_heater,
						/obj/item/circuitboard/machine/shuttle/smes
						)

/datum/export/water_tank
	cost = 300
	desc = "Potable water is a valuable commodity, especially for fledgling colonies starting out on the Frontier."
	unit_name = "water tanks"
	export_types = list(/obj/structure/reagent_dispensers/watertank)

/datum/export/welding_tank
	cost = 400
	desc = "Welding fuel has been in high demand these past few years with the legions of salvagers and prospectors descending on the remains left behind from the ICW."
	unit_name = "water tanks"
	export_types = list(/obj/structure/reagent_dispensers/fueltank)

/datum/export/vendor_refill
	cost = 200
	desc = "If you find any sealed vending machine refills, we'll take them and make sure they go to a vending machine in need."
	unit_name = "vendor refills"
	export_types = list(/obj/item/vending_refill)
	exclude_types = list(/obj/item/vending_refill/custom) // no money printing for you

/datum/export/tcomms_boards
	cost = 150
	unit_name = "telecomms boards"
	export_types = list(/obj/item/circuitboard/machine/telecomms)

/datum/export/tcomms_parts
	cost = 30
	unit_name = "telecomms subspace parts"
	export_types = list(/obj/item/stock_parts/subspace)

/datum/export/stock_parts
	cost = 20
	unit_name = "tier 2 stock parts"
	desc = "If you have any spare advanced stock parts, we'll take em."
	var/required_rating = 2 // we arent buying basics since you can print those
	export_types = list(/obj/item/stock_parts)
	exclude_types = list(/obj/item/stock_parts/subspace)

/datum/export/stock_parts/get_amount(obj/O)
	. = ..()
	var/obj/item/stock_parts/parts = O
	if(parts.rating != required_rating)
		return 0

/datum/export/stock_parts/t3
	cost = 40
	unit_name = "tier 3 stock parts"
	required_rating = 3

/datum/export/stock_parts/t4
	cost = 100
	unit_name = "bluespace stock parts"
	required_rating = 4

//Computer Tablets and Parts
/datum/export/modular_part
	cost = 15
	desc = "You find it? We want it."
	unit_name = "miscellaneous computer part"
	export_types = list(/obj/item/computer_hardware)

/* if only
/datum/export/stack/cable
	cost = 0.1
	unit_name = "copper wire"
	export_types = list(/obj/item/garnish/wire)
*/
