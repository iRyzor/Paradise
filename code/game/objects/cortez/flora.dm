//WILD Tower Cap//
/obj/item/seeds/wildtower
	name = "pack of glowshroom mycelium"
	desc = "This mycelium -glows- into mushrooms!"
	icon_state = "mycelium-glowshroom"
	species = "glowshroom"
	plantname = "Glowshrooms"
	product = /obj/item/reagent_containers/food/snacks/grown/mushroom/glowshroom
	yield = 3 //-> spread
	growing_icon = 'icons/obj/hydroponics/growing_mushrooms.dmi'


/obj/structure/tower/wild
	name = "Wild tower-cap"
	desc = "A wild speciment of Tower Cap, grows by itself!"
	anchored = 1
	opacity = 0
	density = 0
	icon = 'icons/obj/flora/cortez.dmi'
	icon_state = "towercap-wild"
	layer = 2.1
	var/delay = 1200
	var/floor = 0
	var/generation = 1
	var/spreadIntoAdjacentChance = 60
	var/obj/item/seeds/myseed = /obj/item/seeds/glowshroom
	var/product = /obj/item/grown/log


/obj/structure/tower/wild/attackby(obj/item/W, mob/user, params)
	if(is_sharp(W))
		user.show_message("<span class='notice'>You cut the tower-cap out of \the [src]!</span>", 1)
		new /obj/item/grown/log(user.loc, 1)
		qdel(src)


/obj/structure/tower/wild/single/Spread()
	return

/obj/structure/tower/wild/examine(mob/user)
	. = ..()
	to_chat(user, "This is a [generation]\th generation [name]!")

/obj/structure/tower/wild/Destroy()
	QDEL_NULL(myseed)
	return ..()

/obj/structure/tower/wild/New(loc, obj/item/seeds/newseed, mutate_stats)
	..()
	if(newseed)
		myseed = newseed.Copy()
		myseed.forceMove(src)
	else
		myseed = new myseed(src)
	if(mutate_stats) //baby mushrooms have different stats :3
		myseed.adjust_potency(rand(-3,6))
		myseed.adjust_yield(rand(-1,2))
		myseed.adjust_production(rand(-3,6))
		myseed.adjust_endurance(rand(-3,6))
	delay = delay - myseed.production * 100 //So the delay goes DOWN with better stats instead of up. :I
//	endurance = myseed.endurance
	if(myseed.get_gene(/datum/plant_gene/trait/glow))
		var/datum/plant_gene/trait/glow/G = myseed.get_gene(/datum/plant_gene/trait/glow)
		set_light(G.glow_range(myseed), G.glow_power(myseed), G.glow_color)
	setDir(CalcDir())
	var/base_icon_state = initial(icon_state)
	if(!floor)
		switch(dir) //offset to make it be on the wall rather than on the floor
			if(NORTH)
				pixel_y = 32
			if(SOUTH)
				pixel_y = -32
			if(EAST)
				pixel_x = 32
			if(WEST)
				pixel_x = -32
		icon_state = "[base_icon_state][rand(1,3)]"
	else //if on the floor, glowshroom on-floor sprite
		icon_state = "[base_icon_state]f"

	addtimer(CALLBACK(src, .proc/Spread), delay)

/obj/structure/tower/wild/proc/Spread()
	var/turf/ownturf = get_turf(src)
	var/shrooms_planted = 0
	for(var/i in 1 to myseed.yield)
		if(prob(1/(generation * generation) * 100))//This formula gives you diminishing returns based on generation. 100% with 1st gen, decreasing to 25%, 11%, 6, 4, 2...
			var/list/possibleLocs = list()
			var/spreadsIntoAdjacent = FALSE

			if(prob(spreadIntoAdjacentChance))
				spreadsIntoAdjacent = TRUE

			for(var/turf/simulated/floor/earth in view(3,src))
				if(!ownturf.CanAtmosPass(earth))
					continue
				if(spreadsIntoAdjacent || !locate(/obj/structure/tower/wild) in view(1,earth))
					possibleLocs += earth
				CHECK_TICK

			if(!possibleLocs.len)
				break

			var/turf/newLoc = pick(possibleLocs)

			var/shroomCount = 0 //hacky
			var/placeCount = 1
			for(var/obj/structure/tower/wild/shroom in newLoc)
				shroomCount++
			for(var/wallDir in cardinal)
				var/turf/isWall = get_step(newLoc,wallDir)
				if(isWall.density)
					placeCount++
			if(shroomCount >= placeCount)
				continue

			var/obj/structure/tower/wild/child = new type(newLoc, myseed, TRUE)
			child.generation = generation + 1
			shrooms_planted++

			CHECK_TICK
		else
			shrooms_planted++ //if we failed due to generation, don't try to plant one later
	if(shrooms_planted < myseed.yield) //if we didn't get all possible shrooms planted, try again later
		myseed.yield -= shrooms_planted
		addtimer(CALLBACK(src, .proc/Spread), delay)

/obj/structure/tower/wild/proc/CalcDir(turf/location = loc)
	var/direction = 16

	for(var/wallDir in cardinal)
		var/turf/newTurf = get_step(location,wallDir)
		if(newTurf.density)
			direction |= wallDir

	for(var/obj/structure/tower/wild/shroom in location)
		if(shroom == src)
			continue
		if(shroom.floor) //special
			direction &= ~16
		else
			direction &= ~shroom.dir

	var/list/dirList = list()

	for(var/i=1,i<=16,i <<= 1)
		if(direction & i)
			dirList += i

	if(dirList.len)
		var/newDir = pick(dirList)
		if(newDir == 16)
			floor = 1
			newDir = 1
		return newDir

	floor = 1
	return 1