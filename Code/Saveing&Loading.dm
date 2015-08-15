mob/proc
	Save()
		if(fexists("Saves/[src].sav"))
			fdel("Saves/[src].sav")
		var/savefile/F = new("Saves/[src].sav")
		Write(F)
		F["X"]<<src.x
		F["Y"]<<src.y
		F["Z"]<<src.z



	Load()
		if(fexists("Saves/[src].sav"))
			var/savefile/F = new("Saves/[src].sav")
			Read(F)
			F["X"]>>src.x
			F["Y"]>>src.y
			F["Z"]>>src.z
			src.alpha=250
			src.underlays-=src.underlays
			src.icon_state=""
			src.density=1
			src.Blocking=0
			src.Dead=0

			src.HudCreate()
			src.Player=1
			new/obj/back(src.client)
			new/obj/OOC(src.client)
			winset(src,"Chat","is-visible=true")
			winset(src,"Main","focus=true")
			src.Max_MouseName()
			src.HEALTHREGEN()
			src.StaminaREGEN()
			GenerateShadow(src, SOUTH,-32)
			src.align()
			if(src.StaffOn)
				for(var/obj/Huds/SkillHuds/SkillHudOne/S in usr.client.screen)
					var/obj/Items/Weapons/Wooden_Sword/O = new/obj/Items/Weapons/Wooden_Sword
					O.pixel_y+=5
					O.pixel_x+=3
					S.overlays+=O
			if(src.SwordOn)
				for(var/obj/Huds/SkillHuds/SkillHudOne/S in usr.client.screen)
					var/obj/Items/Weapons/RStaff/O = new/obj/Items/Weapons/RStaff
					O.pixel_y+=5
					O.pixel_x+=3
					S.overlays+=O
			if(src.BowOn)
				for(var/obj/Huds/SkillHuds/SkillHudOne/S in usr.client.screen)
					var/obj/Items/Weapons/Bow/O = new/obj/Items/Weapons/Bow
					O.pixel_y+=5
					O.pixel_x+=3
					S.overlays+=O
			src.CDCHECK()
			src.deathcheck()