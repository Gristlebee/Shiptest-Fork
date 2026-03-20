/obj/item/melee/beeper
	name = "Magic Beeper"
	desc = "HOLY SHIT IS THAT THE BLACK SILEN-"
	var/form = 0
	var/charging = FALSE
	icon_state = "mace_handle"
	force = 150
	hitsound = list('sound/weapons/melee/heavyaxe_hit1.ogg', 'sound/weapons/melee/heavyaxe_hit2.ogg')
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	actions_types = list(/datum/action/item_action/execute_prescript)

/obj/item/melee/beeper/ComponentInitialize()
	. = ..()
	AddComponent( \
		/datum/component/transforming, \
		force_on = 150, \
		sharpness_on = SHARP_EDGED, \
		attack_verb_on = list("slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut"), \
	)
	RegisterSignal(src, COMSIG_TRANSFORMING_ON_TRANSFORM, PROC_REF(on_transform))
	AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/melee/beeper/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	if(charging)
		charge(target,user)
	else
		return ..()

/obj/item/melee/beeper/proc/charge(target, mob/user)
	charging = FALSE
	var/destination = get_turf(target)
	RegisterSignal(user,COMSIG_MOVABLE_BUMP,PROC_REF(smack))
	user.pass_flags = PASSMOB
	user.throw_at(destination, get_dist(target, user), 2, user, gentle = TRUE)
	sleep(get_dist(user, destination) * 0.7)
	UnregisterSignal(user,COMSIG_MOVABLE_BUMP)
	charging = TRUE
	user.pass_flags = initial(user.pass_flags)

/obj/item/melee/beeper/proc/smack(mob/user,target)
	if(isliving(target))
		var/mob/living/victim = target
		attack(victim,user)
		will_of_hermes(user,TRUE)

// /obj/item/melee/beeper/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
// 	. = ..()


/datum/action/item_action/execute_prescript
	name = "Execute Prescript"

/datum/action/item_action/execute_prescript/Trigger()
	if(istype(target, /obj/item/melee/beeper))
		var/obj/item/melee/beeper/tool = target
		tool.toggle_charge(owner)

/obj/item/melee/beeper/proc/toggle_charge(mob/user)
	charging = !charging
	to_chat(user, "You [charging ? "prepare" : "stop preparing"] to execute the prescript.")

/obj/item/melee/beeper/proc/on_transform(obj/item/source, mob/user, active)
	SIGNAL_HANDLER
	if(active)
		will_of_hermes(user,FALSE)
	return COMPONENT_NO_DEFAULT_MESSAGE

/obj/item/melee/beeper/proc/will_of_hermes(mob/user, switch_form = TRUE)
	if(switch_form)
		form++
	if(form > 8 || form < 0)
		form = 0
	//icon_state = "beeper_[form]"
	switch(form)
		if(0)
			to_chat(user, span_notice("When hacking through the ribs with a hatchet..."))
		if(1)
			to_chat(user, span_notice("When penetrating the lungs with a stiletto..."))
		if(2)
			to_chat(user, span_notice("When gouging out the eyes with a fpoon..."))
			usr.say("Tch. Bad roll.")
			force = 2
		if(3)
			to_chat(user, span_notice("When punching 10 or more holes with a rapier..."))
			force = 150
		if(4)
			to_chat(user, span_notice("When caving in the back of the skull with a hammer..."))
		if(5)
			to_chat(user, span_notice("When rending the body with a greatsword..."))
		if(6)
			to_chat(user, span_notice("When boring a 20 inch hole with a lance..."))
		if(7)
			to_chat(user, span_notice("When ripping the flesh to ten thousand strips with a whip..."))
		if(8)
			to_chat(user, span_notice("When lacerating through time itself, like a certain someone..."))

