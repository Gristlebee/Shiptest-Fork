// Ferromagnetic Pellet (Prototype Gauss Rifle & Claris)

/obj/projectile/bullet/gauss
	name = "ferromagnetic pellet"
	icon_state = "gauss-pellet"
	damage = 22
	armour_penetration = 30
	range = 35
	light_system = 2
	light_color = MOVABLE_LIGHT
	light_range = 3

/obj/projectile/bullet/gauss/hc
	name = "ferromagnetic pellet"
	damage = 20
	armour_penetration = 30
	range = 7
	hitscan = TRUE
	decayedRange = 7
	light_system = 0
	light_range = 0
	muzzle_type = /obj/effect/projectile/muzzle/gauss
	tracer_type = /obj/effect/projectile/tracer/gauss
	impact_type = /obj/effect/projectile/impact/gauss

// Ferromagnetic Lance (GAR AR)

/obj/projectile/bullet/gauss/lance
	name = "ferromagnetic lance"
	icon_state = "redtrac"
	damage = 25
	armour_penetration = 40

/obj/projectile/bullet/gauss/lance/hc
	name = "ferromagnetic lance"
	damage = 25
	armour_penetration = 35
	range = 7
	hitscan = TRUE
	light_system = 0
	light_range = 0
	muzzle_type = /obj/effect/projectile/muzzle/gauss
	tracer_type = /obj/effect/projectile/tracer/gauss
	impact_type = /obj/effect/projectile/impact/gauss

// Ferromagnetic Slug (Model H)

/obj/projectile/bullet/gauss/slug
	name = "ferromagnetic slug"
	icon_state = "gauss-slug"
	damage = 40
	armour_penetration = 15
	speed = 0.8

/obj/projectile/bullet/gauss/slug/dense
	name = "ferromagnetic slug"
	icon_state = "gauss-slug"
	damage = 50
	armour_penetration = -60
	speed = 0.8

/obj/projectile/bullet/gauss/slug/hc
	name = "ferromagnetic slug"
	damage = 25
	armour_penetration = 0
	range = 50
	hitscan = TRUE
	light_system = 0
	light_range = 0
	muzzle_type = /obj/effect/projectile/muzzle/gauss
	tracer_type = /obj/effect/projectile/tracer/gauss
	impact_type = /obj/effect/projectile/impact/gauss
