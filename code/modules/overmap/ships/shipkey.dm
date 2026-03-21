/obj/item/key/ship
	name = "ship key"
	desc = "A key for locking and unlocking the helm of a ship, comes with a ball chain so it can be worn around the neck. Comes with a cute little shuttle-shaped keychain."
	icon_state = "shipkey"
	var/datum/overmap/ship/controlled/master_ship
	var/static/list/key_colors = list(
		"blue" = "#4646fc",
		"red" = "#fd4b54",
		"salmon" = "#faacac",
		"brown" = "#a36933",
		"green" = "#3dc752",
		"lime" = "#7ffd6e",
		"cyan" = "#00ffdd",
		"purple" = "#8c3cf5",
		"yellow" = "#ffdd44"
	)
	var/random_color = TRUE //if the key uses random coloring (logic stolen from screwdriver.dm)
	slot_flags = ITEM_SLOT_NECK
	var/list/access_list

/obj/item/key/ship/Initialize(mapload, datum/overmap/ship/controlled/master_ship)
	. = ..()
	src.master_ship = master_ship
	master_ship.shipkey = src
	if(random_color) //random colors!
		icon_state = "shipkey_plasticbod"
		var/our_color = pick(key_colors)
		add_atom_colour(key_colors[our_color], FIXED_COLOUR_PRIORITY)
		update_appearance()
	name = "ship key ([master_ship.name])"
	access_list = get_region_accesses(0)
	AddComponent(/datum/component/ntnet_interface)

/obj/item/key/ship/update_overlays()
	. = ..()
	if(!random_color) //icon override
		return
	var/mutable_appearance/base_overlay = mutable_appearance(icon, "shipkey_metalybits")
	base_overlay.appearance_flags = RESET_COLOR
	. += base_overlay

/obj/item/key/ship/Destroy()
	master_ship.shipkey = null
	master_ship = null
	return ..()

/obj/item/key/ship/attack_self(mob/user)
	if(!master_ship || !Adjacent(user))
		return ..()

	master_ship.attempt_key_usage(user, src, src) // hello I am a helm console I promise
	return TRUE

/obj/item/key/ship/afterattack(atom/A, mob/user)
	. = ..()

	// Generate a control packet.
	var/datum/netdata/data = generate_control_packet(A)
	if(!data)
		return
	data.recipient_ids = list(target_interface.hardware_id)

	data.data["data"] = "open"
	data.data["data_secondary"] = "toggle"
	data.passkey = access_list

	ntnet_send(data)

// /obj/item/key/ship/check_ship_access(obj/item/item)
// 	. = ..()


/obj/item/key/ship/proc/generate_control_packet(atom/A)
	var/datum/component/ntnet_interface/target_interface = A.GetComponent(/datum/component/ntnet_interface)

	if(!target_interface)
		return
	return target_interface
