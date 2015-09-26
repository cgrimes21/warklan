
mob/proc
	equip_add_Overlay()
		src.overlays+=new/obj/weaponequipped
	equip_del_Overlay()
		src.overlays-=new/obj/weaponequipped
	equip_clothing_add_Overlay()
		src.overlays+=new/obj/clothingequipped
	equip_clothing_del_Overlay()
		src.overlays-=new/obj/clothingequipped

obj/weaponequipped
	icon='Equipped.dmi'
	icon_state="sword"
	parent_type = /obj
	layer = 100
	New(newloc, val)
		maptext = val
		src.loc=newloc
		pixel_x=0
		pixel_y=40

obj/clothingequipped
	icon='Equipped.dmi'
	icon_state="shield"
	parent_type = /obj
	layer = 100
	New(newloc, val)
		maptext = val
		src.loc=newloc
		pixel_x=14
		pixel_y=40

obj/Equipped
	icon='Items.dmi'
	icon_state="E2"
	layer=99999

obj/HudLetter
	icon='Items.dmi'
	layer=99999
	A
		icon_state="A"
	One
		icon_state="1"
	Two
		icon_state="2"
	Three
		icon_state="3"
	Four
		icon_state="4"


obj/Gold
	icon='Coin.dmi'
	Click()
		if(src in oview(1))
			if(usr.Dying)
				return
			usr<<sound('pickupcoin.wav')
			usr.Gold+=src.Amount
			del(src)

obj/proc
	Fade()
		src.Fading=1
		spawn(500)
		if(src.Fading)
			del src



mob/verb
	PickUp()
		if(usr.Dying)
			return
		for(var/obj/Gold/G in oview(1))
			usr.Gold+=G.Amount
			usr<<sound('pickupcoin.wav')
			del(G)
		for(var/obj/Items/ItemDrops/Iron/I in oview(1))
			usr.Iron+=I.Amount
			usr<<sound('pickupcoin.wav')
			del(I)
		for(var/obj/Items/O in oview(1))
			if(!O.CanPickUp)
				return
			if(O.owner != "")
				usr<<"This belongs to [O.owner]."
				return
			if(usr.pickupTutorialActivated==1)
				usr.pickupTutorialActivated=0
				usr.pickupTutorialDone=1
				usr.HudDelete_Tut2()
			if(usr.AvailableItems>=MAXITEMS)
				_message(usr,"You're holding too many items!","Yellow")
				return
			else
				usr.AvailableItems+=1
				usr.contents+=O
				usr.QuestItemPickup(O)
				O.Fading=0
				usr.Clicking()
				if(usr.BagOpen==1)
					usr.AddItems()
					return
obj/Items
	var/owner = ""
//Items that get dropped
obj/Items/ItemDrops
	New()
		..()
		spawn(600)
			src.owner = ""

	Fox_Fur
		icon='ItemDrops.dmi'
		icon_state="foxfur"
		name="Fox Cub Fur"
		Click()
			if(src in oview(1))
				usr.Clicking()
				if(usr.AvailableItems>=MAXITEMS)
					_message(usr,"You're holding too many items!","Yellow")
					return
				else
					usr.AvailableItems+=1
					usr.contents+=src
					if(usr.BagOpen==1)
						usr.AddItems()
					src.Fading=0

	Red_Fox_Fur
		icon='ItemDrops.dmi'
		icon_state="redfoxfur"
		name="Red Fox Fur"
		Click()
			if(src in oview(1))
				usr.Clicking()
				if(usr.AvailableItems>=MAXITEMS)
					_message(usr,"You're holding too many items!","Yellow")
					return
				else
					usr.AvailableItems+=1
					usr.contents+=src
					if(usr.BagOpen==1)
						usr.AddItems()
					src.Fading=0

	Mountain_Wolf_Fur
		icon='ItemDrops.dmi'
		icon_state="wolffur"
		name="Mountain Wolf Fur"
		Click()
			if(src in oview(1))
				usr.Clicking()
				if(usr.AvailableItems>=MAXITEMS)
					_message(usr,"You're holding too many items!","Yellow")
					return
				else
					usr.AvailableItems+=1
					usr.contents+=src
					if(usr.BagOpen==1)
						usr.AddItems()
					src.Fading=0


	Stone
		icon='ItemDrops.dmi'
		icon_state="smallstone"
		name="Stone"
		Click()
			if(src in oview(1))
				usr.Clicking()
				if(usr.AvailableItems>=MAXITEMS)
					_message(usr,"You're holding too many items!","Yellow")
					return
				else
					usr.AvailableItems+=1
					usr.contents+=src
					if(usr.BagOpen==1)
						usr.AddItems()
					src.Fading=0
	Iron
		icon='JpShopItems.dmi'
		icon_state="iron"
		Click()
			usr.Clicking()
			if(src in oview(1))
				if(usr.Dying)
					return
				usr<<sound('pickupcoin.wav')
				usr.Iron+=src.Amount
				del(src)

	Bronze
		icon='JpShopItems.dmi'
		icon_state="bronze"
		Click()
			usr.Clicking()
			if(src in oview(1))
				if(usr.Dying)
					return
				if(usr.AvailableItems>=MAXITEMS)
					_message(usr,"You're holding too many items!","Yellow")
					return
				else
					usr.AvailableItems+=1
					usr.contents+=src
					if(usr.BagOpen==1)
						usr.AddItems()
					src.Fading=0


//Quest Items//
obj/Items/Quest
	Treasure_Chest
		icon='TreasureChest.dmi'
		CanPickUp=0
		Click()
			if(src in oview(1))
				if(usr.DoingQuest==1)
					if(usr.Dying)
						return
					usr<<sound('pickupcoin.wav')
					src.icon_state="open"
					sleep(10)
					del src
				if(usr.DoingQuest==1)
					if(usr.Dying)
						return
					usr<<sound('pickupcoin.wav')
					src.icon_state="open"
					sleep(10)
					del src

	Treasure_Chest_Iron
		icon='TreasureChest.dmi'
		Click()
			if(src in oview(1))
				if(usr.Dying)
					return
				usr<<sound('pickupcoin.wav')
				src.icon_state="open"
				_message(usr, "<font color=green>You've found Iron!</font>","white")

				var/obj/Items/Crafting/Iron/A = new/obj/Items/Crafting/Iron
				usr.AvailableItems+=1
				usr.contents+=A
				if(usr.BagOpen==1)
					usr.AddItems()
				sleep(10)
				del src

				return





obj/Items
	verb
		Drop()
			if(src in usr.contents)
				if(src.Equipped)
					src<<"This item is equipped."
					return
				usr.AvailableItems-=1
				src.loc = usr.loc
				usr.AddItems()
				usr.CreateInventory()
				usr.CreateInventory()

	Tailor
		icon='Items.dmi'
		layer=16
		Weight=1
		Sack
			icon_state="Sack"
			Click()
				usr<<sound('Clickitem_statpoints.wav')
				if(src in usr.contents)
					usr.AvailableItems-=1
					usr.MaxWeight+=rand(0,2)
					usr.MaxItems+=rand(1,4)
					if(usr.MaxItems>=25)
						usr.MaxItems=25
					usr.contents-=src
					usr.CreateInventory()
					usr.CreateInventory()
					return
				else
					if(src in oview(1))
						if(usr.AvailableItems>=MAXITEMS)
							_message(usr,"You're holding too many items!","Yellow")
							return
						else
							usr.AvailableItems+=1
							usr.contents+=src
							if(usr.BagOpen==1)
								usr.AddItems()
	Witch_Doctor
		icon='Items.dmi'
		layer=16
		Weight=5
		Buff
			icon_state="Buff"
			Click()
				usr<<sound('Clickitem_statpoints.wav')
				if(src in usr.contents)
					if(usr.Buffed){return}
					usr.Buffed=1
					var/T=rand(1,40)
					usr.Strength+=T
					usr.AvailableItems-=1
					spawn(50)
						usr.Strength-=T
						usr.Buffed=0
					usr.contents-=src
					usr.CreateInventory()
					usr.CreateInventory()
					return
				else
					if(src in oview(1))
						if(usr.AvailableItems>=MAXITEMS)
							_message(usr,"You're holding too many items!","Yellow")
							return
						else
							usr.AvailableItems+=1
							usr.contents+=src
							if(usr.BagOpen==1)
								usr.AddItems()
	Doctor
		icon='Items.dmi'
		layer=16
		Weight=5
		Potion
			icon_state="Potion"
			Click()
				usr<<sound('Clickitem_statpoints.wav')
				if(src in usr.contents)
					usr.AvailableItems-=1
					usr.Health+=rand(5,40)
					if(usr.Health>=usr.MaxHealth)
						usr.Health=usr.MaxHealth
						usr.contents-=src
						usr.CreateInventory()
						usr.CreateInventory()
						return
				else
					if(src in oview(1))
						if(usr.AvailableItems>=MAXITEMS)
							_message(usr,"You're holding too many items!","Yellow")
							return
						else
							usr.AvailableItems+=1
							usr.contents+=src
							if(usr.BagOpen==1)
								usr.AddItems()
	Crafting
		icon='Weapons.dmi'
		layer=17
		Weight=25
		Iron
			icon='JpShopItems.dmi'
			icon_state="iron"
			Click()
				usr<<sound('Clickitem_statpoints.wav')
				if(src in oview(1))
					if(usr.AvailableItems>=MAXITEMS)
						_message(usr,"You're holding too many items","Yellow")
						return
					else
						usr.AvailableItems+=1
						usr.contents+=src
						if(usr.BagOpen==1)
							usr.AddItems()

	Clothing
		icon='Weapons.dmi'
		WeaponLevel=1
		Boost=0

		Fox_Cub_Tunic
			icon='JpShopItems.dmi'
			icon_state="fctunic"
			name="Fox Cub Tunic"
			Boost=1.2
			Click()
				usr<<sound('Clickitem_statpoints.wav')
				if(src in usr.contents)
					if(src.Wearing==1)
						src.Wearing=0
						src.Equipped=0
						usr.ShieldBoost = 0
						src.overlays-=src.overlays
						usr.equip_clothing_del_Overlay()
						usr.WearingShirt=0
						return
					if(usr.WearingShirt==1)
						_message(usr,"You're Already Wearing A Shirt!","Yellow")
						return
					src.Wearing=1
					src.Equipped=1
					usr.WearingShirt=1
					usr.equip_clothing_add_Overlay()
					src.overlays+=new/obj/Equipped
					usr.ShieldBoost = Boost
				else
					if(src in oview(1))
						if(usr.AvailableItems>=MAXITEMS)
							_message(usr,"You're holding too many items!","Yellow")
							return
						else
							usr.AvailableItems+=1
							usr.contents+=src
							if(usr.BagOpen==1)
								usr.AddItems()

		Red_Fox_Coat
			icon='JpShopItems.dmi'
			icon_state="rfcoat"
			name="Red Fox Coat"
			Boost=1.5
			Click()
				usr<<sound('Clickitem_statpoints.wav')
				if(src in usr.contents)
					if(src.Wearing==1)
						src.Wearing=0
						src.Equipped=0
						usr.ShieldBoost = 0
						src.overlays-=src.overlays
						usr.WearingShirt=0
						usr.Defense-=10
						return
					if(usr.WearingShirt==1)
						_message(usr,"You're Already Wearing A Shirt!","Yellow")
						return
					src.Wearing=1
					src.Equipped=1
					usr.WearingShirt=1
					src.overlays+=new/obj/Equipped
					usr.ShieldBoost = Boost
				else
					if(src in oview(1))
						if(usr.AvailableItems>=MAXITEMS)
							_message(usr,"You're holding too many items!","Yellow")
							return
						else
							usr.AvailableItems+=1
							usr.contents+=src
							if(usr.BagOpen==1)
								usr.AddItems()


		Wolf_Fur_Coat
			icon='JpShopItems.dmi'
			icon_state="wfcoat"
			name="Wolf Fur Coat"
			Boost=2
			Click()
				usr<<sound('Clickitem_statpoints.wav')
				if(src in usr.contents)
					if(src.Wearing==1)
						src.Wearing=0
						src.Equipped=0
						usr.ShieldBoost = 0
						src.overlays-=src.overlays
						usr.WearingShirt=0
						return
					if(usr.WearingShirt==1)
						_message(usr,"You're Already Wearing A Shirt!","Yellow")
						return
					src.Wearing=1
					src.Equipped=1
					usr.WearingShirt=1
					src.overlays+=new/obj/Equipped
					usr.ShieldBoost = Boost
				else
					if(src in oview(1))
						if(usr.AvailableItems>=MAXITEMS)
							_message(usr,"You're holding too many items!","Yellow")
							return
						else
							usr.AvailableItems+=1
							usr.contents+=src
							if(usr.BagOpen==1)
								usr.AddItems()


	Weapons
		icon='Weapons.dmi'
		Weight=25

		Stone_Sword
			WeaponLevel=1
			Boost=1.2
			icon='JpShopItems.dmi'
			icon_state="Stone Sword"
			Click()
				usr<<sound('Clickitem_statpoints.wav')
				if(src in usr.contents)
					if(src.Wearing==1)
						src.Wearing=0
						src.Equipped=0
						usr.WeaponBoost = 0
						src.overlays-=src.overlays
						usr.equip_del_Overlay()
						usr.WearingWeapon=0
						usr.SwordOn=0
						for(var/obj/Huds/SkillHuds/SkillHudOne/S in usr.client.screen)
							src.pixel_y=0
							src.pixel_x=0
							S.overlays-=S.overlays
							S.overlays+=new/obj/HudLetter/A
						return
					if(usr.WearingWeapon==1)
						_message(usr,"You are already wearing a weapon","Yellow")
						return
					if(usr.Sword_Skill_Level>=src.WeaponLevel)
						src.Wearing=1
						src.Equipped=1
						usr.SwordOn = 1
						usr.WearingWeapon=1
						for(var/obj/Huds/SkillHuds/SkillHudOne/S in usr.client.screen)
							src.pixel_y+=5
							src.pixel_x+=3
							S.overlays+=src
						usr.equip_add_Overlay()
						src.overlays+=new/obj/Equipped
						usr.WeaponBoost = Boost
					else
						usr<<"Your sword skill needs to be Level [WeaponLevel] to equip this weapon."

				else
					if(src in oview(1))
						if(usr.AvailableItems>=MAXITEMS)
							_message(usr,"You're Holding To Many Items","Yellow")
							return
						else
							usr.AvailableItems+=1
							usr.contents+=src
							if(usr.BagOpen==1)
								usr.AddItems()
		Stone_Spear
			WeaponLevel=1
			Boost=1.5
			icon='JpShopItems.dmi'
			icon_state="Stone Spear"
			Click()
				usr<<sound('Clickitem_statpoints.wav')
				if(src in usr.contents)
					if(src.Wearing==1)
						src.Wearing=0
						src.Equipped=0
						usr.WeaponBoost = 0
						src.overlays-=src.overlays
						usr.equip_del_Overlay()
						usr.WearingWeapon=0
						usr.SpearOn=0
						for(var/obj/Huds/SkillHuds/SkillHudOne/S in usr.client.screen)
							src.pixel_y=0
							src.pixel_x=0
							S.overlays-=S.overlays
							S.overlays+=new/obj/HudLetter/A
						return
					if(usr.WearingWeapon==1)
						_message(usr,"You are already wearing a weapon","Yellow")
						return
					if(usr.Spear_Skill_Level>=src.WeaponLevel)
						src.Wearing=1
						src.Equipped=1
						usr.SpearOn = 1
						usr.WearingWeapon=1
						for(var/obj/Huds/SkillHuds/SkillHudOne/S in usr.client.screen)
							src.pixel_y+=5
							src.pixel_x+=3
							S.overlays+=src
						usr.equip_add_Overlay()
						src.overlays+=new/obj/Equipped
						usr.WeaponBoost = Boost
					else
						usr<<"Your spear skill needs to be Level [WeaponLevel] to equip this weapon."

				else
					if(src in oview(1))
						if(usr.AvailableItems>=MAXITEMS)
							_message(usr,"You're Holding To Many Items","Yellow")
							return
						else
							usr.AvailableItems+=1
							usr.contents+=src
							if(usr.BagOpen==1)
								usr.AddItems()


		Stone_Axe
			WeaponLevel=1
			Boost=2
			icon='JpShopItems.dmi'
			icon_state="Stone Axe"
			Click()
				usr<<sound('Clickitem_statpoints.wav')
				if(src in usr.contents)
					if(src.Wearing==1)
						src.Wearing=0
						src.Equipped=0
						usr.WeaponBoost = 0
						src.overlays-=src.overlays
						usr.equip_del_Overlay()
						usr.WearingWeapon=0
						usr.AxeOn=0
						for(var/obj/Huds/SkillHuds/SkillHudOne/S in usr.client.screen)
							src.pixel_y=0
							src.pixel_x=0
							S.overlays-=S.overlays
							S.overlays+=new/obj/HudLetter/A
						return
					if(usr.WearingWeapon==1)
						_message(usr,"You are already wearing a weapon","Yellow")
						return
					if(usr.Axe_Skill_Level>=src.WeaponLevel)
						src.Wearing=1
						src.Equipped=1
						usr.AxeOn = 1
						usr.WearingWeapon=1
						for(var/obj/Huds/SkillHuds/SkillHudOne/S in usr.client.screen)
							src.pixel_y+=5
							src.pixel_x+=3
							S.overlays+=src
						usr.equip_add_Overlay()
						src.overlays+=new/obj/Equipped
						usr.WeaponBoost = Boost
					else
						usr<<"Your axe skill needs to be Level [WeaponLevel] to equip this weapon."

				else
					if(src in oview(1))
						if(usr.AvailableItems>=MAXITEMS)
							_message(usr,"You're Holding To Many Items","Yellow")
							return
						else
							usr.AvailableItems+=1
							usr.contents+=src
							if(usr.BagOpen==1)
								usr.AddItems()

		Bronze_Sword
			WeaponLevel=5
			Boost=2.5
			icon='JpShopItems.dmi'
			icon_state="Bronze Sword"
			Click()
				usr<<sound('Clickitem_statpoints.wav')
				if(src in usr.contents)
					if(src.Wearing==1)
						src.Wearing=0
						src.Equipped=0
						usr.WeaponBoost = 0
						src.overlays-=src.overlays
						usr.equip_del_Overlay()
						usr.WearingWeapon=0
						usr.SwordOn=0
						for(var/obj/Huds/SkillHuds/SkillHudOne/S in usr.client.screen)
							src.pixel_y=0
							src.pixel_x=0
							S.overlays-=S.overlays
							S.overlays+=new/obj/HudLetter/A
						return
					if(usr.WearingWeapon==1)
						_message(usr,"You are already wearing a weapon","Yellow")
						return
					if(usr.Sword_Skill_Level>=src.WeaponLevel)
						src.Wearing=1
						src.Equipped=1
						usr.SwordOn = 1
						usr.WearingWeapon=1
						for(var/obj/Huds/SkillHuds/SkillHudOne/S in usr.client.screen)
							src.pixel_y+=5
							src.pixel_x+=3
							S.overlays+=src
						usr.equip_add_Overlay()
						src.overlays+=new/obj/Equipped
						usr.WeaponBoost = Boost
					else
						usr<<"Your sword skill needs to be Level [WeaponLevel] to equip this weapon."

				else
					if(src in oview(1))
						if(usr.AvailableItems>=MAXITEMS)
							_message(usr,"You're Holding To Many Items","Yellow")
							return
						else
							usr.AvailableItems+=1
							usr.contents+=src
							if(usr.BagOpen==1)
								usr.AddItems()

		Bronze_Spear
			WeaponLevel=7
			Boost=3
			icon='JpShopItems.dmi'
			icon_state="Bronze Spear"
			Click()
				usr<<sound('Clickitem_statpoints.wav')
				if(src in usr.contents)
					if(src.Wearing==1)
						src.Wearing=0
						src.Equipped=0
						usr.WeaponBoost = 0
						src.overlays-=src.overlays
						usr.equip_del_Overlay()
						usr.WearingWeapon=0
						usr.SpearOn=0
						for(var/obj/Huds/SkillHuds/SkillHudOne/S in usr.client.screen)
							src.pixel_y=0
							src.pixel_x=0
							S.overlays-=S.overlays
							S.overlays+=new/obj/HudLetter/A
						return
					if(usr.WearingWeapon==1)
						_message(usr,"You are already wearing a weapon","Yellow")
						return
					if(usr.Spear_Skill_Level>=src.WeaponLevel)
						src.Wearing=1
						src.Equipped=1
						usr.SpearOn = 1
						usr.WearingWeapon=1
						for(var/obj/Huds/SkillHuds/SkillHudOne/S in usr.client.screen)
							src.pixel_y+=5
							src.pixel_x+=3
							S.overlays+=src
						usr.equip_add_Overlay()
						src.overlays+=new/obj/Equipped
						usr.WeaponBoost = Boost
					else
						usr<<"Your spear skill needs to be Level [WeaponLevel] to equip this weapon."

				else
					if(src in oview(1))
						if(usr.AvailableItems>=MAXITEMS)
							_message(usr,"You're Holding To Many Items","Yellow")
							return
						else
							usr.AvailableItems+=1
							usr.contents+=src
							if(usr.BagOpen==1)
								usr.AddItems()


		Bronze_Axe
			WeaponLevel=9
			Boost=3.5
			icon='JpShopItems.dmi'
			icon_state="Bronze Axe"
			Click()
				usr<<sound('Clickitem_statpoints.wav')
				if(src in usr.contents)
					if(src.Wearing==1)
						src.Wearing=0
						src.Equipped=0
						usr.WeaponBoost = 0
						src.overlays-=src.overlays
						usr.equip_del_Overlay()
						usr.WearingWeapon=0
						usr.AxeOn=0
						for(var/obj/Huds/SkillHuds/SkillHudOne/S in usr.client.screen)
							src.pixel_y=0
							src.pixel_x=0
							S.overlays-=S.overlays
							S.overlays+=new/obj/HudLetter/A
						return
					if(usr.WearingWeapon==1)
						_message(usr,"You are already wearing a weapon","Yellow")
						return
					if(usr.Axe_Skill_Level>=src.WeaponLevel)
						src.Wearing=1
						src.Equipped=1
						usr.AxeOn = 1
						usr.WearingWeapon=1
						for(var/obj/Huds/SkillHuds/SkillHudOne/S in usr.client.screen)
							src.pixel_y+=5
							src.pixel_x+=3
							S.overlays+=src
						usr.equip_add_Overlay()
						src.overlays+=new/obj/Equipped
						usr.WeaponBoost = Boost
					else
						usr<<"Your axe skill needs to be Level [WeaponLevel] to equip this weapon."

				else
					if(src in oview(1))
						if(usr.AvailableItems>=MAXITEMS)
							_message(usr,"You're Holding To Many Items","Yellow")
							return
						else
							usr.AvailableItems+=1
							usr.contents+=src
							if(usr.BagOpen==1)
								usr.AddItems()


		Iron_Sword
			WeaponLevel=13
			Boost=4
			icon='JpShopItems.dmi'
			icon_state="Iron Sword"
			Click()
				usr<<sound('Clickitem_statpoints.wav')
				if(src in usr.contents)
					if(src.Wearing==1)
						src.Wearing=0
						src.Equipped=0
						usr.WeaponBoost = 0
						src.overlays-=src.overlays
						usr.equip_del_Overlay()
						usr.WearingWeapon=0
						usr.SwordOn=0
						for(var/obj/Huds/SkillHuds/SkillHudOne/S in usr.client.screen)
							src.pixel_y=0
							src.pixel_x=0
							S.overlays-=S.overlays
							S.overlays+=new/obj/HudLetter/A
						return
					if(usr.WearingWeapon==1)
						_message(usr,"You are already wearing a weapon","Yellow")
						return
					if(usr.Sword_Skill_Level>=src.WeaponLevel)
						src.Wearing=1
						src.Equipped=1
						usr.SwordOn = 1
						usr.WearingWeapon=1
						for(var/obj/Huds/SkillHuds/SkillHudOne/S in usr.client.screen)
							src.pixel_y+=5
							src.pixel_x+=3
							S.overlays+=src
						usr.equip_add_Overlay()
						src.overlays+=new/obj/Equipped
						usr.WeaponBoost = Boost
					else
						usr<<"Your sword skill needs to be Level [WeaponLevel] to equip this weapon."

				else
					if(src in oview(1))
						if(usr.AvailableItems>=MAXITEMS)
							_message(usr,"You're Holding To Many Items","Yellow")
							return
						else
							usr.AvailableItems+=1
							usr.contents+=src
							if(usr.BagOpen==1)
								usr.AddItems()

		Iron_Spear
			WeaponLevel=16
			Boost=4.5
			icon='JpShopItems.dmi'
			icon_state="Iron Spear"
			Click()
				usr<<sound('Clickitem_statpoints.wav')
				if(src in usr.contents)
					if(src.Wearing==1)
						src.Wearing=0
						src.Equipped=0
						usr.WeaponBoost = 0
						src.overlays-=src.overlays
						usr.equip_del_Overlay()
						usr.WearingWeapon=0
						usr.SpearOn=0
						for(var/obj/Huds/SkillHuds/SkillHudOne/S in usr.client.screen)
							src.pixel_y=0
							src.pixel_x=0
							S.overlays-=S.overlays
							S.overlays+=new/obj/HudLetter/A
						return
					if(usr.WearingWeapon==1)
						_message(usr,"You are already wearing a weapon","Yellow")
						return
					if(usr.Spear_Skill_Level>=src.WeaponLevel)
						src.Wearing=1
						src.Equipped=1
						usr.SpearOn = 1
						usr.WearingWeapon=1
						for(var/obj/Huds/SkillHuds/SkillHudOne/S in usr.client.screen)
							src.pixel_y+=5
							src.pixel_x+=3
							S.overlays+=src
						usr.equip_add_Overlay()
						src.overlays+=new/obj/Equipped
						usr.WeaponBoost = Boost
					else
						usr<<"Your spear skill needs to be Level [WeaponLevel] to equip this weapon."

				else
					if(src in oview(1))
						if(usr.AvailableItems>=MAXITEMS)
							_message(usr,"You're Holding To Many Items","Yellow")
							return
						else
							usr.AvailableItems+=1
							usr.contents+=src
							if(usr.BagOpen==1)
								usr.AddItems()

		Iron_Axe
			WeaponLevel=19
			Boost=5
			icon='JpShopItems.dmi'
			icon_state="Iron Axe"
			Click()
				usr<<sound('Clickitem_statpoints.wav')
				if(src in usr.contents)
					if(src.Wearing==1)
						src.Wearing=0
						src.Equipped=0
						usr.WeaponBoost = 0
						src.overlays-=src.overlays
						usr.equip_del_Overlay()
						usr.WearingWeapon=0
						usr.AxeOn=0
						for(var/obj/Huds/SkillHuds/SkillHudOne/S in usr.client.screen)
							src.pixel_y=0
							src.pixel_x=0
							S.overlays-=S.overlays
							S.overlays+=new/obj/HudLetter/A
						return
					if(usr.WearingWeapon==1)
						_message(usr,"You are already wearing a weapon","Yellow")
						return
					if(usr.Axe_Skill_Level>=src.WeaponLevel)
						src.Wearing=1
						src.Equipped=1
						usr.AxeOn = 1
						usr.WearingWeapon=1
						for(var/obj/Huds/SkillHuds/SkillHudOne/S in usr.client.screen)
							src.pixel_y+=5
							src.pixel_x+=3
							S.overlays+=src
						usr.equip_add_Overlay()
						src.overlays+=new/obj/Equipped
						usr.WeaponBoost = Boost
					else
						usr<<"Your axe skill needs to be Level [WeaponLevel] to equip this weapon."

				else
					if(src in oview(1))
						if(usr.AvailableItems>=MAXITEMS)
							_message(usr,"You're Holding To Many Items","Yellow")
							return
						else
							usr.AvailableItems+=1
							usr.contents+=src
							if(usr.BagOpen==1)
								usr.AddItems()



		Bow
			icon_state="Bow"
			DblClick()
			Click()
				usr<<sound('Clickitem_statpoints.wav')
				if(src in usr.contents)
					if(src.Wearing==1)
						src.Wearing=0
						src.Equipped=0
						usr.WeaponBoost = 0
						usr.WearingWeapon=0
						src.overlays-=src.overlays
						usr.BowOn=0
						for(var/obj/Huds/SkillHuds/SkillHudOne/S in usr.client.screen)
							src.pixel_y=0
							src.pixel_x=0
							S.overlays-=S.overlays
							S.overlays+=new/obj/HudLetter/A
						return
					if(usr.WearingWeapon==1)
						_message(usr,"You are already wearing a weapon","Yellow")
						return
					src.Wearing=1
					usr.WearingWeapon=1
					for(var/obj/Huds/SkillHuds/SkillHudOne/S in usr.client.screen)
						src.pixel_y+=5
						src.pixel_x+=3
						S.overlays+=src
					src.overlays+=new/obj/Equipped
					usr.BowOn=1
					usr.BowBoost = WeaponLevel * 5
					usr.Strength += usr.BowBoost

				else
					if(src in oview(1))
						if(usr.AvailableItems>=MAXITEMS)
							_message(usr,"You're holding too many items!","Yellow")
							return
						else
							usr.AvailableItems+=1
							usr.contents+=src
							if(usr.BagOpen==1)
								usr.AddItems()




obj/Projectiles
	density=1
	Arrow
		icon='Weapons.dmi'
		icon_state="Arrow"
		New()
			spawn(30)
				del(src)
			..()

		Bump(atom/a)
			if(istype(a,/obj/))
				del(src)
				return
			else
				if(istype(a,/mob/))
					var/mob/M=a
					if(M==src.Owner)
						del(src)
						return
					if(M.NPC == 1)
						del(src)
						return
					if(M.Dead== 1)
						del(src)
						return
					if(M.Dying== 1)
						del(src)
						return
					else
						if(M.Blocking)
							for(var/mob/S in world)
								if(S==src.Owner)
									var/tmp/damage=round(S.Strength-M.Defense)/2
									if(damage<=0)
										damage=rand(1,50)
									M.Health-=damage
									M.DeathCheck(src.Owner,M)
									del(src)
									return
						else
							for(var/mob/S in world)
								if(S==src.Owner)
									var/tmp/damage=round(S.Strength-M.Defense)/1.5
									if(damage<=0)
										damage=rand(1,50)
									M.Health-=damage
									M.DeathCheck(src.Owner,M)
									del(src)
									return

