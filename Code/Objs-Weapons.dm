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
mob/verb
	PickUp()
		if(usr.Dying)
			return
		for(var/obj/Gold/G in oview(1))
			usr.Gold+=G.Amount
			usr<<sound('pickupcoin.wav')
			del(G)
		for(var/obj/Items/O in oview(1))
			if(!O.CanPickUp)
				return
			if(usr.AvailableItems>=usr.MaxItems)
				_message(usr,"You're holding too many items","Yellow")
				return
			else
				usr.AvailableItems+=1
				usr.contents+=O
				QuestItemPickup()
				if(usr.BagOpen==1)
					usr.AddItems()
					return
//Items that get dropped
obj/Items/ItemDrops
	Fox_Fur
		icon='ItemDrops.dmi'
		icon_state="foxfur"
		name="Fox Fur"
		Click()
			if(src in oview(1))
				if(usr.AvailableItems>=usr.MaxItems)
					_message(usr,"You're holding too many Items","Yellow")
					return
				else
					usr.AvailableItems+=1
					usr.contents+=src
					if(usr.BagOpen==1)
						usr.AddItems()
	Small_Stick
		icon='ItemDrops.dmi'
		icon_state="smallstick"
		name="Small Stick"
		Click()
			if(src in oview(1))
				if(usr.AvailableItems>=usr.MaxItems)
					_message(usr,"You're holding too many Items","Yellow")
					return
				else
					usr.AvailableItems+=1
					usr.contents+=src
					if(usr.BagOpen==1)
						usr.AddItems()

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
				usr.AvailableItems-=1
				usr.QuestItemDrop()
				src.loc = usr.loc
				usr.AddItems()
				usr.CreateInventory()
				usr.CreateInventory()
	//Buildable
	Wood_Crafting_Table
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
						if(usr.AvailableItems>=usr.MaxItems)
							_message(usr,"You're holding too many items!","Yellow")
							return
						else
							usr.AvailableItems+=1
							usr.contents+=src
							if(usr.BagOpen==1)
								usr.AddItems()

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
						if(usr.AvailableItems>=usr.MaxItems)
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
						if(usr.AvailableItems>=usr.MaxItems)
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
						if(usr.AvailableItems>=usr.MaxItems)
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
					if(usr.AvailableItems>=usr.MaxItems)
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
		layer=17
		Weight=25
		Fox_Fur_Tunic
			icon='JpShopItems.dmi'
			icon_state="fftunic"
			Click()
				usr<<sound('Clickitem_statpoints.wav')
				if(src in usr.contents)
					if(src.Wearing==1)
						src.Wearing=0
						src.overlays-=src.overlays
						usr.WearingShirt=0
						usr.Defense-=10
						for(var/obj/Huds/SkillHuds/SkillHudOne/S in usr.client.screen)
							src.pixel_y=0
							src.pixel_x=0
							S.overlays-=S.overlays
							S.overlays+=new/obj/HudLetter/A
						return
					if(usr.WearingShirt==1)
						_message(usr,"You're Already Wearing A Shirt!","Yellow")
						return
					src.Wearing=1
					usr.WearingShirt=1
					for(var/obj/Huds/SkillHuds/SkillHudOne/S in usr.client.screen)
						src.pixel_y+=5
						src.pixel_x+=3
						S.overlays+=src
					src.overlays+=new/obj/Equipped
					usr.Defense+=10
				else
					if(src in oview(1))
						if(usr.AvailableItems>=usr.MaxItems)
							_message(usr,"You're holding too many items","Yellow")
							return
						else
							usr.AvailableItems+=1
							usr.contents+=src
							if(usr.BagOpen==1)
								usr.AddItems()

	Weapons
		icon='Weapons.dmi'
		WeaponLevel=1
		layer=17
		Weight=25
		Wooden_Sword
			icon='JpShopItems.dmi'
			icon_state="trainingstaff"
			Click()
				usr<<sound('Clickitem_statpoints.wav')
				if(src in usr.contents)
					if(src.Wearing==1)
						src.Wearing=0
						usr.Strength-=usr.StaffBoost
						src.overlays-=src.overlays
						usr.WearingWeapon=0
						usr.SwordOn=0
						for(var/obj/Huds/SkillHuds/SkillHudOne/S in usr.client.screen)
							src.pixel_y=0
							src.pixel_x=0
							S.overlays-=S.overlays
							S.overlays+=new/obj/HudLetter/A
						return
					if(usr.WearingWeapon==1)
						_message(usr,"You're Already Wearing A Weapon","Yellow")
						return
					src.Wearing=1
					usr.SwordOn = 1
					usr.WearingWeapon=1
					for(var/obj/Huds/SkillHuds/SkillHudOne/S in usr.client.screen)
						src.pixel_y+=5
						src.pixel_x+=3
						S.overlays+=src
					src.overlays+=new/obj/Equipped
					usr.StaffBoost = 5 + WeaponLevel * 5
					usr.Strength += usr.StaffBoost

				else
					if(src in oview(1))
						if(usr.AvailableItems>=usr.MaxItems)
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
						usr.Strength-=usr.BowBoost
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
						_message(usr,"You're Already Wearing A Weapon","Yellow")
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
						if(usr.AvailableItems>=usr.MaxItems)
							_message(usr,"You're holding too many items!","Yellow")
							return
						else
							usr.AvailableItems+=1
							usr.contents+=src
							if(usr.BagOpen==1)
								usr.AddItems()

		RStaff
			icon='JpShopItems.dmi'
			icon_state="redoakstaff"
			Click()
				usr<<sound('Clickitem_statpoints.wav')
				if(src in usr.contents)
					if(src.Wearing==1)
						src.Wearing=0
						usr.WearingWeapon=0
						usr.Strength-=usr.SwordBoost
						src.overlays-=src.overlays
						usr.SwordOn=0
						for(var/obj/Huds/SkillHuds/SkillHudOne/S in usr.client.screen)
							src.pixel_y=0
							src.pixel_x=0
							S.overlays-=S.overlays
							S.overlays+=new/obj/HudLetter/A
						return
					if(usr.WearingWeapon==1)
						_message(usr,"Your Already Wearing A Weapon","Yellow")
						return
					src.Wearing=1
					usr.SwordOn=1
					usr.WearingWeapon=1
					for(var/obj/Huds/SkillHuds/SkillHudOne/S in usr.client.screen)
						src.pixel_y+=5
						src.pixel_x+=3
						S.overlays+=src
					src.overlays+=new/obj/Equipped
					if(WeaponLevel==1)
						usr.SwordBoost=15
						usr.Strength+=15
				else
					if(src in oview(1))
						if(usr.AvailableItems>=usr.MaxItems)
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

