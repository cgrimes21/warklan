var/list/clan/clans = list()

clan
	var
		name = ""
		leader = ""
		level
		reputation
		exp
		mexp
		clan/war

	proc/Create_Clan(var/n, var/l)	//n is the name of the new clan
		for(var/clan/c in clans)
			if(c.name == ckey(n))
				debuggers << "[n] clan name is already taken."
				return

		name = ckey(n)
		leader = ckey(l)
		level = 1
		reputation = 1
		exp = 0
		mexp = 400
		debuggers<<"[n] clan created. Leader: [l]"


	proc/Issue_War(var/clan/who)
		if(src.war != null)
			return

		world<<"[src.name] has issued war with [who.name]!"
		src.war = who
		who.war = src

	proc/Issue_Peace()
		if(src.war)
			if(src.war.war.name == src.name)	//they are at war with you
				world<<"Peace has come between [src.war.name] and [src.name]!"
				src.war.war = null
				src.war = null



mob
	verb
		Request_Duel(mob/M in oview(1))
			//regular pvp challenge

		Declare_Clan_War(mob/M in oview(1))
			if(!M.client)
				return
			if(!usr.client)
				return
			if(!usr.clan)
				return
			if(!M.clan)
				return
		//	if(M.clan.leader!=ckey(M.name))
		//		return
			//if(ClanArenaFilled)
			//	return
			if(usr.clan.leader!=ckey(usr.name))	//you need to be the boss
				return

			src.clan.Issue_War(M.clan)	//my clan issues war with their clan

			//else
			//	ClansCheck=usr.Clan
			//	ClansLeader=usr.ClanLeader
			//	winset(M,"ClanT","is-visible=true")
			//	return
	/*
	Clan(var/T as text)
			if(T=="Yes")
				winset(usr,"ClanT","is-visible=false")
				ClanArenaFilled=1
				ClanOne=ClansCheck
				ClanTwo=usr.Clan
				for(var/mob/S in world)
					if(S.ClanLeader==usr.ClanLeader)
						S.loc=locate(4,39,3)
					//	S.ClanFighting=1
						ClanOneMembers+=1
				for(var/mob/V in world)
					if(V.ClanLeader==ClansLeader)
						V.loc=locate(91,39,3)
						V.Clan2Fighting=1
						ClanTwoMembers+=1
			if(T=="No")
				ClansCheck=""
				winset(usr,"ClanT","is-visible=false")
				return
				*/
mob/DblClick()
	for(var/mob/M in oview(1))
		if(!M.client)
			return
		if(!usr.client)
			return
		if(usr.InClan)
			if(usr.ClanLeader!=usr.Name)
				return
			else
				if(M.InClan==0)
					switch(alert(M,"Would you like to join [usr]'s Clan?","Clan Join","Yes","No"))
						if("Yes")
							M.InClan=1
							M.ClanLevel=usr.ClanLevel
							M.ClanExp=usr.ClanExp
							M.ClanMaxExp=usr.ClanMaxExp
							M.ClanLeader=usr.Name
							M.ClanGold=usr.ClanGold
							M.Clan=usr.Clan
							_message(world,"<b><font color=blue>[M.name]:</font> Has Joined The Clan [usr.Clan]</b>","red")
							return
						if("No")
							_message(usr,"<font color=blue>[M.name]:</font> has denied your request","red")
							return