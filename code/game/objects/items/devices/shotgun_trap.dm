/obj/item/shotgun_trap
	name = "shotgun trap"
	desc = "A handmade assembly consisting of a shotgun and a spring loaded trigger mechanism. Dead(ly) simple."
	var/obj/item/ammo_casing/loaded
	var/panel_open = FALSE
	var/caliber = "12ga"

/obj/item/shotgun_trap/Initialize()
	. = ..()
	wires = new /datum/wires/shotgun_trap(src)

/obj/item/shotgun_trap/proc/fire()
	if(!anchored)
		return
	var/target = get_ranged_target_turf(get_turf(src),dir,6)
	loaded.chambered.fire_casing(target,null, null, null, suppressed, ran_zone(BODY_ZONE_CHEST, 50), 0, src,TRUE)

/obj/item/shotgun_trap/attackby(obj/item/I, mob/living/user, params)
	. = ..()
	if(istype(I,/obj/item/ammo_casing))
		var/obj/item/ammo_casing/to_load = I
		if(to_load.caliber == caliber)
		to_load.forceMove(src)
		loaded = load
	if(I.tool_behaviour == TOOL_WRENCH)
		if(do_after(user, 10))
