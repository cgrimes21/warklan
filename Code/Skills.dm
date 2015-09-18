
mob
	verb
		ShowSkills()
			set hidden = 1
			if(!usr.ShowingSkills)
				usr.ShowingSkills=1
				winset(usr,"Skills","is-visible=true")
				usr.SkillShow()
				usr.SkillAlign()
				return
			else
				usr.ShowingSkills=0
				winset(usr,"Skills","is-visible=false")
				return
		ShowSkillLevel()
			set hidden = 1
			if(!usr.ShowingSkillLevels)
				usr.ShowingSkillLevels=1
				usr.SkillLevelShow()
				usr.Clicking()
				usr << "[usr.inDungeon]"
				winset(usr,"Main.MainMap","focus=true")
				return
			else
				usr.ShowingSkillLevels=0
				usr.Clicking()
				winset(usr,"SkillLevels","is-visible=false")
				winset(usr,"Main.MainMap","focus=true")

				return
	proc
		SkillLevelShow()
			winset(usr,"SkillLevels","is-visible=true")
			winset(usr,"SkillLevels.SwordSkillLevel","text = 'Level: [src.Sword_Skill_Level]'")
			winset(usr,"SkillLevels.SwordSkillEXP","text = 'EXP: [src.Sword_Skill_EXP]/[src.Sword_Skill_MaxEXP]'")
			winset(usr,"SkillLevels.SpearSkillLevel","text = 'Level: [src.Spear_Skill_Level]'")
			winset(usr,"SkillLevels.SpearSkillEXP","text = 'EXP: [src.Spear_Skill_EXP]/[src.Spear_Skill_MaxEXP]'")
			winset(usr,"SkillLevels.AxeSkillLevel","text = 'Level: [src.Axe_Skill_Level]'")
			winset(usr,"SkillLevels.AxeSkillEXP","text = 'EXP: [src.Axe_Skill_EXP]/[src.Axe_Skill_MaxEXP]'")
			winset(usr,"SkillLevels.HandToHandSkillLevel","text = 'Level: [src.HandToHand_Skill_Level]'")
			winset(usr,"SkillLevels.HandToHandSkillEXP","text = 'EXP: [src.HandToHand_Skill_EXP]/[src.HandToHand_Skill_MaxEXP]'")
			if(!usr.skillsTutorialDone&&usr.skillsTutorialActivated)
				usr.HudDelete_Tut4()
				usr.skillsTutorialDone=1
				_message(src, "<font color=green>New Task Unlocked: <font color=white>Destroy Clan Base!</font>","white")


		SkillAlign()
			spawn while(src.ShowingSkills)
				if(!src){return}
				if(!client){return}
				var/a=winget(src,"Main","pos")
				var/chatx=text2num(copytext(a,1,","))
				if(!src){return}
				if(!client){return}
				var/chaty=text2num(copytext(a,findtext(a,",")+1))
				if(!src){return}
				if(!client){return}
				winset(src,"Skills","pos=[chatx+2],[chaty+100]")
				sleep(world.tick_lag)
		SkillShow()
			spawn while(src.ShowingSkills)
				var/W=0
				for(var/obj/Skills/Z in src.Skills)
					W++
				var/w=W
				var/i=0
				if(!src){return}
				if(!client){return}
				winset(src,"Skills.SkillG",{"cells="2x[w]""})
				if(!src){return}
				if(!client){return}
				winset(src,"Skills.SkillG",{"current-cell="1,1""})
				for(var/obj/Skills/I in src.Skills)
					winset(src,"Skills.SkillG",{"current-cell="1,[++i]""})
					src<<output(I,"Skills.SkillG")
					if(!src){return}
					if(!client){return}
					winset(src,"Skills.SkillG",{"current-cell="2,[i]""})
					if(I.CoolDown>0)
						src<<output("<font size=+2.5><font color=#A0C8C6>[I.CoolDown]</font></font>","Skills.SkillG")
					else
						src<<output("<font size=+2.5><font color=green>Can Fire</font></font>","Skills.SkillG")
				sleep(world.tick_lag)

obj/Skills
	layer=999
	var
		Costs=0
		CoolDown=0
		LearnLevel=0
		Index=0
		SkillLevel=1
		Exp=0
		MaxExp=0
	DblClick()
		return
	Click()
		if(src in usr.Skills)
			src.Activate(src,usr)
		return
	MouseDrop(obj/over_object, src_location, over_location, src_control, over_control, params_text)
		if(src == over_object)
			return

		var/params = params2list(params_text)

		var/screen_loc = params["screen-loc"]
		var/screen_loc_lst = dd_text2list(screen_loc, ",")
		var/screen_loc_non_pixel_lst = list()

		for(var/loc in screen_loc_lst)
			var/loc_lst = dd_text2list(loc, ":")
			screen_loc_non_pixel_lst += loc_lst[1]

		screen_loc = dd_list2text(screen_loc_non_pixel_lst, ",")

		if(istype(over_object, /obj/Huds/SkillHuds/))
			switch(screen_loc)
				if("14,1")
					src.screen_loc = "14:4,1"
					usr.MacroOne=src.name
				if("15,1")
					src.screen_loc = "15:8,1"
					usr.MacroTwo=src.name

				if("16,1")
					src.screen_loc = "16:12,1"
					usr.MacroThree=src.name
				if("17,1")
					src.screen_loc = "17:16,1"
					usr.MacroFour=src.name
			usr.client.screen -= src
			usr.client.screen += src



	proc
		Activate(obj/Skills/S,mob/usr)
			if(CoolDown>0)
				_message(usr,"Wait For The CoolDown","purple")
				return
			if(usr.Stamina<Cost)
				_message(usr,"You Don't Have The Stamina To Use This Skill","purple")
				return
			else
				usr.utilize(S.Cost)
				spawn()usr.Skill(S.Index)

	DPole
		name="Divine Pole"
		Cost=15
		Index=2
		icon='Skills.dmi'
		icon_state="FSlash"
		LearnLevel=6
		SkillLevel=1
		MaxExp=50

	RHurricane
		name="Roaring Hurricane"
		Cost=20
		Index=3
		icon='Skills.dmi'
		icon_state="FSlash"
		LearnLevel=14
		SkillLevel=1
		MaxExp=50

	FSlash
		name="Forward Slash"
		Cost=10
		Index=1
		icon='Skills.dmi'
		icon_state="FSlash"
		LearnLevel=3
		SkillLevel=1
		MaxExp=50
	SWhirlwind
		name="Shrieking Whirlwind"
		Cost=40
		Index=4
		icon='Skills.dmi'
		icon_state="FSlash"
		LearnLevel=10
		SkillLevel=1
		MaxExp=50
	HTyphoon
		name="Howling Typhoon"
		Cost=60
		Index=5
		icon='Skills.dmi'
		icon_state="FSlash"
		LearnLevel=20
		SkillLevel=1
		MaxExp=50


mob
	proc
		Skill(i)
			switch(i)
				if(1)
					src.FSlash()
				if(2)
					src.DPole()
				if(3)
					src.RHurricane()
				if(4)
					src.SWhirlwind()
				if(5)
					src.HTyphoon()
mob/proc

	RHurricane()
		for(var/obj/Skills/RHurricane/F in usr.Skills)
			F.CoolDown=1
			spawn(5)
				F.CD()
			src.utilize(F.Cost)
			if(!Player)
				return
			if(Slashing)
				return
			for(var/mob/M in oview(2))
				if(M.NPC == 1)
					return
				if(M.Dead==1)
					return
				if(M.Dying==1)
					return
				if(src.Dead==1)
					return
				if(src.Dying==1)
					return
				if(src.Punching)
					return
				else
					if(src.dir==get_dir(usr,M))
						Punching=1;spawn(8)Punching=0
						flick("Two Sword Slash",src)
						var/obj/Effects/Wind/A=new/obj/Effects/Wind()
						var/obj/Effects/Wind/B=new/obj/Effects/Wind()
						var/obj/Effects/Wind/C=new/obj/Effects/Wind()
						var/obj/Effects/Wind/D=new/obj/Effects/Wind()
						A.loc=M.loc
						A.y+=3
						B.loc=M.loc
						B.y-=3
						C.loc=M.loc
						C.x+=3
						D.loc=M.loc
						D.x-=3
						if(M.Blocking)
							var/tmp/damage=round(src.Strength+45)-(M.Defense)
							damage=damage/1.5
							if(damage<=0)
								damage=rand(1,50)
							M.Damage(damage)
							M.Damage(damage)
							if(M.Stamina<=0)
								M.Blocking=0
								M.icon_state=""
							M.DeathCheck(src,M)
							return
						else
							var/tmp/damage=round(src.Strength+60)-(M.Defense)
							if(damage<=0)
								damage=rand(1,80)
							M.Damage(damage)
							M.Damage(damage)
							M.DeathCheck(src,M)
							return

	DPole()
		for(var/obj/Skills/DPole/F in usr.Skills)
			F.CoolDown=1
			spawn(5)
				F.CD()
			src.utilize(F.Cost)
			if(!Player)
				return
			if(Slashing)
				return
			for(var/mob/M in oview(1))
				if(M.NPC == 1)
					return
				if(M.Dead==1)
					return
				if(M.Dying==1)
					return
				if(src.Dead==1)
					return
				if(src.Dying==1)
					return
				if(src.Punching)
					return
				else
					if(src.dir==get_dir(usr,M))
						Punching=1;spawn(8)Punching=0
						flick("One Sword Slash",src)
						var/obj/Effects/Wind/A=new/obj/Effects/Wind()
						A.loc=M.loc
						if(M.Blocking)
							var/tmp/damage=round(src.Strength+45)-(M.Defense)
							damage=damage/1.5
							if(damage<=0)
								damage=rand(1,50)
							flick("Knock Back",M)
							M.Damage(damage)
							M.Stamina-=rand(1,15)
							if(M.Stamina<=0)
								M.Blocking=0
								M.icon_state=""
							M.DeathCheck(src,M)
							return
						else
							var/tmp/damage=round(usr.Strength+20)-(M.Defense)
							if(damage<=0)
								damage=rand(1,80)
							M.Damage(damage)
							M.DeathCheck(src,M)
							return


	FSlash()
		for(var/obj/Skills/FSlash/F in usr.Skills)
			F.CoolDown=2
			spawn(5)
				F.CD()
			src.utilize(F.Cost)
			src.Slashing=1
			sleep(2)
			if(src.Dead==1)
				src.Slashing=0
				return
			if(src.Dying==1)
				src.Slashing=0
				return
			if(src.Punching)
				src.Slashing=0
				return
			for(var/mob/M in oview(3))
				src.icon_state="Dash"
				src.SlashDmg=round(src.Strength+30)-(M.Defense)
				src.SlashDmg=src.SlashDmg/1.5
				if(src.SlashDmg<=0)
					src.SlashDmg=rand(20,90)
				src.Slashing=1
				src.speed=20
				walk(src,src.dir)
				spawn(2)
					src.speed=4
					walk(src,0)
					src.Slashing=0
					src.SlashDmg=0
					src.icon_state=""
	SWhirlwind()
		for(var/obj/Skills/SWhirlwind/F in usr.Skills)
			F.CoolDown=2
			spawn(5)
				F.CD()
			src.utilize(F.Cost)
			src.Slashing=1
			sleep(5)
			if(src.Dead==1)
				src.Slashing=0
				return
			if(src.Dying==1)
				src.Slashing=0
				return
			if(src.Punching)
				src.Slashing=0
				return
			for(var/mob/M in oview(4))
				src.SWhirlwind=1
				src.icon_state="Flash Step"
				src.SlashDmg=round(src.Strength+70)-(M.Defense)
				src.SlashDmg=src.SlashDmg/1.5
				if(src.SlashDmg<=0)
					src.SlashDmg=rand(40,120)
				src.Slashing=1
				src.speed=30
				walk(src,src.dir)
				spawn(2)
					src.speed=4
					walk(src,0)
					src.SWhirlwind=0
					src.Slashing=0
					src.SlashDmg=0
					src.icon_state=""
	HTyphoon()
		for(var/obj/Skills/HTyphoon/F in usr.Skills)
			F.CoolDown=2
			spawn(5)
				F.CD()
			src.utilize(F.Cost)
			src.Slashing=1
			src.HTyphoon=1
			sleep(10)
			if(src.Dead==1)
				src.Slashing=0
				src.HTyphoon=0
				return
			if(src.Dying==1)
				src.Slashing=0
				return
			if(src.Punching)
				src.Slashing=0
				return
			for(var/mob/M in oview(4))
				src.icon_state="Dash"
				src.SlashDmg=round(src.Strength+80)-(M.Defense)
				src.SlashDmg=src.SlashDmg/1.5
				if(src.SlashDmg<=0)
					src.SlashDmg=rand(60,190)
				src.speed=40
				walk(src,src.dir)
				spawn(2)
					src.speed=4
					walk(src,0)
					src.Slashing=0
					src.SlashDmg=0
					src.icon_state=""
mob
	Bump(atom/a)
		if(ismob(a))
			if(src.Slashing)
				walk(src,0)
				src.Slashing=0
				if(a:NPC)
					src.HTyphoon=0
					src.SlashDmg=0
					src.icon_state=""
					return
				if(a:Dead==1)
					src.HTyphoon=0
					src.SlashDmg=0
					src.icon_state=""
					return
				if(a:Dying==1)
					src.HTyphoon=0
					src.SlashDmg=0
					src.icon_state=""
					return
				else
					src.icon_state=""
					if(src.SWhirlwind==1)
						a:Damage(src.SlashDmg)
					if(src.HTyphoon==1)
						var/obj/Effects/Wind/A=new/obj/Effects/Wind()
						var/obj/Effects/Wind/B=new/obj/Effects/Wind()
						var/obj/Effects/Wind/C=new/obj/Effects/Wind()
						var/obj/Effects/Wind/D=new/obj/Effects/Wind()
						A.loc=a:loc
						A.y+=3
						B.loc=a:loc
						B.y-=3
						C.loc=a:loc
						C.x+=3
						D.loc=a:loc
						D.x-=3
						a:Damage(src.SlashDmg)
					src.HTyphoon=0
					src.SWhirlwind=0
					a:Damage(src.SlashDmg)
					a:DeathCheck(src,a)