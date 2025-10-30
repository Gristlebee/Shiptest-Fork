/datum/action/changeling/absorbDNA
	name = "Assimilate DNA"
	desc = "Assimilate the DNA of our victim. Requires us to strangle them."
	button_icon_state = "absorb_dna"
	chemical_cost = 0
	dna_cost = 0
	req_human = 1

/datum/action/changeling/absorbDNA/can_sting(mob/living/carbon/user)
	if(!..())
		return

	var/datum/antagonist/changeling/changeling = user.mind.has_antag_datum(/datum/antagonist/changeling)
	if(changeling.isabsorbing)
		to_chat(user, "<span class='warning'>We are already assimilating!</span>")
		return

	if(!user.pulling || !iscarbon(user.pulling))
		to_chat(user, "<span class='warning'>We must be grabbing a creature to assimilate them!</span>")
		return
	if(user.grab_state <= GRAB_NECK)
		to_chat(user, "<span class='warning'>We must have a tighter grip to assimilate this creature!</span>")
		return

	var/mob/living/carbon/target = user.pulling
	return changeling.can_absorb_dna(target)



/datum/action/changeling/absorbDNA/sting_action(mob/user)
	var/datum/antagonist/changeling/changeling = user.mind.has_antag_datum(/datum/antagonist/changeling)
	var/mob/living/carbon/human/target = user.pulling
	var/is_ling = FALSE

	if(target.mind.has_antag_datum(/datum/antagonist/changeling))
		is_ling = TRUE
		if(target.stat = DEAD)
			target.notify_ghost_cloning("Your body is being regenerated!")
			target.grab_ghost() // Shove them back in their body.
		return

	changeling.isabsorbing = 1
	for(var/i in 1 to 3)
		switch(i)
			if(1)
				if(is_ling)
					to_chat(user, span_warning("This form is an extension of our collective. We begin repairing it's form. We must hold still..."))
				else
					to_chat(user, "<span class='notice'>This creature is compatible. We must hold still...</span>")
			if(2)
				user.visible_message("<span class='warning'>[user] extends a proboscis!</span>", "<span class='notice'>We extend a proboscis.</span>")
			if(3)
				user.visible_message("<span class='danger'>[user] stabs [target] with the proboscis!</span>", "<span class='notice'>We stab [target] with the proboscis.</span>")
				to_chat(target, "<span class='userdanger'>You feel a sharp stabbing pain!</span>")
				target.take_overall_damage(40)

		SSblackbox.record_feedback("nested tally", "changeling_powers", 1, list("assimilate DNA", "[i]"))
		if(!do_after(user, 15 SECONDS, target))
			to_chat(user, "<span class='warning'>Our assimilation of [target] has been interrupted!</span>")
			changeling.isabsorbing = 0
			return

	SSblackbox.record_feedback("nested tally", "changeling_powers", 1, list("assimilate DNA", "4"))
	user.visible_message("<span class='danger'>[user] injects something into [target]!</span>", "<span class='notice'>We have assimilated [target].</span>")

	if(!changeling.has_dna(target.dna))
		changeling.add_new_profile(target)
		//changeling.trueabsorbs++

	if(user.nutrition < NUTRITION_LEVEL_WELL_FED)
		user.set_nutrition(min((user.nutrition + target.nutrition), NUTRITION_LEVEL_WELL_FED))

	// Absorb a lizard, speak Draconic.
	owner.copy_languages(target, LANGUAGE_ABSORB)

	if(target.mind && user.mind)
		to_chat(target, "<span class='userdanger'>You are assimilated by the Collective!</span>")
		target.mind.add_antag_datum(/datum/antagonist/changeling)
		target.fully_heal(TRUE)
		playsound(user, 'sound/magic/demon_consume.ogg', 50, TRUE)
	if(is_ling)
		to_chat(target, "<span class='userdanger'>We are fully restored by one of us.</span>")
		target.fully_heal(TRUE)

	changeling.chem_charges=min(changeling.chem_charges+10, changeling.chem_storage)

	changeling.isabsorbing = 0
	changeling.canrespec = 1

	return TRUE
