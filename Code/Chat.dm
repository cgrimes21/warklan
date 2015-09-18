mob/proc
	align()
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
			winset(src,"chat","pos=[chatx+3],[chaty+537]")
			sleep(world.tick_lag)
obj
	back
		icon='chatbox_bg.dmi'
		layer=500
		screen_loc="1,1 to 11,5"
		New(client/C)
			C.screen+=src
	OOC
		icon='Buttons.dmi'
		layer=500
		screen_loc="12,1"
		New(client/C)
			C.screen+=src
		Click()
			usr.OOC2()
			return
proc
	_message(Person,msg,color)
		if(!Person)
			return
		if(!msg||msg==""||msg==null)
			return

		if(istype(Person,usr))
			usr<<"<b><font color=[color]> [msg] </font></b>"
			return
		if(istype(Person,src))
			src<<"<b><font color=[color]> [msg] </font></b>"
			return
		if(istype(Person,world))
			world<<"<b><font color=[color]> [msg] </font></b>"
			return
mob
	var/tmp/Chating=0
	verb
		OOC(T as text|null)
			if(!usr.Player){return}
			if(T==""||T==null)
				usr.Chating = 0
				usr.OOC = 0
				winset(usr,"Main.MainMap","focus=true")
				return
			if(usr.Mute)
				_message(usr, "<b><font color=#ff7f00>[usr.Name]</font>: You're Muted</b>","white")
				return
			usr.Chating=0
			winset(usr,"Main.MainMap","focus=true")
			_message(world, "<b><font color=[textColor]>[usr.Name]</font>: [html_encode(T)]</b>","white")
			usr.OOC=0
			return
		Chat()
			set hidden=1
			if(usr.Chating)
				winset(usr,"Main.MainMap","focus=true")
				usr.Chating=0
				return
			else
				usr.Chating=1
				winset(usr,"Chat.Input","focus=true")
				return
	proc
		OOC2()
			if(!src.Player){return}
			var/T = winget(src,"Chat.Input","text")
			if(T==""||T==null)
				return
			if(src.Mute)
				_message(src, "<b><font color=#7F00FF>[usr.Name]</font>: You're muted</b>","white")
				return
			_message(world, "<b><font color=#A0C8C6>[usr.Name]</font>: [html_encode(T)]</b>","white")
			winset(src,"Chat.Input","text=")
			winset(src,"Main.Map","focus=true")
			winset(src,"Chat.Input","focus=false")
			src.Chating=0
			return