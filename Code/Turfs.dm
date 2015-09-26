turf/Screen1
	icon='Screen1.jpg'

turf/EnemyStop
	var/D=0
	Enter(atom/a)
		if(istype(a,/mob/))
			if(a:Enemy)
				return 0
			if(a:NPC)
				return 0
			if(a:Player&&D==0)
				return 1
			if(a:Player&&D==1)
				return 0
		else
			..()
	Exit(atom/a)
		if(istype(a,/mob/))
			if(a:Enemy)
				return 0
			if(a:NPC)
				return 0
			if(a:Player&&D==0)
				return 1
			if(a:Player&&D==1)
				return 0
		else
			..()
turf/Locations
	layer=140
	Tutorial
		ToArea2FromArea1
			Enter(atom/a)
				if(istype(a,/mob/))
					if(a:Enemy)
						return 0
					if(a:Player)
						usr.FadeScreen()
						usr.loc=locate(/turf/Markers/Tutorial/ToArea2FromArea1)
						usr.Frozen=1
						sleep(5)
						//usr<< sound('Sounds/Battle.ogg',1,0,1)
						usr.Frozen=0
						#warning its creating this five times, make it more efficient
						if(!usr.attackTutorialDone) //if attack tutorial isn't finished
							usr.HudCreate_Tut1() //create tut 1
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

		ToArea1FromArea2
			Enter(atom/a)
				if(istype(a,/mob/))
					if(a:Enemy)
						return 0
					if(a:Player)
						usr.FadeScreen()
						usr.loc=locate(/turf/Markers/Tutorial/ToArea1FromArea2)
						usr.Frozen=1
						if(!usr.attackTutorialDone)
							usr.HudDelete_Tut1()
						sleep(5)
						//usr<< sound('Sounds/Intro2.ogg',1,0,1)
						usr.Frozen=0
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
		ToArea3FromArea2
			Enter(atom/a)
				if(istype(a,/mob/))
					if(a:Enemy)
						return 0
					if(a:Player)
						usr.FadeScreen()
						usr.loc=locate(/turf/Markers/Tutorial/ToArea3FromArea2)
						usr.Frozen=1
						sleep(5)
						usr.Frozen=0
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

		ToArea2FromArea3
			Enter(atom/a)
				if(istype(a,/mob/))
					if(a:Enemy)
						return 0
					if(a:Player)
						usr.FadeScreen()
						usr.loc=locate(/turf/Markers/Tutorial/ToArea2FromArea3)
						usr.Frozen=1
						sleep(5)
						usr.Frozen=0
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

	MainMap
		ToArea2FromArea1
			Enter(atom/a)
				if(istype(a,/mob/))
					if(a:Enemy)
						return 0
					if(a:Player)
						usr.FadeScreen()
						usr.loc=locate(/turf/Markers/MainMap/ToArea2FromArea1)
						usr.Frozen=1
						sleep(5)
						//usr<< sound('Sounds/Battle.ogg',1,0,1)
						usr.Frozen=0
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

		ToArea1FromArea2
			Enter(atom/a)
				if(istype(a,/mob/))
					if(a:Enemy)
						return 0
					if(a:Player)
						usr.FadeScreen()
						usr.loc=locate(/turf/Markers/MainMap/ToArea1FromArea2)
						usr.Frozen=1
						sleep(5)
						//usr<< sound('Sounds/Intro2.ogg',1,0,1)
						usr.Frozen=0
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
		ToArea3FromArea2
			Enter(atom/a)
				if(istype(a,/mob/))
					if(a:Enemy)
						return 0
					if(a:Player)
						usr.FadeScreen()
						usr.loc=locate(/turf/Markers/MainMap/ToArea3FromArea2)
						usr.Frozen=1
						sleep(5)
						usr.Frozen=0
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

		ToArea2FromArea3
			Enter(atom/a)
				if(istype(a,/mob/))
					if(a:Enemy)
						return 0
					if(a:Player)
						usr.FadeScreen()
						usr.loc=locate(/turf/Markers/MainMap/ToArea2FromArea3)
						usr.Frozen=1
						sleep(5)
						usr.Frozen=0
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

	Dungeons
		Dungeon1_Inside
			Enter(atom/a)
				if(istype(a,/mob/))
					if(a:Enemy)
						return 0
					if(a:Player)
						usr.FadeScreen()
						usr.inDungeon=1
						usr<< sound('Sounds/Dungeon.ogg',1,0,1)
						usr.loc=locate(/turf/Markers/Dungeon1/Dungeon1_Inside)
						usr.Frozen=1
						sleep(5)
						usr.Frozen=0
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

		Dungeon1_Outside
			Enter(atom/a)
				if(istype(a,/mob/))
					if(a:Enemy)
						return 0
					if(a:Player)
						usr.FadeScreen()
						usr.inDungeon=0
						usr<< sound('Sounds/Battle.ogg',1,0,1)
						usr.loc=locate(/turf/Markers/Dungeon1/Dungeon1_Outside)
						usr.Frozen=1
						sleep(5)
						usr.Frozen=0
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

		//Inside the dungeon
		Room1_Next
			Enter(atom/a)
				if(istype(a,/mob/))
					if(a:Enemy)
						return 0
					if(a:Player)
						usr.FadeScreen()
						usr.loc=locate(/turf/Markers/Dungeon1/Room1_Next)
						usr.Frozen=1
						sleep(5)
						usr.Frozen=0
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
		Room1_Back
			Enter(atom/a)
				if(istype(a,/mob/))
					if(a:Enemy)
						return 0
					if(a:Player)
						usr.FadeScreen()
						usr.loc=locate(/turf/Markers/Dungeon1/Room1_Back)
						usr.Frozen=1
						sleep(5)
						usr.Frozen=0
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
		Room2_Next
			Enter(atom/a)
				if(istype(a,/mob/))
					if(a:Enemy)
						return 0
					if(a:Player)
						usr.FadeScreen()
						usr.loc=locate(/turf/Markers/Dungeon1/Room2_Next)
						usr.Frozen=1
						sleep(5)
						usr.Frozen=0
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
		Room2_Back
			Enter(atom/a)
				if(istype(a,/mob/))
					if(a:Enemy)
						return 0
					if(a:Player)
						usr.FadeScreen()
						usr.loc=locate(/turf/Markers/Dungeon1/Room2_Back)
						usr.Frozen=1
						sleep(5)
						usr.Frozen=0
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
		Room3_Next
			Enter(atom/a)
				if(istype(a,/mob/))
					if(a:Enemy)
						return 0
					if(a:Player)
						usr.FadeScreen()
						usr.loc=locate(/turf/Markers/Dungeon1/Room3_Next)
						usr.Frozen=1
						sleep(5)
						usr.Frozen=0
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
		Room3_Back
			Enter(atom/a)
				if(istype(a,/mob/))
					if(a:Enemy)
						return 0
					if(a:Player)
						usr.FadeScreen()
						usr.loc=locate(/turf/Markers/Dungeon1/Room3_Back)
						usr.Frozen=1
						sleep(5)
						usr.Frozen=0
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
		Room4_Next
			Enter(atom/a)
				if(istype(a,/mob/))
					if(a:Enemy)
						return 0
					if(a:Player)
						usr.FadeScreen()
						usr.loc=locate(/turf/Markers/Dungeon1/Room4_Next)
						usr.Frozen=1
						sleep(5)
						usr.Frozen=0
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
		Room4_Back
			Enter(atom/a)
				if(istype(a,/mob/))
					if(a:Enemy)
						return 0
					if(a:Player)
						usr.FadeScreen()
						usr.loc=locate(/turf/Markers/Dungeon1/Room4_Back)
						usr.Frozen=1
						sleep(5)
						usr.Frozen=0
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
		Room5_Next
			Enter(atom/a)
				if(istype(a,/mob/))
					if(a:Enemy)
						return 0
					if(a:Player)
						usr.FadeScreen()
						usr.loc=locate(/turf/Markers/Dungeon1/Room5_Next)
						usr.Frozen=1
						sleep(5)
						usr.Frozen=0
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
		Room5_Back
			Enter(atom/a)
				if(istype(a,/mob/))
					if(a:Enemy)
						return 0
					if(a:Player)
						usr.FadeScreen()
						usr.loc=locate(/turf/Markers/Dungeon1/Room5_Back)
						usr.Frozen=1
						sleep(5)
						usr.Frozen=0
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
		Room6_Next
			Enter(atom/a)
				if(istype(a,/mob/))
					if(a:Enemy)
						return 0
					if(a:Player)
						usr.FadeScreen()
						usr.loc=locate(/turf/Markers/Dungeon1/Room6_Next)
						usr.Frozen=1
						sleep(5)
						usr.Frozen=0
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
		Room6_Back
			Enter(atom/a)
				if(istype(a,/mob/))
					if(a:Enemy)
						return 0
					if(a:Player)
						usr.FadeScreen()
						usr.loc=locate(/turf/Markers/Dungeon1/Room6_Back)
						usr.Frozen=1
						sleep(5)
						usr.Frozen=0
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
		Room7_Next
			Enter(atom/a)
				if(istype(a,/mob/))
					if(a:Enemy)
						return 0
					if(a:Player)
						usr.FadeScreen()
						usr.loc=locate(/turf/Markers/Dungeon1/Room7_Next)
						usr.Frozen=1
						sleep(5)
						usr.Frozen=0
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
		Room7_Back
			Enter(atom/a)
				if(istype(a,/mob/))
					if(a:Enemy)
						return 0
					if(a:Player)
						usr.FadeScreen()
						usr.loc=locate(/turf/Markers/Dungeon1/Room7_Back)
						usr.Frozen=1
						sleep(5)
						usr.Frozen=0
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
		Room8_Next
			Enter(atom/a)
				if(istype(a,/mob/))
					if(a:Enemy)
						return 0
					if(a:Player)
						usr.FadeScreen()
						usr.loc=locate(/turf/Markers/Dungeon1/Room8_Next)
						usr.Frozen=1
						sleep(5)
						usr.Frozen=0
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


turf/Turfs
	icon='Turfs.dmi'

turf/House
	icon='House.dmi'
turf/Grass
	density=0
	icon='Turf - Grass.dmi'
	Grass1
		icon_state="1"
	Grass2
		icon_state="2"
	Grass3
		icon_state="3"
	Grass4
		icon_state="4"
	Grass5
		icon_state="5"
	Grass6
		icon_state="6"
	Grass7
		icon_state="7"
	Grass8
		icon_state="8"
	Grass9
		icon_state="9"
	Grass10
		icon_state="10"
	Grass11
		icon_state="11"
	Grass12
		icon_state="12"
	Grass13
		icon_state="13"
	Grass14
		icon_state="14"
	Grass15
		icon_state="15"
	Grass16
		icon_state="16"
obj/WaterType1
	icon='Water.dmi'
	density=1
	layer=TURF_LAYER
	Water1
		icon_state="1"
	Water2
		icon_state="2"
	Water3
		icon_state="3"

	Water4
		icon_state="4"
	Water5
		icon_state="5"
	Water6
		icon_state="6"
	Water7
		icon_state="7"
	Water8
		icon_state="8"
	Water9
		icon_state="9"

obj/Rocks
	icon='Rocks.dmi'
	One
		icon_state="1"
	Two
		icon_state="2"
	Three
		icon_state="3"
	Four
		icon_state="4"

turf
	DirtPath
		icon='Dirtpath.dmi'
obj
	tree
		icon='Tree.dmi'
		icon_state="1"
		density=1
		layer=TURF_LAYER+2
		shadow=1
		shadow
			icon='Tree.dmi'
			icon_state="2"
obj
	invis_density
		density = 1

	Smalltree
		icon='Small Tree.dmi'
		density=1
		layer=10
		shadow=1
	Tent
		icon='Tent.dmi'
		layer = 15
		density = 1

turf
	var/m
turf
	dirt
		icon='Dirt.dmi'
obj
	Lamp
		icon='Lamp.dmi'
		layer=10
		One
			icon_state="1"
			density=1
		Two
			icon_state="2"
		Three
			icon_state="3"
		Four
			icon_state="4"
	Fences
		icon='fences.dmi'
		One
			icon_state="1"
		Two
			icon_state="2"
		Three
			icon_state="3"
		Four
			icon_state="4"

obj/Props
	icon='Prop - Grass Props.dmi'
	One
		icon_state="1"
	Two
		icon_state="2"
	Three
		icon_state="3"
	Four
		icon_state="4"
	Five
		icon_state="5"
	Six
		icon_state="6"
	Seven
		icon_state="7"
	Eight
		icon_state="8"
	Nine
		icon_state="9"
	Ten
		icon_state="10"
	Eleven
		icon_state="11"
	Twelve
		icon_state="12"
	Thirteen
		icon_state="13"
	Fourteen
		icon_state="14"
	Fifthteen
		icon_state="15"
	Sixteen
		icon_state="16"
turf/Layers
	SmallTreeLayer
		Entered(atom/a)
			if(istype(a,/mob/))
				usr.layer=MOB_LAYER-2
			else
				..()
		Exited(atom/a)
			if(istype(a,/mob/))
				usr.layer=MOB_LAYER+8
			else
				..()
	Layer
		layer=TURF_LAYER+1
		Entered(atom/a)

			usr.layer=MOB_LAYER-2
	BigTreeLayer
		Entered(atom/a)
			if(usr.dir!=SOUTH&&usr.BehindTree==0)
				usr.layer=MOB_LAYER+5
				return
			else
				..()
		Exited(atom/a)
			usr.layer=MOB_LAYER
	BigTreeLayer2
		Entered(atom/a)
			usr.BehindTree=1
			usr.layer=MOB_LAYER
		Exited(atom/a)
			usr.BehindTree=0
			usr.layer=MOB_LAYER
	NPCLayer
		Entered(atom/a)
			if(istype(a,/mob/))
				usr.layer=4
			else
				..()
		Exited(atom/a)
			if(istype(a,/mob/))
				usr.layer=15
			else
				..()
	Layer2
		layer=TURF_LAYER+1
		Entered(atom/a)
			usr.layer=MOB_LAYER
obj
	Density
		layer=TURF_LAYER+20
		density=1
	Darkness
		icon='Darkness.dmi'
		icon_state="cave_dark"
		layer=MOB_LAYER+12