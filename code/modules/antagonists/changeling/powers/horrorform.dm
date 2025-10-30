/datum/action/changeling/horror
	name = "Horror Form"
	desc = "We shed this pathetic pretense of a form, and take on one more suited for combat for a time. We will be severely weakened afterwards once we revert back to our normal form."
	helptext = "We will be placed in control of a powerful combat form."
	button_icon_state = "last_resort"
	chemical_cost = 20
	dna_cost = -1
	req_human = 1

/datum/action/changeling/lesserform/sting_action(mob/living/carbon/human/user)
	if(!user || user.notransform)
		return FALSE
	to_chat(user, span_warning("Enough of this farce."))
	..()
	user.horrorize()
	return TRUE

/mob/living/carbon/human/horrorize()

	if(notransform)
		return
	notransform = TRUE
	Paralyze(1, ignore_canstun = TRUE)

	for(var/obj/item/W in src)
		dropItemToGround(W)

	regenerate_icons()
	icon = null
	invisibility = INVISIBILITY_MAXIMUM

	for(var/t in get_all_bodyparts())
		qdel(t)

	var/mob/living/simple_animal/hostile/asteroid/horror/new_mob = new /mob/living/simple_animal/hostile/asteroid/horror(src.loc)

	new_mob.key = key
	new_mob.a_intent = INTENT_HARM



	to_chat(new_mob, span_boldnotice("You suddenly feel more... animalistic."))
	. = new_mob
	new_mob.host_body = src

/mob/living/simple_animal/hostile/asteroid/horror
	name = "Horror"
	desc = "A horrific amalgamate of flesh and bones of multiple creatures. They all cry out in unison for one thing. For you to join them."
	response_harm_continuous = "gores"
	response_harm_simple = "gore"
	icon = 'icons/mob/broadMobs.dmi'
	health_doll_icon = "miner"
	icon_state = "claw-phase2"
	icon_living = "claw-phase2"
	armour_penetration = 30
	melee_damage_lower = 40
	melee_damage_upper = 40

	var/mob/living/carbon/human/host_body
