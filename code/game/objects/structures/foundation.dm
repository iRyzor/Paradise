/obj/structure/foundation
	desc = "A lightweight support foundation."
	name = "foundation"
	icon = 'icons/turf/floors.dmi'
	icon_state = "plating"
	density = 0
	anchored = 1.0
	armor = list(melee = 50, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 0, rad = 0)
	layer = 2.3 //under pipes
	//	flags = CONDUCT

/obj/structure/foundation/New()
	..()
	if(!(istype(src.loc, /turf/simulated/floor/plating/desert)))
		qdel(src)
	for(var/obj/structure/foundation/LAT in src.loc)
		if(LAT != src)
			qdel(LAT)
	icon = 'icons/turf/floors.dmi'
	icon_state = "plating"
	updateOverlays()
/*	for(var/dir in cardinal)
		var/obj/structure/foundation/L
		if(locate(/obj/structure/foundation, get_step(src, dir)))
			L = locate(/obj/structure/foundation, get_step(src, dir))
			L.updateOverlays()
*/
/obj/structure/foundation/Destroy()
	for(var/dir in cardinal)
		var/obj/structure/foundation/L
		if(locate(/obj/structure/foundation, get_step(src, dir)))
			L = locate(/obj/structure/foundation, get_step(src, dir))
			L.updateOverlays(src.loc)
	return ..()

/obj/structure/foundation/blob_act()
	qdel(src)
	return

/obj/structure/foundation/ex_act(severity)
	switch(severity)
		if(1.0)
			qdel(src)
			return
		if(2.0)
			qdel(src)
			return
		if(3.0)
			return
		else
	return

/obj/structure/foundation/attackby(obj/item/C as obj, mob/user as mob, params)
	if(istype(C, /obj/item/stack/tile/plasteel) || istype(C, /obj/item/stack/rods))
		var/turf/T = get_turf(src)
		T.attackby(C, user) //BubbleWrap - hand this off to the underlying turf instead
		return
	if(istype(C, /obj/item/weldingtool))
		var/obj/item/weldingtool/WT = C
		if(WT.remove_fuel(0, user))
			to_chat(user, "<span class='notice'>Slicing foundation joints...</span>")
			new /obj/item/stack/rods(src.loc)
			qdel(src)


/obj/structure/foundation/proc/updateOverlays()
	//if(!(istype(src.loc, /turf/space)))
	//	qdel(src)
	spawn(1)
		overlays = list()

		var/dir_sum = 0

		for(var/direction in cardinal)
			if(locate(/obj/structure/foundation, get_step(src, direction)))
				dir_sum += direction
			else
				if(!(istype(get_step(src, direction), /turf/space)))
					dir_sum += direction

		icon_state = "foundation[dir_sum]"
		return

/obj/structure/foundation/singularity_pull(S, current_size)
	if(current_size >= STAGE_FOUR)
		qdel(src)