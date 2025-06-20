/datum/mission/outpost/scan
	name = "Jungle Garden survey mission"
	desc = " requires data on the local flora. Please use the provided scanner to analyze the requested gardens on the \
			nearby planetoids."
	value = 1850 // base value, before adding bonus for number of things to fly through
	duration = 60 MINUTES

	var/obj/item/mission_scanner/scanner
	var/atom/movable/objective_type
	///goal number of scans
	var/num_wanted = 5
	var/researcher_name
	///how much is a scan is worth
	var/scan_value = 150


/obj/item/mission_scanner
	name = "Survey Device"
	desc = "A small tool designed for surveys."
	icon = 'icons/obj/item/survey_handheld.dmi'
	icon_state = "survey"

	var/atom/movable/objective_type
	var/list/scanned = list()
