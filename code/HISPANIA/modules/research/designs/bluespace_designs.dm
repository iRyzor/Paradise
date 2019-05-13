/datum/design/duffelbag_holding
	name = "Duffelbag of Holding"
	desc = "A large duffelbag that opens into a localized pocket of Blue Space."
	id = "duffelbag_holding"
	req_tech = list("bluespace" = 7, "materials" = 5, "engineering" = 5, "plasmatech" = 6)
	build_type = PROTOLATHE
	materials = list(MAT_GOLD = 3000, MAT_DIAMOND = 1500, MAT_URANIUM = 250, MAT_BLUESPACE = 2000)
	build_path = /obj/item/storage/backpack/duffel/holding
	category = list("Bluespace")