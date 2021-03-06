mob
	var/tmp

		Attacked=0
		being_attacked = 0

mob/proc
	NPCAttack(mob/T,mob/M)
		if(M.Blocking==1)
			goto Next
			return
		else
			goto Begin
			return
		M.Attacker = T.Name
		Begin
		animate(M,icon_state="Knock Back")
		sleep(1)
		animate(M,icon_state="")
		Next
		if(M.Blocking)
			var/tmp/damage=round((T.Strength+25)-M.Defense)/2
			if(damage<=0)
				damage=rand(1,3)
			new/effect/damage(M.loc,"<font color=red><b>[round(damage)]</b></font>")
			M.Health-=damage
		else
			var/tmp/damage=round((T.Strength+25)-M.Defense)/1.5
			if(damage<=0)
				damage=rand(1,3)
			if(prob(75)) playAttackingSound(T,M)
			new/effect/damage(M.loc,"<font color=red><b>[round(damage)]</b></font>")
			M.Health-=damage
			M.update_health_bar()
		if(M.Health<=0)
			M.Health=0
			M.DeathCheck(src,M)

	playAttackingSound(mob/T,mob/M)
		switch(T.Name)
			if("Cave Bat")
				M << sound('Sounds/screech.ogg')
			if("Bandit")
				M << sound('Sounds/aGrunt.ogg')
			else
				M << sound('Sounds/growl.ogg')


mob/Enemies
	Enemy=1
	NPC=0
	layer=15
	Level=1

	var/list/most_dmg = list()
	Move(a,b)

		switch(b)
			if(NORTHEAST)
				b = pick(NORTH,EAST)
			if(SOUTHEAST)
				b = pick(EAST,SOUTH)
			if(NORTHWEST)
				b = pick(NORTH,WEST)
			if(SOUTHWEST)
				b = pick(SOUTH,WEST)
		a = get_step(src,b)
		..(a,b)
	proc
		NPCAttackPlayer(mob/who)
			//debuggers<<"[src.name] attacking [who.name]"
			if(who.Dying || who.Dead)
				return
			src.NPCAttack(src,who)

		tickle()

			src.Attacked -= 0

			if(src.Attacked <= 0)
				src.Attacked = 0
				src.Attacker = ""
				var/S = pick(0.5,1,1.5,2)
				src.speed = S


			if(src.Health > src.MaxHealth)
				src.Health = src.MaxHealth

			if((src.Attacked <=0) && src.Health<src.MaxHealth)
				src.Health += 10

		//	walk(src,0)
			if(src && !src.Dead && !src.Dying)
				if(src.Attacked)	//follow their attacker
					var/found = 0
					for(var/mob/M in oview(5,src))
						if(M.Player && !M.Dead && !M.Dying && (src.Attacker == M.Name))
							found = 1
							//if they are right next to the player facing them, attack them
							var/nolist = list(NORTHEAST,NORTHWEST,SOUTHEAST,SOUTHWEST)
							if(get_dist(src,M)<=1 && src.dir == get_dir(src,M))
								if(src.dir in nolist)
									switch(src.dir)
										if(NORTHEAST)
											step(src,pick(NORTH,EAST))
										if(NORTHWEST)
											step(src,pick(NORTH,WEST))
										if(SOUTHEAST)
											step(src,pick(SOUTH,EAST))
										if(SOUTHWEST)
											step(src,pick(SOUTH,WEST))
								else

									src.NPCAttackPlayer(M)
							else
								//take a step towards them
								step_to(src,M,0)
								//step_to(src,M,0)
								//walk(src,get_dir(src,M),1,3)
							//	walk_to(src,M,0,1,3)

					if(!found)
						src.Attacked = 0
				if(src.Attacked<=0)
					step(src, pick(NORTH, EAST, SOUTH, WEST),1)
					for(var/mob/M in oview(5,src))
						if(M.Player && (src.Attacker != M.name))
							if(M.being_attacked)
								if(prob(JOIN_AGGRO))
									src.Attacked += 1
									src.Attacker = M.Name
									M.being_attacked = 1


							else if(prob(INITIAL_AGGRO))
								src.Attacked += 1
								src.Attacker = M.Name
								M.being_attacked = 1

					//walk(src, pick(NORTH, EAST, SOUTH, WEST),0,3)


	Fox_Cub
		icon='fox3.dmi'
		Name="Fox Cub"
		speed=2
		Level=3
		Strength=7
		Defense=4
		Health=100
		MaxHealth=100
		expGiven=10
		New()
			spawn
				while(src)
					sleep(5)
					src.tickle()
			GenerateShadow(src, SOUTH,-10)
			Max_MouseName()

	Red_Fox
		icon='fox3.dmi'
		Name="Red Fox"
		speed=2
		Level=6
		Strength=24
		Defense=21
		Health=100
		MaxHealth=100
		expGiven=20
		New()
			spawn
				while(src)
					sleep(5)
					src.tickle()
			GenerateShadow(src, SOUTH,-10)
			Max_MouseName()

	//BASE
	Base
		Clan_Base
			icon='Icons/Buildable/Firepit.dmi'
			Name="Clan Base"
			speed=2
			Level=1
			Strength=7
			Defense=4
			Health=200
			MaxHealth=200
			New()
				GenerateShadow(src, SOUTH,-10)
				Max_MouseName()

		Stone_Crafting_Table
			icon='Icons/Buildable/WeaponTable1.dmi'
			icon_state="weapontable1"
			Name="Stone Crafting Table"
			speed=2
			Level=1
			Strength=7
			Defense=4
			Health=200
			MaxHealth=200
			New()
				GenerateShadow(src, SOUTH,-10)
				Max_MouseName()

		Basic_Sewing_Table
			icon='Icons/Buildable/SewingTable1.dmi'
			icon_state="tailortable1"
			Name="Basic Sewing Table"
			speed=2
			Level=1
			Strength=7
			Defense=4
			Health=200
			MaxHealth=200
			New()
				GenerateShadow(src, SOUTH,-10)
				Max_MouseName()

		Bandit
			icon='White Base.dmi'
			Name="Bandit"
			Level=9
			Strength=39
			Defense=35
			Health=150
			MaxHealth=150
			expGiven=60
			New()
				spawn
					while(src)
						sleep(5)
						src.tickle()
				GenerateShadow(src, SOUTH,-32)
				Max_MouseName()


	Wolf
		icon='Wolf.dmi'
		Name="Mountain Wolf"
		Level=9
		Strength=35
		Defense=31
		Health=150
		MaxHealth=150
		expGiven=40
		New()
			spawn
				while(src)
					sleep(5)
					src.tickle()
			GenerateShadow(src, SOUTH,-45)
			Max_MouseName()


	Bat
		icon='Bat.dmi'
		Name="Cave Bat"
		Level=12
		Strength=47
		Defense=43
		Health=130
		MaxHealth=130
		expGiven=80

		New()
			spawn
				while(src)
					sleep(5)
					src.tickle()
			GenerateShadow(src, SOUTH,-10)
			Max_MouseName()

	Cave_Spider
		icon='Spider.dmi'
		Name="Cave Spider"
		Level=15
		Strength=53
		Defense=49
		Health=150
		MaxHealth=150
		expGiven=100
		New()
			spawn
				while(src)
					sleep(5)
					src.tickle()
			GenerateShadow(src, SOUTH,-10)
			Max_MouseName()


	Bat_Black
		icon='Bat_Black.dmi'
		Name="Black Bat"
		Level=18
		Strength=46
		Defense=42
		Health=100
		MaxHealth=100
		expGiven=120
		New()
			spawn
				while(src)
					sleep(5)
					src.tickle()
			GenerateShadow(src, SOUTH,-10)
			Max_MouseName()


	/*Bandit_Enemies
		Bandit
			icon='Bandit.dmi'
			Name="Mountain Bandit"
			Level=10
			Strength=17
			Defense=15
			Health=12
			MaxHealth=120
			speed=3
			New()
				GenerateShadow(src, SOUTH,-50)
				Max_MouseName()
				spawn while(src)
					if(Attacked==0&&Health<MaxHealth)
						Health+=50
						if(Health>=MaxHealth)
							Health=MaxHealth
					sleep(100)
				spawn while(src)
					if(Attacked)
						Attacked=0
						Attacker=""
						src.speed=3
					sleep(120)
				spawn while(src&&Dead==0&&Dying==0)
					src.speed=3
					walk(src, pick(NORTH, EAST, SOUTH, WEST),1,3)
					sleep(15)
				spawn while(src&&Dead==0&&Dying==0)
					for(var/mob/M in oview(1))
						if(M.Player==1&&M.Dead==0&&M.Dying==0&&src.Attacked&&src.Attacker==M.Name&&M.Level<5)
							NPCAttack(src,M)
						else
							if(M.Player==1&&M.Dead==0&&M.Dying==0&&M.Level>=5)
								if(src.dir==get_dir(src,M))
									src.Attacker=M.Name
									src.Attacked=1
									NPCAttack(src,M)
					sleep(10)
				spawn while(src&&Dead==0&&Dying==0)
					for(var/mob/M in oview(5))
				//		if(M.Player==1&&M.Level>=5)
				//			src.speed=4
				//			walk(src,get_dir(src,M),1,3)
						if(M.Player==1&&src.Attacked&&src.Attacker==M.Name)
							src.speed=4
							walk(src,get_dir(src,M),1,3)
					sleep(world.tick_lag)
				..()

		Bandit_Leader
			icon='BanditLeader.dmi'
			Name="Bandit Leader (Boss)"
			Level=15
			Strength=200
			Defense=200
			Health=300
			MaxHealth=300
			speed=4
			New()
				GenerateShadow(src, SOUTH,-50)
				Max_MouseName()
				spawn while(src)
					if(Attacked==0&&Health<MaxHealth)
						Health+=50
						if(Health>=MaxHealth)
							Health=MaxHealth
					sleep(100)
				spawn while(src)
					if(Attacked)
						Attacked=0
						Attacker=""
						src.speed=4
					sleep(120)
				spawn while(src&&Dead==0&&Dying==0)
					src.speed=4
					walk(src, pick(NORTH, EAST, SOUTH, WEST),1,3)
					sleep(15)
				spawn while(src&&Dead==0&&Dying==0)
					for(var/mob/M in oview(1))
						if(M.Player==1&&M.Dead==0&&M.Dying==0&&src.Attacked&&src.Attacker==M.Name&&M.Level<5)
							NPCAttack(src,M)
						else
							if(M.Player==1&&M.Dead==0&&M.Dying==0&&M.Level>=5)
								if(src.dir==get_dir(src,M))
									src.Attacker=M.Name
									src.Attacked=1
									NPCAttack(src,M)
					sleep(10)
				spawn while(src&&Dead==0&&Dying==0)
					for(var/mob/M in oview(2))
				//		if(M.Player==1&&M.Level>=5)
				//			src.speed=5
				//			walk(src,get_dir(src,M),1,3)
						if(M.Player==1&&src.Attacked&&src.Attacker==M.Name)
							src.speed=5
							walk(src,get_dir(src,M),1,3)
					sleep(world.tick_lag)
				..()

		Cave_Bandit
			icon='Fox.dmi'
			Name="Cave Bandit"
			speed=2
			Level=25
			Strength=65
			Defense=65
			Health=150
			MaxHealth=150
			New()
				GenerateShadow(src, SOUTH,-50)
				Max_MouseName()
				spawn while(src)
					if(Attacked==0&&Health<MaxHealth)
						Health+=50
						if(Health>=MaxHealth)
							Health=MaxHealth
					sleep(100)
				spawn while(src)
					if(Attacked)
						Attacked=0
						Attacker=""
						src.speed=2
					sleep(120)
				spawn while(src&&Dead==0&&Dying==0)
					src.speed=2
					walk(src, pick(NORTH, EAST, SOUTH, WEST),1,3)
					sleep(15)
				spawn while(src&&Dead==0&&Dying==0)
					for(var/mob/M in oview(1))
						if(M.Player==1&&M.Dead==0&&M.Dying==0&&src.Attacked&&src.Attacker==M.Name&&M.Level<5)
							NPCAttack(src,M)
						else
							if(M.Player==1&&M.Dead==0&&M.Dying==0&&M.Level>=5)
								if(src.dir==get_dir(src,M))
									src.Attacker=M.Name
									src.Attacked=1
									NPCAttack(src,M)
					sleep(10)
				spawn while(src&&Dead==0&&Dying==0)
					for(var/mob/M in oview(5))
				//		if(M.Player==1&&M.Level>=5)
				//			src.speed=4
				//			walk(src,get_dir(src,M),1,3)
						if(M.Player==1&&src.Attacked&&src.Attacker==M.Name)
							src.speed=4
							walk(src,get_dir(src,M),1,3)
					sleep(world.tick_lag)
				..()

		Cave_Bandit_Leader
			icon='Fox.dmi'
			Name="Cave Bandit Leader (Boss)"
			speed=2
			Level=25
			Strength=65
			Defense=65
			Health=150
			MaxHealth=150
			New()
				GenerateShadow(src, SOUTH,-50)
				Max_MouseName()
				spawn while(src)
					if(Attacked==0&&Health<MaxHealth)
						Health+=50
						if(Health>=MaxHealth)
							Health=MaxHealth
					sleep(100)
				spawn while(src)
					if(Attacked)
						Attacked=0
						Attacker=""
						src.speed=2
					sleep(120)
				spawn while(src&&Dead==0&&Dying==0)
					src.speed=2
					walk(src, pick(NORTH, EAST, SOUTH, WEST),1,3)
					sleep(15)
				spawn while(src&&Dead==0&&Dying==0)
					for(var/mob/M in oview(1))
						if(M.Player==1&&M.Dead==0&&M.Dying==0&&src.Attacked&&src.Attacker==M.Name&&M.Level<5)
							NPCAttack(src,M)
						else
							if(M.Player==1&&M.Dead==0&&M.Dying==0&&M.Level>=5)
								if(src.dir==get_dir(src,M))
									src.Attacker=M.Name
									src.Attacked=1
									NPCAttack(src,M)
					sleep(10)
				spawn while(src&&Dead==0&&Dying==0)
					for(var/mob/M in oview(5))
				//		if(M.Player==1&&M.Level>=5)
				//			src.speed=4
				//			walk(src,get_dir(src,M),1,3)
						if(M.Player==1&&src.Attacked&&src.Attacker==M.Name)
							src.speed=4
							walk(src,get_dir(src,M),1,3)
					sleep(world.tick_lag)
				..()

		Black_Boar_Bandit
			icon='Fox.dmi'
			Name="Black Boar Bandit"
			speed=2
			Level=25
			Strength=65
			Defense=65
			Health=150
			MaxHealth=150
			New()
				GenerateShadow(src, SOUTH,-50)
				Max_MouseName()
				spawn while(src)
					if(Attacked==0&&Health<MaxHealth)
						Health+=50
						if(Health>=MaxHealth)
							Health=MaxHealth
					sleep(100)
				spawn while(src)
					if(Attacked)
						Attacked=0
						Attacker=""
						src.speed=2
					sleep(120)
				spawn while(src&&Dead==0&&Dying==0)
					src.speed=2
					walk(src, pick(NORTH, EAST, SOUTH, WEST),1,3)
					sleep(15)
				spawn while(src&&Dead==0&&Dying==0)
					for(var/mob/M in oview(1))
						if(M.Player==1&&M.Dead==0&&M.Dying==0&&src.Attacked&&src.Attacker==M.Name&&M.Level<5)
							NPCAttack(src,M)
						else
							if(M.Player==1&&M.Dead==0&&M.Dying==0&&M.Level>=5)
								if(src.dir==get_dir(src,M))
									src.Attacker=M.Name
									src.Attacked=1
									NPCAttack(src,M)
					sleep(10)
				spawn while(src&&Dead==0&&Dying==0)
					for(var/mob/M in oview(5))
				//		if(M.Player==1&&M.Level>=5)
				//			src.speed=4
				//			walk(src,get_dir(src,M),1,3)
						if(M.Player==1&&src.Attacked&&src.Attacker==M.Name)
							src.speed=4
							walk(src,get_dir(src,M),1,3)
					sleep(world.tick_lag)
				..()

		Black_Boar_Juggernaut
			icon='Fox.dmi'
			Name="Black Boar Juggernaut"
			speed=2
			Level=25
			Strength=65
			Defense=65
			Health=150
			MaxHealth=150
			New()
				GenerateShadow(src, SOUTH,-50)
				Max_MouseName()
				spawn while(src)
					if(Attacked==0&&Health<MaxHealth)
						Health+=50
						if(Health>=MaxHealth)
							Health=MaxHealth
					sleep(100)
				spawn while(src)
					if(Attacked)
						Attacked=0
						Attacker=""
						src.speed=2
					sleep(120)
				spawn while(src&&Dead==0&&Dying==0)
					src.speed=2
					walk(src, pick(NORTH, EAST, SOUTH, WEST),1,3)
					sleep(15)
				spawn while(src&&Dead==0&&Dying==0)
					for(var/mob/M in oview(1))
						if(M.Player==1&&M.Dead==0&&M.Dying==0&&src.Attacked&&src.Attacker==M.Name&&M.Level<5)
							NPCAttack(src,M)
						else
							if(M.Player==1&&M.Dead==0&&M.Dying==0&&M.Level>=5)
								if(src.dir==get_dir(src,M))
									src.Attacker=M.Name
									src.Attacked=1
									NPCAttack(src,M)
					sleep(10)
				spawn while(src&&Dead==0&&Dying==0)
					for(var/mob/M in oview(5))
				//		if(M.Player==1&&M.Level>=5)
				//			src.speed=4
				//			walk(src,get_dir(src,M),1,3)
						if(M.Player==1&&src.Attacked&&src.Attacker==M.Name)
							src.speed=4
							walk(src,get_dir(src,M),1,3)
					sleep(world.tick_lag)
				..()

		Black_Boar_Leader
			icon='Fox.dmi'
			Name="Black Boar Leader (Boss)"
			speed=2
			Level=25
			Strength=65
			Defense=65
			Health=150
			MaxHealth=150
			New()
				GenerateShadow(src, SOUTH,-50)
				Max_MouseName()
				spawn while(src)
					if(Attacked==0&&Health<MaxHealth)
						Health+=50
						if(Health>=MaxHealth)
							Health=MaxHealth
					sleep(100)
				spawn while(src)
					if(Attacked)
						Attacked=0
						Attacker=""
						src.speed=2
					sleep(120)
				spawn while(src&&Dead==0&&Dying==0)
					src.speed=2
					walk(src, pick(NORTH, EAST, SOUTH, WEST),1,3)
					sleep(15)
				spawn while(src&&Dead==0&&Dying==0)
					for(var/mob/M in oview(1))
						if(M.Player==1&&M.Dead==0&&M.Dying==0&&src.Attacked&&src.Attacker==M.Name&&M.Level<5)
							NPCAttack(src,M)
						else
							if(M.Player==1&&M.Dead==0&&M.Dying==0&&M.Level>=5)
								if(src.dir==get_dir(src,M))
									src.Attacker=M.Name
									src.Attacked=1
									NPCAttack(src,M)
					sleep(10)
				spawn while(src&&Dead==0&&Dying==0)
					for(var/mob/M in oview(5))
				//		if(M.Player==1&&M.Level>=5)
				//			src.speed=4
				//			walk(src,get_dir(src,M),1,3)
						if(M.Player==1&&src.Attacked&&src.Attacker==M.Name)
							src.speed=4
							walk(src,get_dir(src,M),1,3)
					sleep(world.tick_lag)
				..()*/

/*	Zombie_Assassin
		icon='Bandit.dmi'
		Name="Zombie Assassin"
		Level=10
		Strength=150
		Defense=100
		Health=250
		speed=3
		New()
			GenerateShadow(src, SOUTH,-50)
			Max_MouseName()
			spawn while(src)
				if(Attacked==0&&Health<250)
					Health+=50
					if(Health>=250)
						Health=250
				sleep(100)
			spawn while(src)
				if(Attacked)
					Attacked=0
					Attacker=""
					src.speed=3
				sleep(120)
			spawn while(src&&Dead==0&&Dying==0)
				src.speed=3
				walk(src, pick(NORTH, EAST, SOUTH, WEST),1,3)
				sleep(15)
			spawn while(src&&Dead==0&&Dying==0)
				for(var/mob/M in oview(1))
					if(M.Player==1&&M.Dead==0&&M.Dying==0&&src.Attacked&&src.Attacker==M.Name&&M.Level<5)
						NPCAttack(src,M)
					else
						if(M.Player==1&&M.Dead==0&&M.Dying==0&&M.Level>=5)
							if(src.dir==get_dir(src,M))
								src.Attacker=M.Name
								src.Attacked=1
								NPCAttack(src,M)
				sleep(10)
			spawn while(src&&Dead==0&&Dying==0)
				for(var/mob/M in oview(5))
			//		if(M.Player==1&&M.Level>=5)
			//			src.speed=4
			//			walk(src,get_dir(src,M),1,3)
					if(M.Player==1&&src.Attacked&&src.Attacker==M.Name)
						src.speed=4
						walk(src,get_dir(src,M),1,3)
				sleep(world.tick_lag)
			..()
	Zombie_Assassin_Leader
		icon='BanditLeader.dmi'
		Name="Zombie Assassin (Leader)"
		Level=10
		Strength=15
		Defense=100
		Health=250
		speed=3
		New()
			GenerateShadow(src, SOUTH,-50)
			Max_MouseName()
			spawn while(src)
				if(Attacked==0&&Health<250)
					Health+=50
					if(Health>=250)
						Health=250
				sleep(100)
			spawn while(src)
				if(Attacked)
					Attacked=0
					Attacker=""
					src.speed=3
				sleep(120)
			spawn while(src&&Dead==0&&Dying==0)
				src.speed=3
				walk(src, pick(NORTH, EAST, SOUTH, WEST),1,3)
				sleep(15)
			spawn while(src&&Dead==0&&Dying==0)
				for(var/mob/M in oview(1))
					if(M.Player==1&&M.Dead==0&&M.Dying==0&&src.Attacked&&src.Attacker==M.Name&&M.Level<5)
						NPCAttack(src,M)
					else
						if(M.Player==1&&M.Dead==0&&M.Dying==0&&M.Level>=5)
							if(src.dir==get_dir(src,M))
								src.Attacker=M.Name
								src.Attacked=1
								NPCAttack(src,M)
				sleep(10)
			spawn while(src&&Dead==0&&Dying==0)
				for(var/mob/M in oview(5))
			//		if(M.Player==1&&M.Level>=5)
			//			src.speed=4
			//			walk(src,get_dir(src,M),1,3)
					if(M.Player==1&&src.Attacked&&src.Attacker==M.Name)
						src.speed=4
						walk(src,get_dir(src,M),1,3)
				sleep(world.tick_lag)
			..()

	Bat
		icon='Fox.dmi'
		Name="Bat"
		speed=2
		Level=25
		Strength=65
		Defense=65
		Health=150
		New()
			GenerateShadow(src, SOUTH,-50)
			Max_MouseName()
			spawn while(src)
				if(Attacked==0&&Health<150)
					Health+=50
					if(Health>=150)
						Health=150
				sleep(100)
			spawn while(src)
				if(Attacked)
					Attacked=0
					Attacker=""
					src.speed=2
				sleep(120)
			spawn while(src&&Dead==0&&Dying==0)
				src.speed=2
				walk(src, pick(NORTH, EAST, SOUTH, WEST),1,3)
				sleep(15)
			spawn while(src&&Dead==0&&Dying==0)
				for(var/mob/M in oview(1))
					if(M.Player==1&&M.Dead==0&&M.Dying==0&&src.Attacked&&src.Attacker==M.Name&&M.Level<5)
						NPCAttack(src,M)
					else
						if(M.Player==1&&M.Dead==0&&M.Dying==0&&M.Level>=5)
							if(src.dir==get_dir(src,M))
								src.Attacker=M.Name
								src.Attacked=1
								NPCAttack(src,M)
				sleep(10)
			spawn while(src&&Dead==0&&Dying==0)
				for(var/mob/M in oview(5))
			//		if(M.Player==1&&M.Level>=5)
			//			src.speed=4
			//			walk(src,get_dir(src,M),1,3)
					if(M.Player==1&&src.Attacked&&src.Attacker==M.Name)
						src.speed=4
						walk(src,get_dir(src,M),1,3)
				sleep(world.tick_lag)
			..()

	Angry_Bat
		icon='Fox.dmi'
		Name="Angry Bat"
		speed=2
		Level=25
		Strength=65
		Defense=65
		Health=150
		New()
			GenerateShadow(src, SOUTH,-50)
			Max_MouseName()
			spawn while(src)
				if(Attacked==0&&Health<150)
					Health+=50
					if(Health>=150)
						Health=150
				sleep(100)
			spawn while(src)
				if(Attacked)
					Attacked=0
					Attacker=""
					src.speed=2
				sleep(120)
			spawn while(src&&Dead==0&&Dying==0)
				src.speed=2
				walk(src, pick(NORTH, EAST, SOUTH, WEST),1,3)
				sleep(15)
			spawn while(src&&Dead==0&&Dying==0)
				for(var/mob/M in oview(1))
					if(M.Player==1&&M.Dead==0&&M.Dying==0&&src.Attacked&&src.Attacker==M.Name&&M.Level<5)
						NPCAttack(src,M)
					else
						if(M.Player==1&&M.Dead==0&&M.Dying==0&&M.Level>=5)
							if(src.dir==get_dir(src,M))
								src.Attacker=M.Name
								src.Attacked=1
								NPCAttack(src,M)
				sleep(10)
			spawn while(src&&Dead==0&&Dying==0)
				for(var/mob/M in oview(5))
			//		if(M.Player==1&&M.Level>=5)
			//			src.speed=4
			//			walk(src,get_dir(src,M),1,3)
					if(M.Player==1&&src.Attacked&&src.Attacker==M.Name)
						src.speed=4
						walk(src,get_dir(src,M),1,3)
				sleep(world.tick_lag)
			..()
*/