mob/var
	Trial_1=0

mob/Shaolin_Test
	Tome
		Name="Monk Tome"
		icon='White Base.dmi'
		New()
			Max_MouseName()
			GenerateShadow(src, SOUTH,-60)
			..()
		Click()
			if(src in oview(1))
				alert("Welcome to the Warrior Monk graduation test. You have been stripped bare and placed at the very top of these cold mountains. You must pass the great 5 trials in order to be known as a true warrior monk.")
				alert("Go forth and let your honor as a warrior be your warmth through these cold times! Go through the passage to the right.")

turf/Shaolin_Test_Trials
	Enter_Trial_1_Foxes
		Enter(atom/a)
			if(istype(a,/mob/))
				if(a:Enemy)
					return 0
				if(a:Player)
					if(usr.Trial_1==0)
						alert("On this mountain are Red Foxes which are known for their warm furs. You must find them, defeat them, and strip the furs off their body. A bit further on, we have an area set up that will help you weave clothing. If you succeed, you will survive the first trial, if you fail, you will not make it through the night.")
						usr.Trial_1 = 1
					return 1
			else
				..()
		Exit(atom/a)
			if(istype(a,/mob/))
				if(a:Enemy)
					return 0
				if(a:Player)
					return 1
			else
				..()
