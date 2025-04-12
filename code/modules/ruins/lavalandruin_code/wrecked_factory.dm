/mob/living/simple_animal/hostile/human/nanotrasen/elite/factory
	name = "Manager"
	desc = "A twitching mess clad in both the red of Vigilitas Interstellar anda blanket of fresh blood. Their eyes dart in addled paranoia, their shaking hands grasped tight on their waiting for the next target that could come from any direction."
	weapon_drop_chance = 0
	var/stim = FALSE
	retreat_distance = 3
	minimum_distance = 5

/obj/effect/mob_spawn/human/corpse/vigilitas_elite/factory
	name = "Factory Manager"
	id_job = "Vigilitas Assault Force"
	outfit = /datum/outfit/vigilitas/elite/factory

/datum/outfit/vigilitas/elite/factory
	backpack_contents = (/obj/item/reagent_containers/hypospray/medipen/survival = 3, /obj/item/reagent_containers/hypospray/medipen/mammoth)

/mob/living/simple_animal/hostile/human/nanotrasen/elite/factory/Life()
	. = ..()
	if(health <= maxHealth/2 && !stim)
		inject_stim()
	if(stim)
		shake_animation()

/mob/living/simple_animal/hostile/human/nanotrasen/elite/factory/attacked_by(obj/item/I, mob/living/user)
	. = ..()
	if(health <= maxHealth/2 && !stim)
		inject_stim()

// I NEED CRACK
/mob/living/simple_animal/hostile/human/nanotrasen/elite/factory/proc/inject_stim()
	if(stim)
		return FALSE
	visible_message(span_warning("\The [src] suddenly jabs a mammoth injector into her side!"))
	new /obj/item/reagent_containers/hypospray/medipen/spent/mammoth(loc)
	say("GRAAAAAAAAAGH!!")
	stim = TRUE
	maxHealth = 150
	fully_heal()
	retreat_distance = 0
	minimum_distance = 1
	shoot_point_blank = TRUE
	move_to_delay = 2.5
	shake_animation()


