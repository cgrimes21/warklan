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

	Wooden_Sword
		name="Wooden Sword"
		Weight=25
		MaterialsRequired="3 Small Sticks"
		Des="Wooden Sword"
		icon='JpShopItems.dmi'
		icon_state="trainingstaff"
		Click()
			usr<<sound('Clickitem_statpoints.wav')
			if(usr.AvailableItems>=usr.MaxItems)
				_message(usr,"You're holding too many items!","Yellow")
				return
			if(usr.SmallSticksCollected>=3)
				usr.QuestItemDelete()
				var/obj/Items/Weapons/Wooden_Sword/A=new/obj/Items/Weapons/Wooden_Sword
				usr.AvailableItems+=1
				usr.contents+=A
				if(usr.BagOpen==1)
					usr.AddItems()
				if(usr.DoingQuest==1&&usr.QuestLevel==2&&usr.BoughtWoodenSword==0)
					usr.BoughtWoodenSword=1
				_message(usr,"You've received a wooden sword.","Yellow")
				return
			else
				_message(usr,"You'll need [src.MaterialsRequired].","Yellow")


	Fox_Fur_Tunic
		name="Fox Fur Tunic"
		Weight=25
		MaterialsRequired="3 Fox Furs"
		Des="Fox Fur Tunic"
		icon='JpShopItems.dmi'
		icon_state="fftunic"
		Click()
			usr<<sound('Clickitem_statpoints.wav')
			if(usr.AvailableItems>=usr.MaxItems)
				_message(usr,"You're holding too many items!","Yellow")
				return
			if(count_fox_furs(usr)>=3)
				usr.QuestItemDelete()
				var/obj/Items/Clothing/Fox_Fur_Tunic/A=new/obj/Items/Clothing/Fox_Fur_Tunic
				usr.AvailableItems+=1
				usr.contents+=A
				if(usr.BagOpen==1)
					usr.AddItems()
				if(usr.DoingQuest==1&&usr.QuestLevel==1&&usr.BoughtFoxFurTunic==0)
					usr.BoughtFoxFurTunic=1
				_message(usr,"You've received a fox fur tunic.","Yellow")
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