//get_speed_delay(n) takes an argument speed "n" and returns how long it would take to travel 1 tile at this speed in 10ths of a second
proc/get_speed_delay(n)
	return (world.icon_size * world.tick_lag) / (!n ? 1 : n)

//get_glide_size(n, dir) takes an argument speed "n", and direction "dir", and returns the smoothest possible glide_size setting
proc/get_glide_size(n, dir)
	return (dir & (dir - 1)) ? n + (n >> 1) : n

atom/movable
	var/speed = 4
	var/tmp/move_time = 0
	var/tmp/transferring = 0

	Move()
		if(!src.loc) return ..()

		if(world.time < src.move_time) return 0

		if(transferring) return 0

		. = ..()

		if(.)
			src.move_time = world.time + get_speed_delay(src.speed)
			src.glide_size = get_glide_size(src.speed, src.dir)

		return .

	proc/Transfer(atom/location)
		if(!location) return

		src.transferring = 1

		spawn(get_speed_delay(src.speed) - world.tick_lag)
			src.x = location.x
			src.y = location.y
			src.z = location.z

			spawn(world.tick_lag)
				src.transferring = 0








client
	East()
		if(usr.Dead)
			return
		if(usr.Dying)
			return
		if(usr.Frozen)
			return
		if(usr.Blocking)
			usr.dir=EAST
			return
		else
			..()

	Northeast()
		if(usr.Dead)
			return
		if(usr.Dying)
			return
		if(usr.Frozen)
			return
		if(usr.Blocking)
			usr.dir=EAST
			return
		else
			..()
	Northwest()
		if(usr.Dead)
			return
		if(usr.Dying)
			return
		if(usr.Frozen)
			return
		if(usr.Blocking)
			usr.dir=EAST
			return
		else
			..()
	Southeast()
		if(usr.Dead)
			return
		if(usr.Dying)
			return
		if(usr.Frozen)
			return
		if(usr.Blocking)
			usr.dir=EAST
			return
		else
			..()
	Southwest()
		if(usr.Dead)
			return
		if(usr.Dying)
			return
		if(usr.Frozen)
			return
		if(usr.Blocking)
			usr.dir=EAST
			return
		else
			..()
	West()
		if(usr.Dead)
			return
		if(usr.Dying)
			return
		if(usr.Frozen)
			return
		if(usr.Blocking)
			usr.dir=WEST
			return
		else
			..()
	North()
		if(usr.Dead)
			return
		if(usr.Dying)
			return
		if(usr.Frozen)
			return
		if(usr.Blocking)
			usr.dir=NORTH
			return
		else
			..()
	South()
		if(usr.Dead)
			return
		if(usr.Dying)
			return
		if(usr.Frozen)
			return
		if(usr.Blocking)
			usr.dir=SOUTH
			return
		else
			..()