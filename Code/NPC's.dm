mob
	var/tmp
		Interacting=0
		D = list()
		tmp/Dialog=0
		tmp/Dialog2=10000
	verb
		Interact()
			set src in oview(0.3)
			if(src.client){return}
			usr.D=list(
			1= "Hello, [usr.Name]! Glad to meet you!",
			2= "I Am The, [name]! Welcome To [world.name].",
			)
			if(usr.Interacting)
				return
			usr.Dialog2=src.Dialog2
			usr.Dialog=src.Dialog
			usr.IInteract()
			return
	proc
		IInteract()
			if(src.Dialog > length(D))
				src.Interacting=0
				return
			if(Interacting)
				return
			src.Interacting=1
			winset(src,"IntroO","is-visible=true")
			IDialogue("IntroO")
			return
		IDialogue(K)
			spawn(30)
				if(src.Dialog>=src.Dialog2)
					winset(src,"IntroO","is-visible=false")
					src.Interacting=0
					sleep(5)
					winset(src,"IntroO","is-visible=true")
					winset(src,"IntroO","is-visible=false")
					return
				else
					src.Interacting=0
					src.IInteract()
			if(src.Dialog>src.Dialog2)
				return
			src.Dialog +=1
			var/T="[src.D[src.Dialog]]"
			winset(src,"[K]","font-family=\"Power Red and Blue\"") //This is used to set a custom font on the output1
			var/Blank = "" // This is going to start as blank...and gradually have new letters added one by one.
			while(length(Blank)<length(T)) //While we still did not show all letters...
				sleep(0.5)
				Blank = addtext(Blank,"[getCharacter(T,length(Blank)+1)]")// Add in the next letter.
				src <<output(null,"[K]") //Clean up our output from the previous text.
				src <<output("<font size=2><font color=white>[Blank]","[K]")
			return
var/list/fonts = list('Tangerine_Regular.ttf')

mob/proc/Text(mob/M,var/Text="",K)
	winset(M,"[K]","font-family=\"Power Red and Blue\"") //This is used to set a custom font on the output1
	var/Blank = "" // This is going to start as blank...and gradually have new letters added one by one.
	while(length(Blank)<length(Text)) //While we still did not show all letters...
		sleep(0.5)
		Blank = addtext(Blank,"[getCharacter(Text,length(Blank)+1)]")// Add in the next letter.
		M <<output(null,"[K]") //Clean up our output from the previous text.
		M <<output("<font size=2><font color=black>[Blank]","[K]") //Output the new text with the new letter.
		if(length(Blank)>=length(Text)) //If this was the last letter.
			return // That's it! We're done.

proc
	getCharacter(string, pos=1)
		return ascii2text(text2ascii(string, pos)) //This proc is used to retrieve the next character in text string.

mob/NPCS
	icon='NPCs.dmi'
	layer=6
	NPC=1

	Person
		icon='White Base.dmi'
		Name=""
		layer=15
		Dialog=0
		Dialog2=2
		speed=2
		NPC=1
		New()
			GenerateShadow(usr, SOUTH,-32)
			var/Nameing=pick("Monk","Yung Ling","Qi Liko","Huang Duyi","Ma Dewei","Chiang Zhiqiang","Miao Jianjun","Ban Yanlin","Yuen Bo","Choy Xiaojian")
			src.Name=Nameing
			Max_MouseName()
			spawn while(src&&Dead==0&&Dying==0)
			//	walk(src, pick(NORTH, EAST, SOUTH, WEST),1,3)
				step_rand(src)
				sleep(world.tick_lag)
			..()

	Traveler
		icon_state="Tailor"
		Name="Traveler"
		New()
			GenerateShadow(src, SOUTH,-60)
			Max_MouseName()
			..()
		Click()
			if(src in oview(1))
				usr.Dialogue("Traveler1")
	Tailor
		icon_state="Tailor"
		Name="Tailor"
		Dialog=0
		Dialog2=2
		New()
			GenerateShadow(src, SOUTH,-60)
			Max_MouseName()
			Tailor()
			..()
		Click()
			if(src in oview(1))
				usr.Clicking()
				usr.CreateInventory2(src)
				if(usr.Interacting) { return }
				Interact()
				return

	Doctor
		icon_state="Doctor"
		Dialog=0
		Dialog2=2
		Name="Doctor"
		New()
			GenerateShadow(src, SOUTH,-60)
			Max_MouseName()
			Doctor()
			..()
		Click()
			if(src in oview(1))
				usr.Clicking()
				usr.CreateInventory2(src)
				if(usr.Interacting) { return }
				Interact()
				return
	BlackSmith
		icon_state="BlackSmith"
		Name="BlackSmith"
		Dialog=0
		Dialog2=2
		New()
			GenerateShadow(src, SOUTH,-60)
			Max_MouseName()
			BlackSmith()
			..()
		Click()
			if(src in oview(1))
				usr.Clicking()
				usr.CreateInventory2(src)
				if(usr.Interacting) { return }
				Interact()
				return
	Witch_Doctor
		icon_state="Witch Doctor"
		Name="Witch Doctor"
		Dialog=0
		Dialog2=2
		New()
			GenerateShadow(src, SOUTH,-60)
			Max_MouseName()
			Witch_Doctor()
			..()
		Click()
			if(src in oview(1))
				usr.CreateInventory2(src)
				if(usr.Interacting) { return }
				Interact()
				return
	Clan_Creator
		icon_state="ClanCreate"
		Name="Clan Chief"
		New()
			GenerateShadow(src, SOUTH,-60)
			Max_MouseName()
			..()
		Click()
			if(src in oview(1))
				usr.Clicking()
				var/list/L
				L = list("font size")

				if(usr.Level<5)
					_message(usr,"Ah, hello there! When you reach level 5 you'll be eligible to create your own clan. Keep training!","yellow")
					return
				if(usr.clan)
					_message(usr,"You are in a Clan!","yellow")
					return

				if(alert("Ah, have you come to create a Clan?","Clan Creation","Yes","No")=="No")
					return

				var/satisfactory = 0
				var/ClanName
				while(satisfactory==0)

					ClanName = input("What do you wish to call your Clan?","Clan Name") as text

					if(!ClanName)
						_message(usr,"Invalid entry!.","yellow")
					else
						satisfactory = 1
						for(var/X in L)
							if(findtext(ClanName,X))
								_message(usr,"You may not change your font size.","yellow")
								satisfactory = 0

						if(lentext(ClanName) > 40)
							_message(usr,"Cannot be more than 40 Characters!","yellow")
							satisfactory = 0




				if(alert("Do you wish to call your Clan [ClanName]?","Clan Name","Yes","No")=="No")
					return
				var/savefile/F = new("Saves/World/Clans.sav")

				var/clan/c = new()
				c.Create_Clan(ClanName, usr.name)
				usr.clan = c
				usr.InClan=1
				if(usr.QuestLevel==3&&usr.Level==5)
					usr.ElderNPC=1
				clans.Add(c)
				F["Clan"] << clans
				_message(usr,"Your clan, [ClanName] has been formed!","yellow")
