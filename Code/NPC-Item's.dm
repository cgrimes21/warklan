obj/var
	Des=""
	Req=8
mob
	var
		ShowingInfo=0
mob
	proc
		IteminfoAlign()
			spawn while(src.ShowingInfo)
				if(!src){return}
				if(!client){return}
				var/a=winget(src,"Main","pos")
				var/chatx=text2num(copytext(a,1,","))
				if(!src){return}
				if(!client){return}
				var/chaty=text2num(copytext(a,findtext(a,",")+1))
				if(!src){return}
				if(!client){return}
				winset(src,"Item","pos=[chatx+220],[chaty+215]")
				sleep(world.tick_lag)


obj/NPCs/Items
	icon='Items.dmi'
	WeaponLevel=1
	layer=16
	MouseEntered()
		usr.ShowingInfo=1
		winset(usr,"Item","is-visible=true")
		usr.IteminfoAlign()
		winset(usr,"Item.Name","text = ' [src.name]'")
		winset(usr,"Item.Level","text = ' Level: [WeaponLevel]'")
		winset(usr,"Item.Materials","text = ' [src.MaterialsRequired] Needed'")
		usr<<output(null,"Item.ItemInfo")
		usr<<output("[src.Des]     <font size=+1><font color=yellow>Click To Purchase!</font></font>","Item.ItemInfo")
	MouseExited()
		usr.ShowingInfo=0
		winset(usr,"Item","is-visible=false")

	Stone_Sword
		name="Stone Sword"
		Weight=25
		MaterialsRequired="3 Stones"
		Des="Stone Sword"
		icon='JpShopItems.dmi'
		icon_state="Stone Sword"
		Click()
			usr.Clicking()
			if(usr.AvailableItems>=usr.MaxItems)
				_message(usr,"You're holding too many items!","Yellow")
				return
			if(count_minerals("Stone",usr)>=3)
				usr.QuestItemDelete()
				var/obj/Items/Weapons/Stone_Sword/A=new/obj/Items/Weapons/Stone_Sword
				usr.AvailableItems+=1
				usr.contents+=A
				if(usr.BagOpen==1)
					usr.AddItems()
				_message(usr,"You've received a Stone Sword.","Yellow")
				return
			else
				_message(usr,"You'll need [src.MaterialsRequired].","Yellow")

	Stone_Spear
		name="Stone Spear"
		Weight=25
		MaterialsRequired="7 Stones"
		Des="Stone Spear"
		icon='JpShopItems.dmi'
		icon_state="Stone Spear"
		Click()
			usr.Clicking()
			if(usr.AvailableItems>=usr.MaxItems)
				_message(usr,"You're holding too many items!","Yellow")
				return
			if(count_minerals("Stone",usr)>=3)
				var/obj/Items/Weapons/Stone_Spear/A=new/obj/Items/Weapons/Stone_Spear
				usr.AvailableItems+=1
				usr.contents+=A
				if(usr.BagOpen==1)
					usr.AddItems()
				_message(usr,"You've received a Stone Spear.","Yellow")
				return
			else
				_message(usr,"You'll need [src.MaterialsRequired].","Yellow")

	Stone_Axe
		name="Stone Axe"
		Weight=25
		MaterialsRequired="12 Stones"
		Des="Stone Axe"
		icon='JpShopItems.dmi'
		icon_state="Stone Axe"
		Click()
			usr.Clicking()
			if(usr.AvailableItems>=usr.MaxItems)
				_message(usr,"You're holding too many items!","Yellow")
				return
			if(count_minerals("Stone",,usr)>=3)
				var/obj/Items/Weapons/Stone_Axe/A=new/obj/Items/Weapons/Stone_Axe
				usr.AvailableItems+=1
				usr.contents+=A
				if(usr.BagOpen==1)
					usr.AddItems()
				_message(usr,"You've received a Stone Axe.","Yellow")
				return
			else
				_message(usr,"You'll need [src.MaterialsRequired].","Yellow")

	Bronze_Sword
		name="Bronze Sword"
		Weight=25
		MaterialsRequired="5 Bronze Bars"
		Des="Bronze Sword"
		icon='JpShopItems.dmi'
		icon_state="Bronze Sword"
		Click()
			usr.Clicking()
			if(usr.AvailableItems>=usr.MaxItems)
				_message(usr,"You're holding too many items!","Yellow")
				return
			if(count_minerals("Bronze",usr)>=3)
				usr.QuestItemDelete()
				var/obj/Items/Weapons/Bronze_Sword/A=new/obj/Items/Weapons/Bronze_Sword
				usr.AvailableItems+=1
				usr.contents+=A
				if(usr.BagOpen==1)
					usr.AddItems()
				_message(usr,"You've received a Bronze Sword.","Yellow")
				return
			else
				_message(usr,"You'll need [src.MaterialsRequired].","Yellow")

	Bronze_Spear
		name="Bronze Spear"
		Weight=25
		MaterialsRequired="10 Bronze Bars"
		Des="Bronze Spear"
		icon='JpShopItems.dmi'
		icon_state="Bronze Spear"
		Click()
			usr.Clicking()
			if(usr.AvailableItems>=usr.MaxItems)
				_message(usr,"You're holding too many items!","Yellow")
				return
			if(count_minerals("Bronze",usr)>=3)
				var/obj/Items/Weapons/Bronze_Spear/A=new/obj/Items/Weapons/Bronze_Spear
				usr.AvailableItems+=1
				usr.contents+=A
				if(usr.BagOpen==1)
					usr.AddItems()
				_message(usr,"You've received a Bronze Spear.","Yellow")
				return
			else
				_message(usr,"You'll need [src.MaterialsRequired].","Yellow")

	Bronze_Axe
		name="Bronze Axe"
		Weight=25
		MaterialsRequired="15 Bronze Bars"
		Des="Bronze Axe"
		icon='JpShopItems.dmi'
		icon_state="Bronze Axe"
		Click()
			usr.Clicking()
			if(usr.AvailableItems>=usr.MaxItems)
				_message(usr,"You're holding too many items!","Yellow")
				return
			if(count_minerals("Bronze",usr)>=3)
				var/obj/Items/Weapons/Bronze_Axe/A=new/obj/Items/Weapons/Bronze_Axe
				usr.AvailableItems+=1
				usr.contents+=A
				if(usr.BagOpen==1)
					usr.AddItems()
				_message(usr,"You've received a Bronze Axe.","Yellow")
				return
			else
				_message(usr,"You'll need [src.MaterialsRequired].","Yellow")


	Iron_Sword
		name="Iron Sword"
		Weight=25
		MaterialsRequired="10 Iron Bars"
		Des="Iron Sword"
		icon='JpShopItems.dmi'
		icon_state="Iron Sword"
		Click()
			usr.Clicking()
			if(usr.AvailableItems>=usr.MaxItems)
				_message(usr,"You're holding too many items!","Yellow")
				return
			if(count_minerals("Iron",,usr)>=3)
				usr.QuestItemDelete()
				var/obj/Items/Weapons/Iron_Sword/A=new/obj/Items/Weapons/Iron_Sword
				usr.AvailableItems+=1
				usr.contents+=A
				if(usr.BagOpen==1)
					usr.AddItems()
				_message(usr,"You've received a Iron Sword.","Yellow")
				return
			else
				_message(usr,"You'll need [src.MaterialsRequired].","Yellow")

	Iron_Spear
		name="Iron Spear"
		Weight=25
		MaterialsRequired="15 Iron Bars"
		Des="Iron Spear"
		icon='JpShopItems.dmi'
		icon_state="Iron Spear"
		Click()
			usr.Clicking()
			if(usr.AvailableItems>=usr.MaxItems)
				_message(usr,"You're holding too many items!","Yellow")
				return
			if(count_minerals("Iron",usr)>=3)
				var/obj/Items/Weapons/Iron_Spear/A=new/obj/Items/Weapons/Iron_Spear
				usr.AvailableItems+=1
				usr.contents+=A
				if(usr.BagOpen==1)
					usr.AddItems()
				_message(usr,"You've received a Iron Spear.","Yellow")
				return
			else
				_message(usr,"You'll need [src.MaterialsRequired].","Yellow")

	Iron_Axe
		name="Iron Axe"
		Weight=25
		MaterialsRequired="20 Iron Bars"
		Des="Iron Axe"
		icon='JpShopItems.dmi'
		icon_state="Iron Axe"
		Click()
			usr.Clicking()
			if(usr.AvailableItems>=usr.MaxItems)
				_message(usr,"You're holding too many items!","Yellow")
				return
			if(count_minerals("Iron",usr)>=3)
				var/obj/Items/Weapons/Iron_Axe/A=new/obj/Items/Weapons/Iron_Axe
				usr.AvailableItems+=1
				usr.contents+=A
				if(usr.BagOpen==1)
					usr.AddItems()
				_message(usr,"You've received a Iron Axe.","Yellow")
				return
			else
				_message(usr,"You'll need [src.MaterialsRequired].","Yellow")

	Fox_Cub_Tunic
		name="Fox Cub Tunic"
		Weight=25
		MaterialsRequired="3 Fox Furs"
		Des="Fox Cub Tunic"
		icon='JpShopItems.dmi'
		icon_state="fctunic"
		Click()
			usr.Clicking()
			if(usr.AvailableItems>=usr.MaxItems)
				_message(usr,"You're holding too many items!","Yellow")
				return
			if(count_furs("Fox Cub Furs",usr)>=3)
				usr.QuestItemDelete()
				var/obj/Items/Clothing/Fox_Cub_Tunic/A=new/obj/Items/Clothing/Fox_Cub_Tunic
				usr.AvailableItems+=1
				usr.contents+=A
				if(usr.BagOpen==1)
					usr.AddItems()
				_message(usr,"You've received a Fox Cub Tunic.","Yellow")
				return
			else
				_message(usr,"You'll need [src.MaterialsRequired].","Yellow")

	Red_Fox_Coat
		name="Red Fox Coat"
		Weight=25
		MaterialsRequired="7 Red Fox Furs"
		Des="Fox Fur Tunic"
		icon='JpShopItems.dmi'
		icon_state="rfcoat"
		Click()
			usr.Clicking()
			if(usr.AvailableItems>=usr.MaxItems)
				_message(usr,"You're holding too many items!","Yellow")
				return
			if(count_furs("Red Fox Furs",usr)>=7)
				usr.QuestItemDelete()
				var/obj/Items/Clothing/Red_Fox_Coat/A=new/obj/Items/Clothing/Red_Fox_Coat
				usr.AvailableItems+=1
				usr.contents+=A
				if(usr.BagOpen==1)
					usr.AddItems()
				_message(usr,"You've received a Red Fox Coat.","Yellow")
				return
			else
				_message(usr,"You'll need [src.MaterialsRequired].","Yellow")


	Wolf_Fur_Coat
		name="Wolf Fur Coat"
		Weight=25
		MaterialsRequired="7 Wolf Furs"
		Des="Wolf Fur Coat"
		icon='JpShopItems.dmi'
		icon_state="wfcoat"
		Click()
			usr.Clicking()
			if(usr.AvailableItems>=usr.MaxItems)
				_message(usr,"You're holding too many items!","Yellow")
				return
			if(count_furs("Mountain Wolf Furs",usr)>=7)
				usr.QuestItemDelete()
				var/obj/Items/Clothing/Wolf_Fur_Coat/A=new/obj/Items/Clothing/Wolf_Fur_Coat
				usr.AvailableItems+=1
				usr.contents+=A
				if(usr.BagOpen==1)
					usr.AddItems()
				_message(usr,"You've received a Wolf Fur Coat.","Yellow")
				return
			else
				_message(usr,"You'll need [src.MaterialsRequired].","Yellow")


	Bow
		Weight=25
		icon_state="Bow"
		Click()
			usr<<sound('Clickitem_statpoints.wav')
			if(usr.AvailableItems>=usr.MaxItems)
				_message(usr,"You're holding too many items!","Yellow")
				return
			if(usr.Gold>=src.Cost)
				var/obj/Items/Weapons/Bow/A=new/obj/Items/Weapons/Bow
				usr.AvailableItems+=1
				usr.contents+=A
				if(usr.BagOpen==1)
					usr.AddItems()
				return
			else
				_message(usr,"You Don't Have The Right Amount Of Gold","Yellow")

	Potion
		Cost=5
		Weight=5
		Req=1
		Des="Heals Your Health"
		icon='JPShopItems.dmi'
		icon_state="healingherb"
		Click()
			usr<<sound('Clickitem_statpoints.wav')
			if(usr.AvailableItems>=usr.MaxItems)
				_message(usr,"You're holding too many items!","Yellow")
				return
			if(usr.Gold>=src.Cost)
				switch(alert("Are You Sure You Would Like To Buy This Item",,"Yes","No"))
					if("No")
						return
					if("Yes")
						var/obj/Items/Doctor/Potion/A=new/obj/Items/Doctor/Potion
						usr.AvailableItems+=1
						usr.contents+=A
						usr.Gold-=src.Cost
						if(usr.BagOpen==1)
							usr.AddItems()
						return
					else
						_message(usr,"You Don't Have The Right Amount Of Gold","Yellow")
	Buff
		Cost=10
		Weight=5
		Des="Buffs Your Strength Temporary"
		icon='JPShopItems.dmi'
		icon_state="vigorizingherb"
		Click()
			usr<<sound('Clickitem_statpoints.wav')
			if(usr.AvailableItems>=usr.MaxItems)
				_message(usr,"You're holding too many items!","Yellow")
				return
			if(usr.Gold>=src.Cost)
				switch(alert("Are You Sure You Would Like To Buy This Item",,"Yes","No"))
					if("No")
						return
					if("Yes")
						var/obj/Items/Witch_Doctor/Buff/A=new/obj/Items/Witch_Doctor/Buff
						usr.AvailableItems+=1
						usr.contents+=A
						usr.Gold-=src.Cost
						if(usr.BagOpen==1)
							usr.AddItems()
						return
					else
						_message(usr,"You Don't Have The Right Amount Of Gold","Yellow")
	Sack
		Cost=15
		Weight=1
		Req=1
		Des="Raises Your Inventory Space And How Much Weight You Can Hold"
		icon_state="Sack"
		Click()
			usr<<sound('Clickitem_statpoints.wav')
			if(usr.AvailableItems>=usr.MaxItems)
				_message(usr,"You're holding too many items!","Yellow")
				return
			if(usr.Gold>=src.Cost)
				switch(alert("Are You Sure You Would Like To Buy This Item",,"Yes","No"))
					if("No")
						return
					if("Yes")
						var/obj/Items/Tailor/Sack/A=new/obj/Items/Tailor/Sack
						usr.contents+=A
						usr.AvailableItems+=1
						usr.Gold-=src.Cost
						if(usr.BagOpen==1)
							usr.AddItems()
						return
					else
						_message(usr,"You Don't Have The Right Amount Of Gold","Yellow")