mob/proc
	utilize(u)
		if(Stamina<u)
			return
		else
			Stamina=Stamina-u
			return
	Damage(D)
		if(Health<D)
			Health=0
			return
		else
			Health=Health-D
			new/effect/damage(src.loc,"<font color=red><b>[round(D)]</b></font>")
			return
	deathcheck()

		if(src.Dying)
			if(src.Player)
				//_message(world, "<b><font color=red>[T.Name]<I> Has Killed [M.Name]!</b></I></font>")
				src<<sound('death.wav')
				src.speed=4
			src.ALPHAMINUS()

	DeathCheck(mob/T,mob/M)
		if(M.Dead)
			return
		M.update_health_bar()
		if(M.Health<=0)
			M.Dying=1
			if(M.Enemy)
				var/obj/Gold/G=new/obj/Gold
				var/Amount=rand(1,20)
				G.Amount=Amount
				T.QUESTCHECK(M.Name)
				if(M.Name=="Fox"&&M.Enemy==1)
					G.Amount=3
					var/obj/Items/ItemDrops/Fox_Fur/F=new/obj/Items/ItemDrops/Fox_Fur
					F.loc=M.loc
					G.loc=M.loc
				if(M.Name=="Wolf"&&M.Enemy==1)
					G.Amount=5
					var/obj/Items/ItemDrops/Fox_Fur/F=new/obj/Items/ItemDrops/Small_Stick
					F.loc=M.loc
					G.loc=M.loc
				if(M.Name=="Bear"&&M.Enemy==1)
					G.Amount=44
				if(M.Name=="Thief"&&M.Enemy==1)
					G.Amount=42
				if(M.Name=="Bandit"&&M.Enemy==1)
					G.Amount=8
				if(M.Name=="BanditLeader"&&M.Enemy==1)
					G.Amount=33

			if(T.Player==1)
				if(M.Name=="Fox"&&M.Enemy==1)
					T.EXP+=35
				if(M.Name=="Bear"&&M.Enemy==1)
					T.EXP+=397
				if(M.Name=="Wolf"&&M.Enemy==1)
					T.EXP+=52
				if(M.Name=="Bandit"&&M.Enemy==1)
					T.EXP+=78
				if(M.Name=="Thief"&&M.Enemy==1)
					T.EXP+=265
				if(M.Name=="Bandit Leader"&&M.Enemy==1)
					T.EXP+=177
				else
					T.EXP+=rand(5,40)
				T.LevelUP()
			if(M.Player)
				debuggers<<"[M.Attacker] killed [M.name]"
				//_message(world, "<b><font color=red>[T.Name]<I> Has Killed [M.Name]!</b></I></font>")
				M<<sound('death.wav')
				M.speed=4
			M.ALPHAMINUS()
	ALPHAMINUS()
		spawn while(Dying)
			if(src.alpha<=90)
				if(src.Enemy)
					src.Dying=0
					del(src)
				sleep(20)

				src.Dying=0
				src.Dead=1
				src.ALPHAADD()
				return
			src.density=0
			animate(src,transform=matrix(),alpha=alpha-2,time=0)
			sleep(world.tick_lag)
	ALPHAADD()
		spawn while(Dead)
			if(src.alpha>=250)
				src.Health=src.MaxHealth
				src.Stamina=src.MaxStamina
				src.Dead=0
				src.speed=4
				src.loc=locate(17,12,5)
				src.speed=4
				if(ClanArenaFilled)
					if(src.ClanFighting)
						src.ClanFighting=0
						ClanOneMembers-=1
						src.loc=locate(96,98,3)
						if(ClanOneMembers<=0)
							for(var/mob/M in world)
								if(M.Clan==ClanOne)
									M.loc=locate(17,12,5)
									M.ClanFighting=0
									M.Clan2Fighting=0
							for(var/mob/S in world)
								if(S.Clan==ClanTwo)
									S.loc=locate(17,12,5)
									S.ClanGold+=20
									S.ClanExp+=20
									S.ClanFighting=0
									S.Clan2Fighting=0
									if(S.ClanMaxExp>=S.ClanExp)
										S.ClanMaxExp+=50
										S.ClanExp+=50
										S.ClanLevel+=1
										_message(S,"[ClanOne] Your Clan Has Leveled Up!","green")
							_message(world,"The Clan: <font Color=white>[ClanOne]</font> Won The Clan Battle The Clan Arena Is Now Open!","yellow")
							ClanArenaFilled=0
							ClanOne=""
							ClanTwo=""
							ClanTwoMembers=0
							ClanOneMembers=0
					if(src.Clan2Fighting)
						src.Clan2Fighting=0
						ClanTwoMembers-=1
						src.loc=locate(96,98,3)
						if(ClanTwoMembers<=0)
							for(var/mob/M in world)
								if(M.Clan==ClanOne)
									M.loc=locate(17,12,5)
									M.ClanGold+=20
									M.ClanExp+=20
									M.ClanFighting=0
									M.Clan2Fighting=0
									if(M.ClanMaxExp>=M.ClanExp)
										M.ClanMaxExp+=50
										M.ClanExp+=50
										M.ClanLevel+=1
										_message(M,"[ClanOne] Your Clan Has Leveled Up!","green")
							for(var/mob/S in world)
								if(S.Clan==ClanTwo)
									S.loc=locate(17,12,5)
									S.ClanFighting=0
									S.Clan2Fighting=0
							_message(world,"The Clan: <font Color=white>[ClanOne]</font> Won The Clan Battle The Clan Arena Is Now Open!","yellow")
							ClanArenaFilled=0
							ClanOne=""
							ClanTwo=""
							ClanTwoMembers=0
							ClanOneMembers=0
				spawn(10)
					src.density=1
				return
			animate(src,transform=matrix(),alpha=alpha+6,time=0)
			sleep(world.tick_lag)
	LevelUP()
		if(src.EXP>MaxEXP)
			flick("Flash Step",src)
			src.Level+=1
			src.EXP=0
			if(src.Level==2)
				src.MaxEXP=150
			if(src.Level==3)
				src.MaxEXP=225
			if(src.Level==4)
				src.MaxEXP=505
			if(src.Level==5)
				src.MaxEXP=505
				_message(src,"You can now form a clan! Speak to the Clan Elder to get started!","Aqua")
			if(src.Level==6)
				src.MaxEXP=758
			if(src.Level==7)
				src.MaxEXP=1137
			if(src.Level==8)
				src.MaxEXP=1706
			if(src.Level==9)
				src.MaxEXP=2559
			if(src.Level==10)
				src.MaxEXP=3838
			if(src.Level>=11)
				src.Level=11
			_message(src,"You Leveled Up","Aqua")
			src<<sound('levelup.wav')
			src.MaxStrength+=3
			src.MaxDefense+=3
			src.MaxStamina+=rand(15,20)
			src.MaxHealth+=rand(5,10)
			src.Health=src.MaxHealth
			src.Stamina=src.MaxStamina
			src.Defense=src.MaxDefense
			src.Strength=src.MaxStrength
			if(src.BowOn)
				src.Strength-=BowBoost
				src.Strength=src.MaxStrength
				src.Strength+=BowBoost
			if(src.SwordOn)
				src.Strength-=SwordBoost
				src.Strength=src.MaxStrength
				src.Strength+=SwordBoost
			if(src.StaffOn)
				src.Strength-=StaffBoost
				src.Strength=src.MaxStrength
				src.Strength+=StaffBoost
			src.SkillGive()
	SkillGive()
		if(src.Class=="Monk")
			if(src.Level==5)
				src.Skills+=new/obj/Skills/FSlash
				_message(src,"You Have Learned Forward Slash, Press S to see all your skills.","green")
			if(src.Level==9)
				src.Skills+=new/obj/Skills/DPole
				_message(src,"You Have Learned Divine Pole, Press S to see all your skills.","green")
			if(src.Level==15)
				src.Skills+=new/obj/Skills/RHurricane
				_message(src,"You Have Learned Roaring Hurricane, Press S to see all your skills.","green")
			if(src.Level==10)
				src.Skills+=new/obj/Skills/SWhirlwind
				_message(src,"You Have Learned Shrieking Whirlwind, Press S to see all your skills.","green")
			if(src.Level==10)
				src.Skills+=new/obj/Skills/HTyphoon
				_message(src,"You Have Learned Howling Typhoon, Press S to see all your skills.","green")
				return
