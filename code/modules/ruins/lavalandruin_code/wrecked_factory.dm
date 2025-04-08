/mob/living/simple_animal/hostile/human/nanotrasen/elite/factory
	name = "Manager"
	desc = "A twitching mess clad in the red of Vigilitas Interstellar and covered in fresh blood. Their eyes dart in addled paranoia, their shaking hands grasped tight on their waiting for the next target that could come from any direction."
	weapon_drop_chance = 0
	var/stim = FALSE

/mob/living/simple_animal/hostile/human/nanotrasen/elite/factory/attacked_by(obj/item/I, mob/living/user)
	. = ..()
	if(health <= max_health/2 && !stim)

