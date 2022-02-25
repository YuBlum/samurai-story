spd = 2
hit = noone

function move() {
	var _movx = keyboard_check(ord("D")) - keyboard_check(ord("A"))
	var _movy = keyboard_check(ord("S")) - keyboard_check(ord("W"))

	var _dir = point_direction(0, 0, _movx, _movy)
	var _len = ((_movx != 0) || (_movy != 0)) * spd

	x += lengthdir_x(_len, _dir)
	y += lengthdir_y(_len, _dir)

	direction = point_direction(x, y, mouse_x, mouse_y)
	image_angle = direction
}

function update_hit() {
	if (hit != noone) {
		hit.direction = direction
		hit.image_angle = direction
		hit.x = x
		hit.y = y
	}
}

function attack() {
	if (hit == noone) {
		if (mouse_check_button_pressed(mb_left)) {
			hit = instance_create_depth(x, y, -1, obj_player_hit)
			alarm[0] = 20 // TODO: mudar isso para destroir quando a animação de ataque terminar.
		}
	} else {
		with (obj_enemy) {
			if (place_meeting(x, y, obj_player_hit)) {
				knockout = true
			}
		}
	}
	update_hit()
}