/obj/item/gun/ballistic/shotgun/musket
	name = "musket"
	desc = "just as the founding solarians intended."
	var/powder_loaded = FALSE
	var/plunged = FALSE
	icon = 'icons/obj/guns/projectile.dmi'
	lefthand_file = 'icons/mob/inhands/weapons/64x_guns_left.dmi'
	righthand_file = 'icons/mob/inhands/weapons/64x_guns_right.dmi'
	mob_overlay_icon = null
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	base_icon_state = "ishotgun"
	icon_state = "ishotgun"
	item_state = "ishotgun"
	bolt_type = BOLT_TYPE_NO_BOLT

	default_ammo_type = /obj/item/ammo_box/magazine/internal/shot/improvised
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/internal/shot/improvised,
	)
	always_chambers = TRUE
	casing_ejector = TRUE
	internal_magazine = TRUE
	doesnt_keep_bullet = TRUE

/obj/item/gun/ballistic/shotgun/musket/can_shoot()
	if(!powder_loaded)
		return FALSE
	if(!plunged)
		return FALSE
	return ..()

// /obj/item/gun/ballistic/shotgun/musket/unique_action(mob/living/user)
// 	return FALSE

/obj/item/gun/ballistic/shotgun/musket/attackby(obj/item/A, mob/user, params)
	. = ..()
	if(istype(A, /obj/item/plunger) && !plunged)
		to_chat(user,span_notice("You start plunging the musket..."))
		if(do_after(user, 5 SECONDS))
			plunged = TRUE
			//rack(user)
	if(istype(A, /obj/item/reagent_containers) && !powder_loaded)
		var/obj/item/reagent_containers/container = A
		to_chat(user,span_notice("You start loading the powder..."))
		if(container.is_drainable())
			if(container.reagents.has_reagent(/datum/reagent/gunpowder,5))
				if(do_after(user, 3 SECONDS))
					powder_loaded = TRUE
					container.reagents.remove_reagent(/datum/reagent/gunpowder,5)

/obj/item/gun/ballistic/shotgun/musket/process_chamber(empty_chamber, from_firing, chamber_next_round, atom/shooter)
	. = ..()
	powder_loaded = FALSE
	plunged = FALSE

