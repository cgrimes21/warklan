mob/proc
	BlackSmith()
		var/obj/NPCs/Items/Stone_Sword/A=new/obj/NPCs/Items/Stone_Sword
		var/obj/NPCs/Items/Stone_Spear/C=new/obj/NPCs/Items/Stone_Spear
		var/obj/NPCs/Items/Stone_Axe/B=new/obj/NPCs/Items/Stone_Axe

		var/obj/NPCs/Items/Bronze_Sword/D=new/obj/NPCs/Items/Bronze_Sword
		var/obj/NPCs/Items/Bronze_Spear/F=new/obj/NPCs/Items/Bronze_Spear
		var/obj/NPCs/Items/Bronze_Axe/E=new/obj/NPCs/Items/Bronze_Axe

		var/obj/NPCs/Items/Iron_Sword/G=new/obj/NPCs/Items/Iron_Sword
		var/obj/NPCs/Items/Iron_Spear/I=new/obj/NPCs/Items/Iron_Spear
		var/obj/NPCs/Items/Iron_Axe/H=new/obj/NPCs/Items/Iron_Axe

		src.contents+=A
		src.contents+=B
		src.contents+=C

		src.contents+=D
		src.contents+=E
		src.contents+=F

		src.contents+=G
		src.contents+=H
		src.contents+=I
		return

	Doctor()
		var/obj/NPCs/Items/Potion/G=new/obj/NPCs/Items/Potion
		src.contents+=G
		return

	Witch_Doctor()
		var/obj/NPCs/Items/Buff/G=new/obj/NPCs/Items/Buff
		src.contents+=G
		return

	Tailor()
		var/obj/NPCs/Items/Fox_Cub_Tunic/A=new/obj/NPCs/Items/Fox_Cub_Tunic
		var/obj/NPCs/Items/Red_Fox_Coat/B=new/obj/NPCs/Items/Red_Fox_Coat
		var/obj/NPCs/Items/Wolf_Fur_Coat/C=new/obj/NPCs/Items/Wolf_Fur_Coat

		src.contents+=A
		src.contents+=B
		src.contents+=C
