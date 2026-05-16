/mob/living/simple_animal/hostile/human/ramzi/planted
	name = "Seeded Ramzi Clique"

/mob/living/simple_animal/hostile/human/ramzi/planted/Initialize(mapload)
	. = ..()
	var/icon/overlayed = appearance
	overlayed.Blend("#fff", ICON_ADD)
	overlayed.Blend(icon('icons/obj/tapes.dmi', "tape_d_mask"), ICON_MULTIPLY)
	add_overlay(overlayed)
	update_appearance()

