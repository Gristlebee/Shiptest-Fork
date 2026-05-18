/mob/living/simple_animal/hostile/human/ramzi/planted
	name = "Seeded Ramzi Clique"

/mob/living/simple_animal/hostile/human/ramzi/planted/Initialize(mapload)
	. = ..()
	//blend(src, /obj/structure/spacevine, mode = BLEND_INSET_OVERLAY)
	blend_icon(src, 'icons/effects/spacevines.dmi', "light1", mode = BLEND_INSET_OVERLAY)

