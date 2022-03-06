prv_collide = collide
collide = place_meeting(x, y, obj_player) || place_meeting(x, y, obj_enemy)
if ((collide && !prv_collide) && spd <= 0) {
	dir = obj_player.y < y ? -1 : 1
	spd = 4
}

if (spd > 0) {
	spd -= 0.1
	image_angle += dir * spd
	direction = image_angle
}