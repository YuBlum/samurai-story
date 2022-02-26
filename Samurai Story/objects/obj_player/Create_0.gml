spd = 1.5
hit = noone
can_hit = true
velx = 0
vely = 0
collider = {}
collider.x = x - sprite_width / 2
collider.y = y - sprite_height / 4
collider.s = 8

function move() {
	var _movx = keyboard_check(ord("D")) - keyboard_check(ord("A"))
	var _movy = keyboard_check(ord("S")) - keyboard_check(ord("W"))

	var _dir = point_direction(0, 0, _movx, _movy)
	var _len = ((_movx != 0) || (_movy != 0)) * spd

	velx = lengthdir_x(_len, _dir)
	if (collision_rectangle((collider.x + velx), collider.y, (collider.x + velx) + collider.s, collider.y + collider.s, obj_solid, false, false)) {
		while (!collision_rectangle((collider.x + sign(velx)), collider.y, (collider.x + sign(velx)) + collider.s, collider.y + collider.s, obj_solid, false, false)) {
			collider.x += sign(velx)
		}
		velx = 0
	}
	collider.x += velx
	
	vely = lengthdir_y(_len, _dir)
	if (collision_rectangle(collider.x, (collider.y + vely), collider.x + collider.s, (collider.y + vely) + collider.s, obj_solid, false, false)) {
		while (!collision_rectangle(collider.x, (collider.y + sign(vely)), collider.x + collider.s, (collider.y + sign(vely)) + collider.s, obj_solid, false, false)) {
			collider.y += sign(vely)
		}
		vely = 0
	}
	collider.y += vely
	
	x = collider.x + sprite_width / 2
	y = collider.y + sprite_height / 4
	
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
		if (mouse_check_button_pressed(mb_left) && can_hit) {
			hit = instance_create_depth(x, y, -1, obj_hit)
			alarm[0] = 20 // TODO: mudar isso para destruir quando a animação de ataque terminar.
			can_hit = false
		}
	} else {
		with (obj_enemy) {
			if (place_meeting(x, y, obj_hit)) {
				knockout = true
			}
		}
	}
	update_hit()
}