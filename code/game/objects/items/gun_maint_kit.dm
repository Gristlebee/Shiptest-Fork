/obj/item/gun_maint_kit
	name = "firearm maintenance kit"
	desc = "A toolkit containing everything needed to scrub the frontier-gunk out of a gun and return it to a mostly-usable state. Chemicals included in the kit are expended in a cleaning cycle, preventing re-use more than a few times."
	icon = 'icons/obj/improvised.dmi'
	icon_state = "kitsuitcase"
	w_class = WEIGHT_CLASS_BULKY //no carrying these around, sorry :(
	custom_materials = list(/datum/material/iron = 500)
	/// Amount of wear removed from a gun on use
	var/wear_reduction = 120
	/// Number of times this gun fixer can be used
	var/uses = 5

/obj/item/gun_maint_kit/examine(mob/user)
	. = ..()
	. += "A warning label on the side notes that firearms should be fully unloaded before being cleaned, to avoid risk of accidental discharge."
	. += "It can be used [uses] more times."

/obj/item/gun_maint_kit/afterattack(atom/target, mob/user, proximity)
	var/conditionstr = "though it would benefit from another cycle"
	if(!proximity)
		return
	if(!uses)
		to_chat(user, span_warning("[src] is out of uses!"))
		return
	var/obj/item/gun/ballistic/fixable = target
	if(!istype(fixable))
		return
	if(!fixable.gun_wear)
		to_chat(user, span_notice("[fixable] is already in good condition!"))
		return
	if(fixable.safety)
		to_chat(user, span_notice("The safety of [fixable] is locking its mechanisms, and needs to be disabled for cleaning.")) //notice that you are PLAYING WITH FIRE.
		return
	fixable.add_overlay(GLOB.cleaning_bubbles)
	playsound(src, 'sound/misc/slip.ogg', 15, TRUE, -8)
	user.visible_message(span_notice("[user] starts to wipe down [fixable] with [src]!"), span_notice("You start to give [fixable] a deep clean with [src]..."))
	if(!do_after(user, 10 SECONDS, target = target, extra_checks = CALLBACK(fixable, TYPE_PROC_REF(/obj/item/gun/ballistic, accidents_happen), user)))
		fixable.cut_overlay(GLOB.cleaning_bubbles)
		return
	fixable.cut_overlay(GLOB.cleaning_bubbles)
	fixable.wash(CLEAN_SCRUB)
	if(fixable.gun_wear - wear_reduction <= fixable.wear_excellent_threshold)
		var/base_reduction = min((fixable.gun_wear - fixable.wear_excellent_threshold), 0)
		if(base_reduction > 0)
			fixable.adjust_wear(base_reduction)
		var/excess_reduction = (wear_reduction - base_reduction)/3 /// the gun is already in good condition, you cant improve it much more
		fixable.adjust_wear(excess_reduction)
		conditionstr = "though it's already in excellent condition, and it's hard to improve it much more"
	else
		fixable.adjust_wear(-wear_reduction)
		if(fixable.gun_wear < fixable.wear_minor_threshold)
			conditionstr = "and it's in pretty good condition"
	user.visible_message(span_notice("[user] finishes cleaning [fixable]!"), span_notice("You finish cleaning [fixable], [conditionstr]."))
	uses--
