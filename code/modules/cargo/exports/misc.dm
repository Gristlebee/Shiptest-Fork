/datum/export/fish
	unit_name = "fish"
	cost = 250
	export_types = list(/obj/item/fish)

/datum/export/trash
	unit_name = "trash"
	desc = "CLIP-LAND is running a recycling initiative to help clean up the Frontier. They'll take trash like old food packaging, empty cans, bottles, and used cigarette packs and butts for a small rebate."
	cost = 2
	export_types = list(/obj/item/trash, /obj/item/cigbutt, /obj/item/reagent_containers/food/drinks, /obj/item/storage/fancy/cigarettes)

/datum/export/trash/get_amount(obj/O)
	. = ..()
	if(istype(O, /obj/item/storage/fancy/cigarettes))
		if(O.contents.len > 0)
			return FALSE
	if(istype(O, /obj/item/reagent_containers/food/drinks))
		if(O.reagents.total_volume > 0)
			return FALSE

