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
			new/effect/damage(M.loc,"<font color=red><b>[round(damage)]</b></font>")
			M.Health-=damage
			M.update_health_bar()
		if(M.Health<=0)
			M.Health=0
			M.DeathCheck(src,M)
mob/Enemies
	Enemy=1
	NPC=0
	layer=6
	Level=1

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
				src.speed = 0.5


			if(src.Health > src.MaxHealth)
				src.Health = src.MaxHealth

			if((src.Attacked <=0) && src.Health<src.MaxHealth)
				src.Health += 10

		//	walk(src,0)
			if(src && !src.Dead && !src.Dying)
				if(src.Attacked)	//follow their attacker
					var/found = 0
					for(var/mob/M in oview(8,src))
						if(M.Player && !M.Dead && !M.Dying && (src.Attacker == M.Name))
							found = 1
							//if they are right next to the player facing them, attack them
							if(get_dist(src,M)<=1 && src.dir == get_dir(src,M))
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
					for(var/mob/M in oview(8,src))
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
		Level=1
		Strength=8
		Defense=7
		Health=80
		MaxHealth=80
		New()
			spawn
				while(src)
					sleep(10)
					src.tickle()
			GenerateShadow(src, SOUTH,-10)
			Max_MouseName()

	Red_Fox
		icon='fox3.dmi'
		Name="Red Fox"
		speed=2
		Level=1
		Strength=24
		Defense=21
		Health=150
		MaxHealth=150
		New()
			spawn
				while(src)
					sleep(10)
					src.tickle()
			GenerateShadow(src, SOUTH,-10)
			Max_MouseName()


	Wolf
		icon='Wolf.dmi'
		Name="Wolf"
		Level=4
		Strength=32
		Defense=28
		Health=250
		MaxHealth=250
		speed=2
		New()
			spawn
				while(src)
					sleep(10)
					src.tickle()
			GenerateShadow(src, SOUTH,-10)
			Max_MouseName()

	Bat
		icon='Bat.dmi'
		Name="Cave Bat"
		Level=4
		Strength=40
		Defense=35
		Health=650
		MaxHealth=650
		speed=2
		New()
			spawn
				while(src)
					sleep(10)
					src.tickle()
			GenerateShadow(src, SOUTH,-10)
			Max_MouseName()

	Cave_Spider
		icon='Spider.dmi'
		Name="Cave Spider"
		Level=4
		Strength=40
		Defense=35
		Health=500
		MaxHealth=500
		speed=2
		New()
			spawn
				while(src)
					sleep(10)
					src.tickle()
			GenerateShadow(src, SOUTH,-10)
			Max_MouseName()


	Bat_Black
		icon='Bat_Black.dmi'
		Name="Black Bat"
		Level=4
		Strength=48
		Defense=42
		Health=500
		MaxHealth=500
		speed=2
		New()
			spawn
				while(src)
					sleep(10)
					src.tickle()
			GenerateShadow(src, SOUTH,-10)
			Max_MouseName()


	Bandit_Enemies
		Bandit
			icon='Bandit.dmi'
			Name="Mountain Bandit"
			Level=10
			Strength=17
			Defense=15
			Health=120
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
				..()

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