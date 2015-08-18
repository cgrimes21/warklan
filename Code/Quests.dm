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
	QuestLevel=1
	DoingQuest=0
	FoxFurCollected=0
	SmallSticksCollected=0
	WolfKilled=0
	FoxKilled=0
	BanditsKilled=0
	BanditLeaderKilled=0
	BearHead=0
	HerbsReady=0
	Herbs=0
	ClothingNPC=0
	ElderNPC=1
	HealingNPC=0
	WeaponNPC=0
	EnemiesKilled=0


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
			var/icon/my_icon = icon('Coin.dmi')
			var/file_reference = fcopy_rsc(my_icon)
			winset(src,"QuestMenu.RewardOne","image=\ref[file_reference]")

			src<< output(null,"QuestMenu.Info")
			if(src.FoxFurCollected>=3)
				src<< output("<center>Great work! Here's a fox fur tunic. </center>","QuestMenu.Info")
				src.DoingQuest=1

				winset(src,"QuestMenu.RewardOne","image=\ref[file_reference]")
				winset(src,"QuestMenu.Accept","is-visible=true")
				winset(src,"QuestMenu.Accept","text=Complete")
				winset(usr,"QuestMenu.Deny","is-visible=false")

			else
				src<< output("<center>Ah, hello [usr.Name], you've grown into a fine young man indeed! However I think it's time for you to leave home and make your own legend, and time for you to create your own clan and stories of glory! Hm, but in order to do so, you'll need stronger clothing, and a weapon. Why don't you go and get 3 fox skins for me. You can get them from the foxes to your right.</center>","QuestMenu.Info")
				src.DoingQuest=1
				winset(src,"QuestMenu.Accept","is-visible=true")
				winset(usr,"QuestMenu.Deny","is-visible=true")
		if(T=="WoodenSwordQuest")
			src<< output(null,"QuestMenu.Info")
			var/icon/my_icon = icon('Coin.dmi')
			var/file_reference = fcopy_rsc(my_icon)
			winset(src,"QuestMenu.RewardOne","image=\ref[file_reference]")

			if(src.SmallSticksCollected>=3)
				src<< output("<center>Great work! Here's a wooden sword. </center>","QuestMenu.Info")
				src.DoingQuest=1

				winset(src,"QuestMenu.Accept","is-visible=true")
				winset(src,"QuestMenu.Accept","text=Complete")
				winset(usr,"QuestMenu.Deny","is-visible=false")
			else
				src<< output("<center>So let's see...we've gotten you some clothing, now it's time to get you a decent weapon! Why don't we start with a wooden sword? Go and get 3 small wooden sticks, they're usually dropped by Wolves. I'll carve them into a wooden sword for you.</center>","QuestMenu.Info")
				src.DoingQuest=1
				winset(src,"QuestMenu.Accept","is-visible=true")
				winset(usr,"QuestMenu.Deny","is-visible=true")

	QuestItemCheck()
		if(src.DoingQuest&&src.QuestLevel==1)
			for(var/obj/O in src.contents)
				if(O.name=="Fox Fur")
					src.FoxFurCollected+=1
					_message(src, "<font color=green>Furs Collected: [src.FoxFurCollected]/3</font>","white")
					if(src.FoxFurCollected>=3)
						src.ElderNPC=1
					return
		if(src.DoingQuest&&src.QuestLevel==2)
			for(var/obj/O in src.contents)
				if(O.name=="Small Stick")
					src.SmallSticksCollected+=1
					_message(src, "<font color=green>Small Sticks Collected: [src.SmallSticksCollected]/3</font>","white")
					if(src.SmallSticksCollected>=3)
						src.ElderNPC=1
					return

	QuestItemDelete()
		if(src.DoingQuest&&src.QuestLevel==1)
			for(var/obj/O in src.contents)
				if(O.name=="Fox Fur")
					if(usr.BagOpen==1)
						usr.AddItems()

					usr.AvailableItems-=1
					usr.CreateInventory()

					del O

		if(src.DoingQuest&&src.QuestLevel==2)
			for(var/obj/O in src.contents)
				if(O.name=="Small Stick")
					if(usr.BagOpen==1)
						usr.AddItems()
					del O
					del O
					del O
					usr.AvailableItems-=1
					usr.CreateInventory()
				else
					return
mob
	verb
		ExitQuest()
			winset(usr,"QuestMenu","is-visible=false")
			usr.QuestMenuUp=0
			usr.CheckQuest()
	proc
		CheckQuest()


			// Beginning Quests//
			if(src.DoingQuest&&src.QuestLevel==1&&src.FoxFurCollected>=3)
				src.QuestItemDelete()
				src.DoingQuest=0
				src.FoxFurCollected=0
				src.QuestLevel+=1
				src.Gold+=15
				src.EXP+=45
				src.ElderNPC=1

				var/obj/Items/Clothing/Fox_Fur_Tunic/A = new/obj/Items/Clothing/Fox_Fur_Tunic
				usr.AvailableItems+=1
				usr.contents+=A
				_message(src, "<b><font color=yellow>Gold Received: 15, EXP Received: 45, Fox Fur Tunic Received!</font></b>","white")

				if(usr.BagOpen==1)
					usr.AddItems()
				if(src.EXP>=src.MaxEXP)
					src.LevelUP()
				return

			if(src.DoingQuest&&src.QuestLevel==2&&src.SmallSticksCollected>=3)
				src.QuestItemDelete()
				src.DoingQuest=0
				src.FoxFurCollected=0
				src.QuestLevel+=1
				src.Gold+=20
				src.EXP+=50
				src.ElderNPC=0

				var/obj/Items/Clothing/Fox_Fur_Tunic/A = new/obj/Items/Weapons/Wooden_Sword
				usr.AvailableItems+=1
				usr.contents+=A
				_message(src, "<b><font color=yellow>Gold Received: 20, EXP Received: 50, Wooden Sword Received!</font></b>","white")

				if(usr.BagOpen==1)
					usr.AddItems()
				if(src.EXP>=src.MaxEXP)
					src.LevelUP()
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


			if(N=="Mountain Bandit")
				if(src.DoingQuest==1&&QuestLevel==4)
					src.BanditsKilled+=1
					_message(src, "<font color=green>Mountain Bandits Defeated: [src.BanditsKilled]/5</font>","white")
					if(src.BanditsKilled>=5)
						src.WeaponNPC=1
				return
			if(N=="Bear")
				if(src.DoingQuest==1&&QuestLevel==9)
					src.BearHead+=1
					_message(src, "<font color=green>Bear Head: [src.BearHead]/1</font>","white")
					if(src.BearHead>=1)
						src.ElderNPC=1
				return

			if(N=="Cave Bandit Leader (Boss)")
				if(src.DoingQuest==1)
					_message(src, "<font color=green>The bandit drops a treasure chest! </font>","white")
					var/obj/Items/Quest/Treasure_Chest/O = new/obj/Items/Quest/Treasure_Chest
					O.y=src.y
					O.x=src.x
					O.z=src.z
				return


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




//when you accept a quest, these dialogues show up to say you've accepted it
mob/verb
	QAccept()
		set hidden=1
		usr<<sound('levelup.wav')
		winset(usr,"QuestMenu","is-visible=false")
		usr.QuestMenuUp=0

		//Monk Temple Quests//
		if(QuestLevel==1)
			_message(usr, "<b><font color=red>Quest:<font color=white> - Collect 3 Fox Furs!</font></b>","white")
			usr.ElderNPC=0
		if(QuestLevel==2)
			_message(usr, "<b><font color=red>Quest:<font color=white> - Collect 3 Small Sticks!</font></b>","white")
			usr.ElderNPC=0
		usr.CheckQuest()
		return

		//Monk Temple Quests End//

	QDeny()
		set hidden=1
		winset(usr,"QuestMenu","is-visible=false")
		usr.DoingQuest=0
		usr.QuestMenuUp=0
		return