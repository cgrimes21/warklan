obj/!
	icon='!.dmi'
	layer=150
	pixel_y=20
mob
	proc
		Quests()
			spawn while(src)
				for(var/image/S in src.client.images)
					if(S.icon =='!.dmi')
						del(S)
				if(src.ElderNPC)
					for(var/mob/NPCS/QUEST/Monk/M in oview())
						var/image/I = image('!.dmi',M)
						I.pixel_y=34
						I.pixel_x=27
						usr<<I
				sleep(10)


mob/var
	tmp/QuestMenuUp=0
	//Tutorial
	QuestLevel=1
	DoingQuest=0
	FoxFurCollected=0
	SmallSticksCollected=0
	WolfKilled=0
	FoxKilled=0
	ElderNPC=1
	WeaponNPC=0
	EnemiesKilled=0
	BoughtWoodenSword=0
	BoughtFoxFurTunic=0
	SecondQuestOver=0
	ThirdQuestOver=0


mob/proc
	BeginningQuests(T as text)
		winset(src,"QuestMenu","is-visible=true")
		spawn while(src.QuestMenuUp==1)
			var/a=winget(src,"Main","pos")
			var/chatx=text2num(copytext(a,1,","))
			var/chaty=text2num(copytext(a,findtext(a,",")+1))
			winset(src,"QuestMenu","pos=[chatx+180],[chaty+237]")
			sleep(world.tick_lag)
		if(T=="FurQuest")
			var/icon/my_icon2 = icon('Icons/Quest_Rewards/FoxFurTunic.dmi')
			var/file_reference2 = fcopy_rsc(my_icon2)
			winset(src,"QuestMenu.RewardOne","image=\ref[file_reference2]")
			src<< output(null,"QuestMenu.Info")

			if(src.FoxFurCollected>=3)
				if(!usr.BoughtFoxFurTunic)
					src<< output("<center>You've retrieved the furs! Take them to the sewing table and create a tunic.</center>","QuestMenu.Info")
				else
					src<< output("<center>Great work! You've gotten the tunic, now let's get you a weapon. </center>","QuestMenu.Info")
					winset(src,"QuestMenu.RewardOne","image=\ref[file_reference2]")
					winset(src,"QuestMenu.Accept","is-visible=true")
					winset(src,"QuestMenu.Accept","text=Complete")
					winset(usr,"QuestMenu.Deny","is-visible=false")

			else
				src<< output("<center>Ah, hello [usr.Name], you've grown into a fine young man indeed! However I think it's time for you to leave home and make your own legend, and time for you to create your own clan and stories of glory! Hm, but in order to do so, you'll need stronger clothing, and a weapon. Why don't you go and get 3 fox skins for me. You can get them from the foxes to your right.</center>","QuestMenu.Info")
				winset(src,"QuestMenu.Accept","is-visible=true")
				winset(usr,"QuestMenu.Deny","is-visible=true")

		if(T=="WoodenSwordQuest")
			var/icon/my_icon2 = icon('Icons/Quest_Rewards/FoxFurTunic.dmi')
			var/file_reference2 = fcopy_rsc(my_icon2)
			winset(src,"QuestMenu.RewardOne","image=\ref[file_reference2]")
			src<< output(null,"QuestMenu.Info")

			if(src.SmallSticksCollected>=3)
				if(!usr.BoughtWoodenSword)
					src<< output("<center>You've retrieved the sticks! Take them to the crafting table and create a wooden sword.</center>","QuestMenu.Info")
				else
					src<< output("<center>Good job! That weapon should do you well. If you need to purchase anything else you can always speak with the craftsman. Using that weapon will level up your sword skill and make it stronger, allowing you to wield better weapons. Press the S button to view your skill levels.</center>","QuestMenu.Info")
					winset(src,"QuestMenu.RewardOne","image=\ref[file_reference2]")
					winset(src,"QuestMenu.Accept","is-visible=true")
					winset(src,"QuestMenu.Accept","text=Complete")
					winset(usr,"QuestMenu.Deny","is-visible=false")
					usr.SecondQuestOver=1
			else
				src<< output("<center>So let's see...we've gotten you some clothing, now it's time to get you a decent weapon! Why don't we craft you a wooden sword? Go and get 3 small sticks, they're usually dropped by Wolves.</center>","QuestMenu.Info")
				winset(src,"QuestMenu.Accept","is-visible=true")
				winset(usr,"QuestMenu.Deny","is-visible=true")

		if(T=="CreateClanQuest")
			src<< output(null,"QuestMenu.Info")

			if(src.InClan)
				src<< output("<center>Ah great, you've finally created a clan of your own. Clans can build fortifications and objects, but they may require resources such as wood, iron, gold, etc, or clan points gained from killing rival clan members. Press B to activate the 'Clan Building' Menu</center>","QuestMenu.Info")
				winset(src,"QuestMenu.Accept","is-visible=true")
				winset(src,"QuestMenu.Accept","text=Complete")
				winset(usr,"QuestMenu.Deny","is-visible=false")
				usr.ThirdQuestOver=1
			else
				src<< output("<center>I've seen your progress! You've grown very quickly. I think you're ready to form your own clan. Clans are the driving force in this world. You can create a clan of warriors that beat other clans into submission, a clan of conquerers that takes over the world, the possibilities are endless. Speak to the Clan Chief, and he'll start the process.</center>","QuestMenu.Info")
				winset(src,"QuestMenu.Accept","is-visible=true")
				winset(usr,"QuestMenu.Deny","is-visible=true")


	QuestItemDrop()
		if(src.DoingQuest&&src.QuestLevel==1)
			for(var/obj/Items/ItemDrops/Fox_Fur/A in src.contents)
				//src.FoxFurCollected-=1
				usr<<"[usr.FoxFurCollected]/3"

		if(src.DoingQuest&&src.QuestLevel==2)
			for(var/obj/Items/ItemDrops/Small_Stick/B in src.contents)
				//src.SmallSticksCollected-=1
				usr<<"[usr.SmallSticksCollected]/3"



	QuestItemPickup()
		if(src.DoingQuest&&src.QuestLevel==1)
			for(var/obj/Items/ItemDrops/Fox_Fur/B in src.contents)
				src.FoxFurCollected+=1
				_message(src, "<font color=green>Fox Furs Collected: [FoxFurCollected]/3</font>","white")
				if(FoxFurCollected>=3)
					src.ElderNPC=1
				return

		if(src.DoingQuest&&src.QuestLevel==2)
			for(var/obj/Items/ItemDrops/Small_Stick/B in src.contents)
				src.SmallSticksCollected++
				_message(src, "<font color=green>Small Sticks Collected: [src.SmallSticksCollected]/3</font>","white")
				if(src.SmallSticksCollected>=3)
					src.ElderNPC=1
				return

	QuestItemDelete()
		if(src.DoingQuest&&src.QuestLevel==1)
			var/counter = 0
			for(var/obj/Items/ItemDrops/Fox_Fur/B in src.contents)
				counter++
				if(counter <= 3)
					del B
					if(src.BagOpen==1)
						usr.AddItems()
					src.AvailableItems-=1
					src.CreateInventory()


		if(src.DoingQuest&&src.QuestLevel==2)
			var/counter = 0
			for(var/obj/Items/ItemDrops/Small_Stick/C in src.contents)
				counter++
				if(counter <= 3)
					del C
					if(usr.BagOpen==1)
						usr.AddItems()
					src.AvailableItems-=1
					src.CreateInventory()

mob
	verb
		ExitQuest()
			winset(usr,"QuestMenu","is-visible=false")
			usr.QuestMenuUp=0
			usr.CheckQuest()
	proc
		CheckQuest()


			// Beginning Quests//
			if(src.DoingQuest&&src.QuestLevel==1&&src.FoxFurCollected>=3&&BoughtFoxFurTunic)
				src.DoingQuest=0
				src.FoxFurCollected=0
				src.QuestLevel+=1
				src.Gold+=15
				src.EXP+=45
				src.ElderNPC=1
				_message(src, "<b><font color=yellow>Gold Received: 15, EXP Received: 45, Fox Fur Tunic Received!</font></b>","white")
				_message(src, "<font color=green>New Task Unlocked: Make A Weapon!</font>","white")
				return

			if(src.DoingQuest&&src.QuestLevel==2&&src.SmallSticksCollected>=3&&usr.BoughtWoodenSword)
				src.DoingQuest=0
				src.SmallSticksCollected=0
				src.QuestLevel+=1
				src.Gold+=20
				src.EXP+=50
				src.ElderNPC=1
				BoughtWoodenSword=0
				_message(src, "<b><font color=yellow>Gold Received: 20, EXP Received: 50, Wooden Sword Received!</font></b>","white")


				return

			if(src.DoingQuest&&src.QuestLevel==3&&src.InClan==1)
				src.DoingQuest=0
				src.QuestLevel+=1
				src.Gold+=20
				src.EXP+=50
				src.ElderNPC=0
				_message(src, "<b><font color=yellow>Gold Received: 20, EXP Received: 50, Wooden Sword Received!</font></b>","white")

				return



		QUESTCHECK(var/N as text)
			//Shaolin Temple NPCs


			/*if(N=="Wolf")
				if(src.DoingQuest==1&&src.QuestLevel==2)
					src.FoxKilled+=1
					_message(src, "<font color=green>Small Sticks Collected: [src.FoxKilled]/3</font>","white")
					if(src.FoxKilled>=3)
						src.ElderNPC=1
				return*/

			/*if(N=="Cave Bandit Leader (Boss)")
				if(src.DoingQuest==1)
					_message(src, "<font color=green>The bandit drops a treasure chest! </font>","white")
					var/obj/Items/Quest/Treasure_Chest/O = new/obj/Items/Quest/Treasure_Chest
					O.y=src.y
					O.x=src.x
					O.z=src.z
				return*/


mob/NPCS/QUEST
	icon='Monk.dmi'
	layer=6
	NPC=1

//Elder Monk NPC and what happens when you click on him
	Monk
		Name="Clan Elder"
		New()
			Max_MouseName()
			GenerateShadow(src, SOUTH,-60)
			..()
		Click()
			if(src in oview(1))
				if(usr.QuestMenuUp==1)
					return
				else
					if(usr.QuestLevel==1)
						usr.QuestMenuUp=1
						usr.BeginningQuests("FurQuest")
						return
					if(usr.QuestLevel==2)
						usr.QuestMenuUp=1
						usr.BeginningQuests("WoodenSwordQuest")
						return
					if(usr.QuestLevel==3&&usr.Level==5)
						usr.QuestMenuUp=1
						usr.BeginningQuests("CreateClanQuest")
						return





//when you accept a quest, these dialogues show up to say you've accepted it
mob/verb
	QAccept()
		set hidden=1
		usr<<sound('levelup.wav')
		winset(usr,"QuestMenu","is-visible=false")
		usr.QuestMenuUp=0

		//Monk Temple Quests//
		if(QuestLevel==1)
			if(!usr.DoingQuest)
				_message(usr, "<b><font color=red>Quest:<font color=white> - Collect 3 Fox Furs!</font></b>","white")
				usr.ElderNPC=0
				usr.DoingQuest=1
		if(QuestLevel==2)
			if(!usr.DoingQuest)
				_message(usr, "<b><font color=red>Quest:<font color=white> - Collect 3 Small Sticks!</font></b>","white")
				usr.ElderNPC=0
				usr.DoingQuest=1
			if(SecondQuestOver)
				usr.ShowSkillLevel()
		if(QuestLevel==3)
			if(!usr.DoingQuest)
				_message(usr, "<b><font color=red>Quest:<font color=white> - Speak to Clan Elder</font></b>","white")
				usr.ElderNPC=0
				usr.DoingQuest=1
			if(ThirdQuestOver)
				ShowSkillLevel()
		usr.CheckQuest()
		return

		//Monk Temple Quests End//

	QDeny()
		set hidden=1
		winset(usr,"QuestMenu","is-visible=false")
		_message(usr, "<b><font color=red>Quest:<font color=white> - Quest Cancelled!</font></b>","white")
		usr.DoingQuest=0
		usr.QuestMenuUp=0
		return