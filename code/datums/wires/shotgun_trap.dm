/datum/wires/shotgun_trap
	wires = list(WIRE_PROCEED,WIRE_HACK)
	randomize = TRUE // Prevents wires from showing up on blueprints

/datum/wires/shotgun_trap/on_pulse(wire)
	var/obj/item/shotgun_trap/trap = holder
	switch(wire)
		if(WIRE_ZAP)
		if(WIRE_HACK)
	..()
