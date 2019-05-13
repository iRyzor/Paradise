
/obj/item/storage/backpack/duffel/holding
	name = "Duffelbag of Holding"
	desc = "A backpack that opens into a localized pocket of Blue Space."
	origin_tech = "bluespace=5;materials=4;engineering=4;plasmatech=5"
	icon_state = "duffel-holding"
	item_state = "duffel-holding"
	max_w_class = WEIGHT_CLASS_HUGE
	max_combined_w_class = 35
	burn_state = FIRE_PROOF
	flags_2 = NO_MAT_REDEMPTION_2
	cant_hold = list(/obj/item/storage/backpack/holding, /obj/item/storage/backpack/duffel/holding)
	hispania_icon = TRUE

/obj/item/storage/backpack/duffel/holding/New()
	..()
	return

/obj/item/storage/backpack/duffel/holding/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/storage/backpack/duffel/holding) || istype(W, /obj/item/storage/backpack/holding))
		var/response = alert(user, "This creates a singularity, destroying you and much of the station. Are you SURE?","IMMINENT DEATH!", "No", "Yes")
		if(response == "Yes")
			user.visible_message("<span class='warning'>[user] grins as [user.p_they()] begin[user.p_s()] to put a Bag of Holding into a Bag of Holding!</span>", "<span class='warning'>You begin to put the Bag of Holding into the Bag of Holding!</span>")
			if(do_after(user, 30, target=src))
				investigate_log("has become a singularity. Caused by [user.key]","singulo")
				user.visible_message("<span class='warning'>[user] erupts in evil laughter as [user.p_they()] put[user.p_s()] the Bag of Holding into another Bag of Holding!</span>", "<span class='warning'>You can't help but laugh wildly as you put the Bag of Holding into another Bag of Holding, complete darkness surrounding you.</span>","<span class='warning'> You hear the sound of scientific evil brewing! </span>")
				qdel(W)
				var/obj/singularity/singulo = new /obj/singularity(get_turf(user))
				singulo.energy = 300 //To give it a small boost
				message_admins("[key_name_admin(user)] detonated a bag of holding <A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[x];Y=[y];Z=[z]'>JMP</a>)")
				log_game("[key_name(user)] detonated a bag of holding")
				qdel(src)
			else
				user.visible_message("After careful consideration, [user] has decided that putting a Bag of Holding inside another Bag of Holding would not yield the ideal outcome.","You come to the realization that this might not be the greatest idea.")
	else
		. = ..()

/obj/item/storage/backpack/duffel/holding/singularity_act(current_size)
	var/dist = max((current_size - 2),1)
	explosion(src.loc,(dist),(dist*2),(dist*4))
	return