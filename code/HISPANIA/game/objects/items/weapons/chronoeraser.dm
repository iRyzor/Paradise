/obj/item/chrono_eraser/nto/bow
	name = "TED Bow"
	desc = "This variant of the TED works by firing an arrow from an energy bow that eliminates targets from the timeline with deadly accuracy. Never Existed."
	icon_state = "pchronobackpack"
	item_state = "pchronobackpack"
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = SLOT_BACK
	slowdown = 1
	actions_types = list(/datum/action/item_action/equip_unequip_TED_Gun)
	hispania_icon = TRUE

/obj/item/chrono_eraser/nto/needle
	name = "TED Needle"
	desc = "This variant of the classical TED fires projectiles from a long needle-like gun for precission strikes againts timeline criminals."
	icon_state = "waterbackpack"
	item_state = "waterbackpack"
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = SLOT_BACK
	slowdown = 1
	actions_types = list(/datum/action/item_action/equip_unequip_TED_Gun)
	hispania_icon = TRUE

/obj/item/chrono_eraser/nto/chronored
	name = "TED mk. II"
	desc = "A more powerful version of the standard TED. This one comes painted in red, which means danger. Or meant. Or will mean. Or will have meant. Time travel messes up grammar..."
	icon_state = "normalbackpack"
	item_state = "normalbackpack"
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = SLOT_BACK
	slowdown = 1
	actions_types = list(/datum/action/item_action/equip_unequip_TED_Gun)
	hispania_icon = TRUE

/obj/item/chrono_eraser/nto/shotgun
	name = "TED Launcher"
	desc = "This TED has a more classical approach to design, by dispensing time-ripper grenades at the user's target. It won't just erase time-travel crimnals from the timeline, they will also loose a toof."
	icon_state = "preybackpack"
	item_state = "preybackpack"
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = SLOT_BACK
	slowdown = 1
	actions_types = list(/datum/action/item_action/equip_unequip_TED_Gun)
	hispania_icon = TRUE

/obj/item/chrono_eraser/nto/staff
	name = "TED Staff"
	desc = "This variant of the TED deploys a long staff that can be used to fire time-rip projectiles. It's not magic, it's just science."
	icon_state = "normalbackpack"
	item_state = "normalbackpack"
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = SLOT_BACK
	slowdown = 1
	actions_types = list(/datum/action/item_action/equip_unequip_TED_Gun)
	hispania_icon = TRUE

////CHRONO GUNS BELOW ////


/obj/item/gun/energy/chrono_gun/nto/bow
	name = "T.E.D. Bow"
	desc = "This variant of the TED works by firing an arrow from an energy bow that eliminates targets from the timeline with deadly accuracy. Never Existed."
	icon_state = "purplebow"
	item_state = "purplebow"
	w_class = WEIGHT_CLASS_NORMAL
	flags = NODROP | DROPDEL
	ammo_type = list(/obj/item/ammo_casing/energy/chrono_beam)
	hispania_icon = TRUE

/obj/item/gun/energy/chrono_gun/nto/needle
	name = "T.E.D. Needle"
	desc = "This variant of the classical TED fires projectiles from a long needle-like gun for precission strikes againts timeline criminals."
	icon_state = "waterweapon"
	item_state = "waterweapon"
	w_class = WEIGHT_CLASS_NORMAL
	flags = NODROP | DROPDEL
	ammo_type = list(/obj/item/ammo_casing/energy/chrono_beam)
	hispania_icon = TRUE

/obj/item/gun/energy/chrono_gun/nto/chronored
	name = "T.E.D. mk. II"
	desc = "A more powerful version of the standard T.E.D. This one comes painted in red, which means danger. Or meant. Or will mean. Or will have meant. Time travel messes up grammar..."
	icon_state = "normalchronogun"
	item_state = "normalchronogun"
	w_class = WEIGHT_CLASS_NORMAL
	flags = NODROP | DROPDEL
	ammo_type = list(/obj/item/ammo_casing/energy/chrono_beam)
	hispania_icon = TRUE

/obj/item/gun/energy/chrono_gun/nto/shotgun
	name = "T.E.D. Launcher"
	desc = "This TED has a more classical approach to design, by dispensing time-ripper grenades at the user's target. It won't just erase time-travel crimnals from the timeline, they will also loose a toof."
	icon_state = "preyshotgun"
	item_state = "preyshotgun"
	w_class = WEIGHT_CLASS_NORMAL
	flags = NODROP | DROPDEL
	ammo_type = list(/obj/item/ammo_casing/energy/chrono_beam)
	hispania_icon = TRUE

/obj/item/gun/energy/chrono_gun/nto/staff
	name = "T.E.D. Staff"
	desc = "This variant of the TED deploys a long staff that can be used to fire time-rip projectiles. It's no magic, it's just science."
	icon_state = "witchstaff"
	item_state = "witchstaff"
	w_class = WEIGHT_CLASS_NORMAL
	flags = NODROP | DROPDEL
	ammo_type = list(/obj/item/ammo_casing/energy/chrono_beam)
	hispania_icon = TRUE