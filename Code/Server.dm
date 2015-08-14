mob
	var/tmp/Servers=0
	verb
		Servers()
			set hidden = 1
			if(!Servers)
				winset(usr,"Server","is-visible=true")
				Servers=1
				usr.ServerAlign()
				usr.ServerCheck()
			else
				winset(usr,"Server","is-visible=false")
				Servers=0
		Connect(T as text)
			if(T=="1")
				usr<<link("byond://68.42.124.151:20000")
	proc
		ServerAlign()
			spawn while(src)
				if(!src){return}
				if(!client){return}
				var/a=winget(src,"Main","pos")
				var/chatx=text2num(copytext(a,1,","))
				if(!src){return}
				if(!client){return}
				var/chaty=text2num(copytext(a,findtext(a,",")+1))
				if(!src){return}
				if(!client){return}
				winset(src,"Server","pos=[chatx+372],[chaty+110]")
				sleep(world.tick_lag)

		ServerCheck()
			spawn while(src.Servers==1)
				if(!src){return}
				if(!client){return}
				var/MainServer = world.Export("byond://68.42.124.151:20000?ping")
				if(!src){return}
				if(!client){return}
				if(MainServer)
					winset(src,"Server1","text-color=green")
				sleep(100)