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
				//var/obj/Gold/G=new/obj/Gold
				//var/Amount=rand(1,20)
				//G.Amount=Amount
				T.QUESTCHECK(M.Name)
				var/most_dmg_name = ""
				var/md = 0
				var/mob/Enemies/e = M
				for(var/v in e.most_dmg)
					if(e.most_dmg[v]>=md)
						md = e.most_dmg[v]
						most_dmg_name = v

				for(var/mob/temp in world)
					if(temp.name == most_dmg_name)
						T = temp
						debuggers<<"[T.name] dealt the most damage."

				if(M.Name=="Fox Cub"&&M.Enemy==1)
					var/exp = rand(8,10)
					if(prob(75))
						var/obj/Items/ItemDrops/Fox_Fur/F=new/obj/Items/ItemDrops/Fox_Fur
						if(!T.pickupTutorialActivated&&!T.pickupTutorialDone) //if pickup tutorial hasn't been activated yet or done
							T.pickupTutorialActivated=1 //the tutorial telling you how to pick stuff up is activated
							T.HudCreate_Tut2()
						F.loc=M.loc
						F.owner = "[T.name]"
						F.Fade()
					T.WeaponEquipCheck(exp)

				if(M.Name=="Red Fox"&&M.Enemy==1)
					var/exp = rand(18,20)
					if(prob(50))
						var/obj/Items/ItemDrops/Red_Fox_Fur/F=new/obj/Items/ItemDrops/Red_Fox_Fur
						F.loc=M.loc
						F.owner = "[T.name]"
						F.Fade()
					T.WeaponEquipCheck(exp)

				if(M.Name=="Mountain Wolf"&&M.Enemy==1)
					var/exp = rand(38,40)
					if(prob(50))
						var/obj/Items/ItemDrops/Stone/F=new/obj/Items/ItemDrops/Stone
						F.loc=M.loc
						F.owner = "[T.name]"
						F.Fade()
					if(prob(30))
						var/obj/Items/ItemDrops/Mountain_Wolf_Fur/F=new/obj/Items/ItemDrops/Mountain_Wolf_Fur
						F.loc=M.loc
						F.owner = "[T.name]"
						F.Fade()
					T.WeaponEquipCheck(exp)


				if(M.Name=="Stone Crafting Table"&&M.Enemy==1)
					T.BaseDestroyed_Table1=1
					T.BaseDestroyQuestFinish()

				if(M.Name=="Basic Sewing Table")
					T.BaseDestroyed_Table2=1
					T.BaseDestroyQuestFinish()

				if(M.Name=="Clan Base")
					T.BaseDestroyed_ClanBase=1
					T.BaseDestroyQuestFinish()

				if(M.Name=="Bandit"&&M.Enemy==1)
					usr<< sound('Sounds/screech.ogg')
					var/exp = rand(58,60)
					T.WeaponEquipCheck(exp)
					T.BaseDestroyed_Bandit+=1
					T.BaseDestroyQuestFinish()

				if(M.Name=="Cave Bat"&&M.Enemy==1)
					var/exp = rand(78,80)
					if(prob(50))
						var/obj/Items/ItemDrops/Stone/F=new/obj/Items/ItemDrops/Stone
						F.loc=M.loc
						F.owner = "[T.name]"
						F.Fade()
					T.WeaponEquipCheck(exp)

				if(M.Name=="Cave Spider"&&M.Enemy==1)
					var/exp = rand(98,100)
					if(prob(50))
						var/obj/Items/ItemDrops/Red_Fox_Fur/F=new/obj/Items/ItemDrops/Stone
						F.loc=M.loc
						F.owner = "[T.name]"
						F.Fade()
					if(prob(30))
						var/obj/Items/ItemDrops/Red_Fox_Fur/F=new/obj/Items/ItemDrops/Bronze
						F.loc=M.loc
						F.owner = "[T.name]"
						F.Fade()
					T.WeaponEquipCheck(exp)

				if(M.Name=="Black Bat"&&M.Enemy==1)
					var/exp = rand(118,120)
					if(prob(50))
						var/obj/Items/ItemDrops/Red_Fox_Fur/F=new/obj/Items/ItemDrops/Bronze
						F.loc=M.loc
						F.owner = "[T.name]"
						F.Fade()
					T.WeaponEquipCheck(exp)


				T.SkillLevelUP()
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
					var/holder = src.type
					var/holderloc = src.loc
					spawn(SPAWN_RATE)
						new holder (holderloc)

					send_to_graveyard(src)
					spawn(SPAWN_RATE + 10)
						del src

					return

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
				if(!src.TutorialDone)
					src.loc=locate(/turf/Markers/VillageOne/Spawn)
				else
					src.loc=locate(/turf/Markers/Tutorial/ToRegularMap)
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


	LevelGain_MaxExpGain()
		src.Level+=1
		src.EXP=0
		src.MaxEXP *= 1.5


	WeaponEquipCheck(exp)
		if(src.SwordOn)
			src.Sword_Skill_EXP+=exp
		else if(src.SpearOn)
			src.Spear_Skill_EXP+=exp
		else if(src.AxeOn)
			src.Axe_Skill_EXP+=exp
		else
			src.HandToHand_Skill_EXP+=exp
		return exp

	Skill_LevelGain_MaxExpGain()
		src.Health = src.MaxHealth
		src.Level+=1
		src.Strength+=2
		src.MaxStrength+=2
		src.Defense+=2
		src.MaxDefense+=2

		if(src.Level==10)
			//_message(src,"New Task Unlocked: <font color=white>Create A Clan!","Aqua")
			src.ElderNPC=1

		if(src.Sword_Skill_EXP>=Sword_Skill_MaxEXP)
			src.Sword_Skill_Level+=1
			src.Sword_Skill_EXP=0
			src.Sword_Skill_MaxEXP *= 2
		if(src.Axe_Skill_EXP>=Axe_Skill_MaxEXP)
			src.Axe_Skill_Level+=1
			src.Axe_Skill_EXP=0
			src.Axe_Skill_MaxEXP *= 2
		if(src.Spear_Skill_EXP>=Spear_Skill_MaxEXP)
			src.Spear_Skill_Level+=1
			src.Spear_Skill_EXP=0
			src.Spear_Skill_MaxEXP *= 2
		else if(src.HandToHand_Skill_EXP>=HandToHand_Skill_MaxEXP)
			src.HandToHand_Skill_Level+=1
			src.HandToHand_Skill_EXP=0
			src.HandToHand_Skill_MaxEXP *= 2




	SkillLevelUP()
		if(src.Sword_Skill_EXP>=Sword_Skill_MaxEXP)
			Skill_LevelGain_MaxExpGain()
			_message(src,"Your sword skill has leveled up!","Aqua")
			src<<sound('levelup.wav')
		if(src.Spear_Skill_EXP>=Spear_Skill_MaxEXP)
			Skill_LevelGain_MaxExpGain()
			_message(src,"Your spear skill has leveled up!","Aqua")
			src<<sound('levelup.wav')
		if(src.Axe_Skill_EXP>=Axe_Skill_MaxEXP)
			Skill_LevelGain_MaxExpGain()
			_message(src,"Your axe skill has leveled up!","Aqua")
			src<<sound('levelup.wav')
		if(src.HandToHand_Skill_EXP>=HandToHand_Skill_MaxEXP)
			Skill_LevelGain_MaxExpGain()
			_message(src,"Your hand to hand skill has leveled up!","Aqua")
			src<<sound('levelup.wav')

	LevelUP()
		if(src.EXP>=MaxEXP)
			LevelGain_MaxExpGain()
			_message(src,"You've gained a level!","Aqua")
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
				src.Strength-=WeaponBoost
				src.Strength=src.MaxStrength
				src.Strength+=WeaponBoost
			//src.SkillGive()
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

obj/Can_Build/proc

	Obj_DeathCheck()
		src.update_health_bar()
		if(src.Health<=0)
			del src

	Damage(D)
		if(Health<D)
			Health=0
			return
		else
			Health=Health-D
			new/effect/damage(src.loc,"<font color=red><b>[round(D)]</b></font>")
			return