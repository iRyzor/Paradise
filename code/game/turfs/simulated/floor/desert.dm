#define NORTH_EDGING	"north"
#define SOUTH_EDGING	"south"
#define EAST_EDGING		"east"
#define WEST_EDGING		"west"

/turf/simulated/floor/plating/desert
	name = "Desert"
	icon = 'icons/turf/floors.dmi'
	icon_state = "asteroid"
	icon_plating = "asteroid"
	var/dug = 0       //0 = has not yet been dug, 1 = has already been dug
	oxygen = 0.01
	nitrogen = 0.01
	temperature = TCMB

/turf/simulated/floor/plating/desert/New()
	var/proper_name = name
	..()
	name = proper_name
	if(prob(20))
		icon_state = "asteroid[rand(0,12)]"

/turf/simulated/floor/plating/desert/ex_act(severity, target)
	switch(severity)
		if(3.0)
			return
		if(2.0)
			if(prob(20))
				src.gets_dug()
		if(1.0)
			src.gets_dug()
	return

/turf/simulated/floor/plating/desert/attackby(obj/item/W, mob/user, params)
	//note that this proc does not call ..()
	if(!W || !user)
		return 0

	if((istype(W, /obj/item/shovel)))
		var/turf/T = get_turf(user)
		if(!istype(T))
			return

		if(dug)
			to_chat(user, "<span class='warning'>This area has already been dug!</span>")
			return

		to_chat(user, "<span class='notice'>You start digging...</span>")
		if(do_after(user, 20 * W.toolspeed, target = src))
			to_chat(user, "<span class='notice'>You dig a hole.</span>")
			gets_dug()
			return

	if((istype(W, /obj/item/pickaxe)))
		var/obj/item/pickaxe/P = W
		var/turf/T = get_turf(user)
		if(!istype(T))
			return

		if(dug)
			to_chat(user, "<span class='warning'>This area has already been dug!</span>")
			return

		to_chat(user, "<span class='notice'>You start digging...</span>")

		if(do_after(user, P.digspeed, target = src))
			to_chat(user, "<span class='notice'>You dig a hole.</span>")
			gets_dug()
			return

	if(istype(W,/obj/item/storage/bag/ore))
		var/obj/item/storage/bag/ore/S = W
		if(S.collection_mode == 1)
			for(var/obj/item/ore/O in src.contents)
				O.attackby(W,user)
				return

/turf/simulated/floor/plating/desert/gets_drilled()
	if(!dug)
		gets_dug()
	else
		..()

/turf/simulated/floor/plating/desert/proc/gets_dug()
	if(dug)
		return
	new/obj/item/ore/glass(src)
	new/obj/item/ore/glass(src)
	new/obj/item/ore/glass(src)
	new/obj/item/ore/glass(src)
	new/obj/item/ore/glass(src)
	dug = 1
	playsound(src, 'sound/effects/shovel_dig.ogg', 50, 1) //FUCK YO RUSTLE I GOT'S THE DIGS SOUND HERE
	icon_plating = "asteroid_dug"
	icon_state = "asteroid_dug"
	return


/turf/simulated/mineral/updateMineralOverlays()
	return

/turf/simulated/wall/updateMineralOverlays()
	return

/turf/simulated/floor/plating/desert/cave
	var/length = 100
	var/mob_spawn_list = list("Goldgrub" = 1, "Goliath" = 5, "Basilisk" = 4, "Hivelord" = 3)
	var/sanity = 1

/turf/simulated/floor/plating/desert/cave/New(loc, var/length, var/go_backwards = 1, var/exclude_dir = -1)

	// If length (arg2) isn't defined, get a random length; otherwise assign our length to the length arg.
	if(!length)
		src.length = rand(25, 50)
	else
		src.length = length

	// Get our directiosn
	var/forward_cave_dir = pick(alldirs - exclude_dir)
	// Get the opposite direction of our facing direction
	var/backward_cave_dir = angle2dir(dir2angle(forward_cave_dir) + 180)

	// Make our tunnels
	make_tunnel(forward_cave_dir)
	if(go_backwards)
		make_tunnel(backward_cave_dir)
	// Kill ourselves by replacing ourselves with a normal floor.
	SpawnFloor(src)
	..()

/turf/simulated/floor/plating/desert/cave/proc/make_tunnel(var/dir)

	var/turf/simulated/mineral/tunnel = src
	var/next_angle = pick(45, -45)

	for(var/i = 0; i < length; i++)
		if(!sanity)
			break

		var/list/L = list(45)
		if(IsOdd(dir2angle(dir))) // We're going at an angle and we want thick angled tunnels.
			L += -45

		// Expand the edges of our tunnel
		for(var/edge_angle in L)
			var/turf/simulated/mineral/edge = get_step(tunnel, angle2dir(dir2angle(dir) + edge_angle))
			if(istype(edge))
				SpawnFloor(edge)

		// Move our tunnel forward
		tunnel = get_step(tunnel, dir)

		if(istype(tunnel))
			// Small chance to have forks in our tunnel; otherwise dig our tunnel.
			if(i > 3 && prob(20))
				new src.type(tunnel, rand(10, 15), 0, dir)
			else
				SpawnFloor(tunnel)
		else //if(!istype(tunnel, src.parent)) // We hit space/normal/wall, stop our tunnel.
			break

		// Chance to change our direction left or right.
		if(i > 2 && prob(33))
			// We can't go a full loop though
			next_angle = -next_angle
			dir = angle2dir(dir2angle(dir) + next_angle)

/turf/simulated/floor/plating/desert/cave/proc/SpawnFloor(var/turf/T)
	for(var/turf/S in range(2,T))
		if(istype(S, /turf/space) || istype(S.loc, /area/mine/dangerous/explored))
			sanity = 0
			break
	if(!sanity)
		return

	SpawnMonster(T)
	var/turf/simulated/floor/t = new /turf/simulated/floor/plating/desert(T)
	spawn(2)
		t.fullUpdateMineralOverlays()

/turf/simulated/floor/plating/desert/cave/proc/SpawnMonster(var/turf/T)
	if(prob(30))
		if(istype(loc, /area/mine/dangerous/explored))
			return
		for(var/atom/A in range(15,T))//Lowers chance of mob clumps
			if(istype(A, /mob/living/simple_animal/hostile/asteroid))
				return
		var/randumb = pickweight(mob_spawn_list)
		switch(randumb)
			if("Goliath")
				new /mob/living/simple_animal/hostile/asteroid/goliath(T)
			if("Goldgrub")
				new /mob/living/simple_animal/hostile/asteroid/goldgrub(T)
			if("Basilisk")
				new /mob/living/simple_animal/hostile/asteroid/basilisk(T)
			if("Hivelord")
				new /mob/living/simple_animal/hostile/asteroid/hivelord(T)
	return

/turf/simulated/floor/plating/desert/attackby(obj/item/C as obj, mob/user as mob, params)
	..()
	if(istype(C, /obj/item/stack/rods))
		var/obj/item/stack/rods/R = C
		var/obj/structure/foundation/L = locate(/obj/structure/foundation, src)
		if(L)
			if(R.use(1))
				to_chat(user, "<span class='notice'>You begin constructing catwalk...</span>")
				playsound(src, 'sound/weapons/Genhit.ogg', 50, 1)
				qdel(L)
				ChangeTurf(/turf/simulated/floor/plating/airless/catwalk)
			else
				to_chat(user, "<span class='warning'>You need two rods to build a catwalk!</span>")
			return
		if(R.use(1))
			to_chat(user, "<span class='notice'>Constructing foundation...</span>")
			playsound(src, 'sound/weapons/Genhit.ogg', 50, 1)
			ReplaceWithFoundation()
		else
			to_chat(user, "<span class='warning'>You need one rod to build a lattice.</span>")
		return

	if(istype(C, /obj/item/stack/tile/plasteel))
		var/obj/structure/foundation/L = locate(/obj/structure/foundation, src)
		if(L)
			var/obj/item/stack/tile/plasteel/S = C
			if(S.use(1))
				qdel(L)
				playsound(src, 'sound/weapons/Genhit.ogg', 50, 1)
				to_chat(user, "<span class='notice'>You build a floor.</span>")
				ChangeTurf(/turf/simulated/floor/plating)
			else
				to_chat(user, "<span class='warning'>You need one floor tile to build a floor!</span>")
		else
			to_chat(user, "<span class='warning'>The plating is going to need some support! Place metal rods first.</span>")

#undef NORTH_EDGING
#undef SOUTH_EDGING
#undef EAST_EDGING
#undef WEST_EDGING