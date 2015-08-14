turf/Screen2
	icon='Screen2.jpg'
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
	layer=14
	Shaolin_Temple
		ToShaolinTempleFromArea1
			Enter(atom/a)
				if(istype(a,/mob/))
					if(a:Enemy)
						return 0
					if(a:Player)
						usr.FadeScreen()
						usr.loc=locate(/turf/Markers/ShaolinTemple/ToShaolinTempleFromArea1)
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
		ToArea1FromShaolinTemple
			Enter(atom/a)
				if(istype(a,/mob/))
					if(a:Enemy)
						return 0
					if(a:Player)
						usr.FadeScreen()
						usr.loc=locate(/turf/Markers/ShaolinTemple/ToArea1FromShaolinTemple)
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
		ToArea2FromArea1
			Enter(atom/a)
				if(istype(a,/mob/))
					if(a:Enemy)
						return 0
					if(a:Player)
						usr.FadeScreen()
						usr.loc=locate(/turf/Markers/ShaolinTemple/ToArea2FromArea1)
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

		ToArea1FromArea2
			Enter(atom/a)
				if(istype(a,/mob/))
					if(a:Enemy)
						return 0
					if(a:Player)
						usr.FadeScreen()
						usr.loc=locate(/turf/Markers/ShaolinTemple/ToArea1FromArea2)
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

		ToArea3FromArea2
			Enter(atom/a)
				if(istype(a,/mob/))
					if(a:Enemy)
						return 0
					if(a:Player)
						usr.FadeScreen()
						usr.loc=locate(/turf/Markers/ShaolinTemple/ToArea3FromArea2)
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
						usr.loc=locate(/turf/Markers/ShaolinTemple/ToArea2FromArea3)
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
						usr.loc=locate(/turf/Markers/Mountains/Dungeon1_Inside)
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
						usr.loc=locate(/turf/Markers/Mountains/Dungeon1_Outside)
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
	Smalltree
		icon='Small Tree.dmi'
		density=1
		layer=10
		shadow=1
	Tent
		icon='Tent.dmi'

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