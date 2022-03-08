prv_collide = collide
var _enemy = instance_place(x, y, obj_enemy)
collide = place_meeting(x, y, obj_player) || (_enemy != noone && !_enemy.knockout)
if ((collide && !prv_collide) && spd <= 0) {
	if (!hor) {
		dir = obj_player.y < y ? -1 : 1
	} else {
		dir = obj_player.x > x ? -1 : 1
	}

	spd = 4
}

if (spd > 0) {
	spd -= 0.1
	image_angle += dir * spd
	direction = image_angle
}