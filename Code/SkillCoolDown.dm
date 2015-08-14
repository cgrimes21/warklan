obj/Skills
	proc
		CD()
			spawn while(CoolDown>=0)
				if(CoolDown<=0)
					CoolDown=0
					return
				else
					CoolDown-=1
				sleep(10)
mob
	proc
		CDCHECK()
			for(var/obj/Skills/S in src.Skills)
				S.CD()
			return