/mob/living/simple_animal/hostile/human/ramzi/planted
	name = "Seeded Ramzi Clique"

/mob/living/simple_animal/hostile/human/ramzi/planted/Initialize(mapload)
	. = ..()
	lazy_blend(src, /obj/structure/spacevine, mode = BLEND_INSET_OVERLAY)

/proc/lazy_blend(atom/target, thing, new_layer, mode = BLEND_DEFAULT)
	var/atom/overlayed = new thing
	overlayed.blend_mode = mode
	if(new_layer)
		overlayed.layer = new_layer
	target.add_overlay(overlayed)
	qdel(overlayed)


