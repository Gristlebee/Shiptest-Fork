// /obj/item/sample
// 	name = "sample"
// 	var/sample_type = 1

// /obj/item/serum
// 	name = "serum"
// 	var/used

// /obj/item/serum/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
// 	. = ..()
// 	if(busy)
// 		return
// 	if(!proximity)
// 		return

// 	var/mob/living/carbon/L
// 	if(isliving(target))
// 		L = target
// 		if(!L.can_inject(user, 1))
// 			return

// 	if(L) //living mob
// 		if(!L.can_inject(user, TRUE))
// 			return
// 		if(L != user)
// 			L.visible_message("<span class='danger'>[user] is trying to inject [L]!</span>", \
// 									"<span class='userdanger'>[user] is trying to inject you!</span>")
// 			if(!do_after(user, target = L, extra_checks=CALLBACK(L, TYPE_PROC_REF(/mob/living, can_inject), user, TRUE)))
// 				return
// 			if(used)
// 				return
// 			L.visible_message("<span class='danger'>[user] injects [L] with the syringe!</span>", \
// 							"<span class='userdanger'>[user] injects you with the syringe!</span>")

// 		if(L != user)
// 			log_combat(user, L, "injected", src, addition="which had [contained]")
// 		else
// 			L.log_message("injected themselves ([contained]) with [src.name]", LOG_ATTACK, color="orange")
// 		perform_test(user, L)

// /obj/item/serum/proc/perform_test(mob/user, mob/living/carbon/target)
// 	if(target.mind.has_antag_datum(/datum/antagonist/changeling))
// 		to_chat(user, span_warning("The serum reacts violently on contact with [target]!"))
// 	else
// 		to_chat(user, span_notice("The serum remains inert and does not react with [target]."))

// 	used = TRUE
