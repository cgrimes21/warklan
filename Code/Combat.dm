mob/verb
/*	JBack()
		set hidden=1
		if(!Player)
			return
		if(Jumped)
			return
		usr.Frozen=1
		usr.Jumped=1
		usr.density=0
		usr.oldloc=usr.loc
		usr.oldpixelx=usr.pixel_x
		usr.oldpixely=usr.pixel_y
		usr.InFlight=1
		if(usr.dir==SOUTH)
			usr.Location="South"
			if(usr.y>=world.maxy)
				usr.Frozen=0
				usr.Jumped=0
				usr.density=1
				return
		if(usr.dir==NORTH)
			usr.Location="North"
			if(usr.y<=2)
				usr.Frozen=0
				usr.Jumped=0
				usr.density=1
				return
		if(usr.dir==EAST)
			usr.Location="East"
			if(usr.x<=2)
				usr.Frozen=0
				usr.Jumped=0
				usr.density=1
				return
		if(usr.dir==WEST)
			usr.Location="West"
			if(usr.x>=world.maxx)
				usr.Frozen=0
				usr.Jumped=0
				usr.density=1
				return
		animate(usr,icon_state="Jump")
		usr.underlays-=usr.underlays
		GenerateShadow(src, SOUTH,-32)
		usr.PIXELYADD()*/

	Block()
		set hidden=1
		if(!Player)
			return
		if(Stamina<=20)
			usr.icon_state=""
			usr.Blocking=0
			return
		if(usr.Blocking)
			usr.icon_state=""
			usr.underlays-=usr.underlays
			GenerateShadow(src, SOUTH,-32)
			usr.Blocking=0
			return
		else
			if(Stamina<=20)
				usr.icon_state=""
				usr.Blocking=0
				return
			else
				usr.Blocking=1
				usr.icon_state="Block"
				usr.underlays-=usr.underlays
				GenerateShadow(src, SOUTH,-32)
				return

	Attack()
		if(!Player)
			return
		if(Slashing)
			return

		/*if(usr.BowOn)
			if(usr.Dead==1)
				return
			if(usr.Dying==1)
				return
			if(usr.Stamina<=8)
				return
			if(usr.Punching)
				return
			else
				if(prob(1))
					src.bow_skill += rand(0.5,1)
					src<<"bow skill improved"

				Punching=1;spawn(6)Punching=0
				flick("Quincy Bow Shooting",usr)
				var/obj/Projectiles/Arrow/A=new/obj/Projectiles/Arrow()
				A.loc = usr.loc
				A.dir=usr.dir
				A.Owner=usr
			//MAY HAVE TO REMOVE//
				var nx = usr.step_x, ny = usr.step_y
				A.step_x = nx
				A.step_y = ny
			/////////////////////
				walk(A,usr.dir)*/
		for(var/obj/Can_Build/O in get_step(src,usr.dir))
			if(usr.dir!=get_dir(usr,O))	//your not one step away facing them,
				continue

			if(usr.Punching)
				return

			if(usr.Stamina<=5)
				debuggers<<"stamina = [usr.Stamina] return"
				return

			if(!O.CanDestroy)
				return

			var/G=pick('Sounds/Punch.ogg','Sounds/Punch2.ogg')
			if(usr.sound_on)
				usr<<sound(G)
			oview(10,usr)<<sound(G)
			usr.speed=2;spawn(5)usr.speed=4
			Punching=1;spawn(10)Punching=0

				//All damage is done here
			var/weaponlevel
			if(usr.SwordOn)
				weaponlevel=usr.Sword_Skill_Level
			if(usr.SpearOn)
				weaponlevel=usr.Spear_Skill_Level
			if(usr.AxeOn)
				weaponlevel=usr.Axe_Skill_Level
			else
				weaponlevel=usr.HandToHand_Skill_Level

			var/tmp/damage=((usr.Strength+weaponlevel*10)-O.Defense)
			if(damage<=0)
				damage=rand(1,2)
			usr.Stamina-=rand(2,4)
			O.Damage(damage)
			O.Obj_DeathCheck()
			return


		for(var/mob/M in get_step(src,usr.dir))
			if(usr.dir!=get_dir(usr,M))	//your not one step away facing them,
				continue
			if(M.NPC == 1)
				return
			if(M.Dead==1)

				return
			if(M.Dying==1)

				return

			if(usr.Stamina<=5)
				debuggers<<"stamina = [usr.Stamina] return"
				return
			if(usr.Punching)
				return

			var/fight_on = 0
			if(M.client) //if they are a player

				//check if they are at war
				if(usr.clan && M.clan)

					if((ckey(usr.clan.war.name) == ckey(M.clan.name)) && (ckey(M.clan.war.name) == ckey(usr.clan.name)))
						fight_on = 1
						debuggers<<"[usr.clan.name] is at war with [M.clan.name]"

				if(usr.challenging ==ckey(M.name))
					debuggers<<"[usr.challenging] is challenging [M.name]"
					fight_on = 1
			else//enemy npc
				fight_on = 1

			if(fight_on)
				var/G=pick('Sounds/Punch.ogg','Sounds/Punch2.ogg')
				if(usr.sound_on)
					usr<<sound(G)
					if(prob(35))
						usr<<sound('Sounds/aGrunt.ogg')
				oview(10,usr)<<sound(G)
				flick("Jab",usr)
				usr.speed=2;spawn(5)usr.speed=4
				Punching=1;spawn(8)Punching=0
				M.Attacker=usr.Name



				//All damage is done here
				var/weaponlevel
				if(usr.SwordOn)
					weaponlevel=usr.Sword_Skill_Level
				if(usr.SpearOn)
					weaponlevel=usr.Spear_Skill_Level
				if(usr.AxeOn)
					weaponlevel=usr.Axe_Skill_Level
				else
					weaponlevel=usr.HandToHand_Skill_Level

				var/tmp/damage=((usr.Strength+usr.WeaponBoost+weaponlevel*10)-(M.Defense+M.ShieldBoost))
				if(damage<=0)
					damage=rand(1,2)
				usr.Stamina-=rand(2,4)
				if(M.Enemy)
					M.Attacked+=10
					var/mob/Enemies/e = M
					e.most_dmg["[usr.name]"] += damage

				M.Damage(damage)



				M.DeathCheck(usr,M)
				if(!attackTutorialDone) //if you didnt already attack a mob
					usr.attackTutorialDone=1 //you've attacked him now
					usr.HudDelete_Tut1() //delete the tutorial
				return


mob/proc
	PIXELYADD()
		spawn while(Jumped)
			if(src.pixel_y>=80)
				sleep(1)
				src.PIXELYMINUS()
				return
			animate(src,transform=matrix(),pixel_y=pixel_y+4,time=0)
			sleep(world.tick_lag)
	PIXELYMINUS()
		spawn while(Jumped)
			if(src.pixel_y==20)
				if(src.Location=="South")
					step(src,NORTH,30)
					animate(src,dir=SOUTH)
				if(src.Location=="North")
					step(src,SOUTH,30)
					animate(src,dir=NORTH)
				if(src.Location=="West")
					step(src,EAST,30)
					animate(src,dir=WEST)
				if(src.Location=="East")
					step(src,WEST,30)
					animate(src,dir=EAST)
				goto end
			if(src.pixel_y<=0)
				animate(src,icon_state="")
				src.underlays-=src.underlays
				src.Frozen=0
				GenerateShadow(src, SOUTH,-60)
				src.InFlight=0
				src.Jumped=0
				src.density=1
				return
			end
			animate(src,icon_state="Land")
			usr.underlays-=usr.underlays
			GenerateShadow(src, SOUTH,-60)
			animate(src,transform=matrix(),pixel_y=pixel_y-4,time=0)
			sleep(world.tick_lag)

effect/damage
	icon='messageDisplay.dmi'
	parent_type = /obj
	layer = 100
	New(newloc, val)
		maptext = val
		src.loc=newloc
		pixel_x=9
		pixel_y=55
		sleep(7)
		animate(src,transform=matrix()*10,alpha=0,pixel_y=80,time=3)
		spawn(10)
		del(src)