atom/var/tmp/shadows[0]
atom/var/tmp/shadow = 0

/proc/GenerateShadow(atom/A, var/Dir = EAST,P)
	var/icon/s = new('Shadow.dmi')
	var/icon/I = new/icon(A.icon,A.icon_state)
	I.Flip(WEST)
	s.Scale(I.Width(), I.Height())
	I.Blend(s.icon, ICON_MULTIPLY)
	var/shadow/SH = new ; SH.icon = I
	SH.pixel_y -= I.Height()/1.4
	if(Dir== SOUTH)
		SH.pixel_x = 0 ; SH.pixel_y = P ; SH.transform = turn(SH.transform, 180)
	if(Dir == EAST)
		SH.pixel_x += I.Width()/5.1 ; SH.pixel_y = P ; SH.transform = turn(SH.transform, 153)
	if(Dir == WEST)
		SH.pixel_x -= I.Width()/5.1 ; SH.pixel_y = P ; SH.transform = turn(SH.transform, 205)

	A.shadows.Add(SH); A.underlays += SH




shadow
	parent_type = /obj
	layer = 5 ; density = 0 ; alpha = 80

