// thingling test making machine

// /obj/machinery/test_maker
// 	name = "\improper Bio-Master"
// 	desc = "A Cybersun Industries Bio-Master. Capable of rendering down biological samples into easy to use serums."
// 	icon = 'icons/obj/kitchen.dmi'
// 	icon_state = "juicer1"
// 	base_icon_state = "juicer"
// 	layer = BELOW_OBJ_LAYER
// 	use_power = IDLE_POWER_USE
// 	idle_power_usage = IDLE_DRAW_MINIMAL
// 	active_power_usage = ACTIVE_DRAW_MEDIUM
// 	circuit = /obj/item/circuitboard/machine/test_maker
// 	pass_flags = PASSTABLE
// 	resistance_flags = ACID_PROOF
// 	var/operating = FALSE
// 	var/speed = 1
// 	var/obj/sample/loaded

// 	var/static/radial_examine = image(icon = 'icons/mob/radial.dmi', icon_state = "radial_examine")
// 	var/static/radial_eject = image(icon = 'icons/mob/radial.dmi', icon_state = "radial_eject")
// 	var/static/radial_grind = image(icon = 'icons/mob/radial.dmi', icon_state = "radial_grind")

// /obj/machinery/test_maker/Destroy()
// 	QDEL_NULL(loaded)
// 	return ..()

// /obj/machinery/test_maker/examine(mob/user)
// 	. = ..()
// 	if(!in_range(user, src) && !issilicon(user) && !isobserver(user))
// 		. += "<span class='warning'>You're too far away to examine [src]'s contents and display!</span>"
// 		return

// 	if(operating)
// 		. += "<span class='warning'>\The [src] is operating.</span>"
// 		return

// 	if(loaded)
// 		. += "<span class='notice'>\The [src] contains:</span>"
// 		. += "<span class='notice'>- \A [loaded.name].</span>"

// /obj/machinery/test_maker/attackby(obj/item/I, mob/living/user, params)
// 	. = ..()
// 	if(loaded)
// 		span_warning("The [src] already has a sample in it!")

// 	if(user.transferItemToLoc(I, src))
// 		to_chat(user, "<span class='notice'>You add [I] to [src].</span>")
// 		loaded = I
// 		return FALSE

// /obj/machinery/test_maker/ui_interact(mob/user) // The microwave Menu //I am reasonably certain that this is not a microwave
// 	. = ..()

// 	if(operating || !user.canUseTopic(src, !issilicon(user)))
// 		return

// 	var/list/options = list()

// 	if(loaded)
// 		options["eject"] = radial_eject

// 	if(isAI(user))
// 		if(machine_stat & NOPOWER)
// 			return
// 		options["examine"] = radial_examine

// 	// if there is no power or it's broken, the procs will fail but the buttons will still show
// 	if(length(holdingitems))
// 		options["grind"] = radial_grind
// 	else if(beaker?.reagents.total_volume)
// 		options["mix"] = radial_mix

// 	var/choice

// 	if(length(options) < 1)
// 		return
// 	if(length(options) == 1)
// 		for(var/key in options)
// 			choice = key
// 	else
// 		choice = show_radial_menu(user, src, options, require_near = !issilicon(user))

// 	// post choice verification
// 	if(operating || (isAI(user) && machine_stat & NOPOWER) || !user.canUseTopic(src, !issilicon(user)))
// 		return

// 	switch(choice)
// 		if("eject")
// 			loaded.forceMove(loc)
// 		if("grind")
// 			grind(user)
// 		if("examine")
// 			examine(user)

// /obj/machinery/test_maker/proc/shake_for(duration)
// 	var/offset = prob(50) ? -2 : 2
// 	var/old_pixel_x = pixel_x
// 	animate(src, pixel_x = pixel_x + offset, time = 0.2, loop = -1) //start shaking
// 	addtimer(CALLBACK(src, PROC_REF(stop_shaking), old_pixel_x), duration)

// /obj/machinery/test_maker/proc/stop_shaking(old_px)
// 	animate(src)
// 	pixel_x = old_px

// /obj/machinery/test_maker/proc/operate_for(time, silent = FALSE, juicing = FALSE)
// 	shake_for(time / speed)
// 	operating = TRUE
// 	if(!silent)
// 		if(!juicing)
// 			playsound(src, 'sound/machines/blender.ogg', 50, TRUE)
// 		else
// 			playsound(src, 'sound/machines/juicer.ogg', 20, TRUE)
// 	addtimer(CALLBACK(src, PROC_REF(stop_operating)), time / speed)

// /obj/machinery/test_maker/proc/stop_operating()
// 	operating = FALSE

// /obj/machinery/test_maker/proc/grind(mob/user)
// 	if(!beaker || machine_stat & (NOPOWER|BROKEN) || beaker.reagents.total_volume >= beaker.reagents.maximum_volume)
// 		return
// 	set_active_power()
// 	operate_for(60)
// 	set_idle_power()
// 	if(loaded)
// 		// make serum

