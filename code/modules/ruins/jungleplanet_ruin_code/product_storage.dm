/mob/living/simple_animal/hostile/human/ramzi/planted
	name = "Seeded Ramzi Clique"

/mob/living/simple_animal/hostile/human/ramzi/planted/Initialize(mapload)
	. = ..()
	var/icon/overlayed = icon('icons/obj/tapes.dmi', "tape_d_mask")
	var/mutable_appearance/thingy = icon2appearance(overlayed)
	thingy.blend_mode = BLEND_INSET_OVERLAY
	// thingy.blend_mode = BLEND_INSET_OVERLAY
	// // thingy.
	// // overlayed.Blend("#fff", ICON_ADD)
	// // overlayed.Blend(icon('icons/obj/tapes.dmi', "tape_d_mask"), ICON_MULTIPLY)
	// add_overlay(thingy)
	// update_appearance()


/mob/living/simple_animal/hostile/human/ramzi/planted/LateInitialize()
	. = ..()
	var/mutable_appearance/mask = get_dynamic_human_appearance(species_path = mob_species, mob_spawn_path = mob_spawner, r_hand = r_hand, l_hand = l_hand, seed = appearance_seed)
	mask.blend_mode = BLEND_INSET_OVERLAY
	add_overlay(mask)
	update_appearance()


