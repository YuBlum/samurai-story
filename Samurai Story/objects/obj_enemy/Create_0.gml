// types = idle, walk
// idle == ficar parado enquanto não estiver perseguindo
// walk == andar em um padrão enquanto não estiver persequindo

knockout = false
chase = false

hit = noone
can_hit = true

velx = 0
vely = 0
spd = 1.5
collider = {}
collider.x = x - sprite_width / 8
collider.y = y - sprite_height / 4
collider.s = 8
direction = irandom(360)
image_angle = direction
bullets = irandom_range(3, 10)
hp = choose(1, 1, 1, 2, 2, 3)

enemy = choose(1, 2)
sprite_index = enemy == 2 ? spr_enemy_2_skin : spr_enemy_1_skin

arm = gun ? (enemy == 1 ? spr_enemy_1_gun : spr_enemy_2_gun) : (enemy == 1 ? spr_enemy_1_punch_down : spr_enemy_2_punch_down)
arm_subimage = 0
arm_rot = 0
arm_time = 0
start_punch = false
recoil_offset = 0

legs = enemy == 1 ? spr_enemy_1_legs : spr_enemy_2_legs
legs_subimage = 0

var _amount = irandom_range(3, 10)
blood = []
for (var i = 0; i < _amount; i++) {
	var _dir = irandom(360)
	var _len = irandom_range(2, 10)
	blood[i] = {
		i: irandom(5),
		x: lengthdir_x(_len, _dir),
		y: lengthdir_y(_len, _dir),
		c: irandom_range(100, 200)
	}
}

function force(_len, _dir) {
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
	
	x = collider.x + sprite_width / 8
	y = collider.y + sprite_height / 4
}

function die() {
	if (knockout) {
		sprite_index = enemy == 1 ? spr_enemy_1_knockout: spr_enemy_2_knockout
		if (hit != noone) {
			instance_destroy(hit)
		}
		depth = 10
	}
}

function update_hit() {
	if (hit != noone && !knockout) {
		hit.direction = direction
		hit.image_angle = direction
		hit.x = x
		hit.y = y
	}
}

function attack_hand() {
	if (!obj_player.knockback && !obj_player.knockout) {
		if (!knockout && distance_to_object(obj_player) <= 1 && !start_punch && can_hit) {
			start_punch = true
		}
		if (hit != noone) {
			with (obj_player) {
				if (place_meeting(x, y, other.hit) && !knockback) {
					hp -= irandom_range(5, 15)
					start_knockback(point_direction(other.x, other.y, x, y))
					repeat (irandom_range(15, 30)) instance_create_depth(x, y, depth + 1, obj_part_blood)
				}
			}
		}
		chase_player()
	}
	if (start_punch) {
		if (arm_subimage < 11 /* 12 = amount of frames */) {
			if (alarm[3] < 0) alarm[3] = 2
		} else if (alarm[1] < 0) {
			start_punch = false
			alarm[1] = 5
		}
		/*with (obj_enemy) {
			if (place_meeting(x, y, other.hit)) {
				knockout = true
			}
		}*/
	}
	update_hit()
}

function attack_gun() {
	if (!obj_player.knockback && !obj_player.knockout) {
		if (!knockout && recoil_offset != 0) {
			force(-spd, direction)
		}
		if (!knockout && !collision_line(x, y, obj_player.x, obj_player.y, obj_solid, false, false) && !collision_line(x, y, obj_player.x, obj_player.y, obj_door, false, false)) {
			direction = point_direction(x, y, obj_player.x, obj_player.y)
			image_angle = direction
			if (hit == noone && can_hit) {
				hit = instance_create_depth(x, y, 1, obj_bullet)
				recoil_offset = 2
				alarm[4] = 5
				hit.direction = direction
				can_hit = false
				//alarm[1] = 20
			}
		}
		if (hit != noone) {
			with (obj_player) {
				if (place_meeting(x, y, other.hit)) {
					hp -= 25
					start_knockback(point_direction(other.x, other.y, x, y))
					repeat (irandom_range(15, 30)) instance_create_depth(x, y, depth + 1, obj_part_blood)
				}
			}
			with (hit) {
				if (instance_place(x, y, obj_solid) || instance_place(x, y, obj_door) || instance_place(x, y, obj_player)) {
					instance_destroy()
					other.hit = noone
					other.alarm[2] = 30
					other.bullets--
				}
			}
		}
	}
}

attack = gun ? attack_gun : attack_hand

function chase_player() {
	if(!knockout) {
		if (!collision_line(x, y, obj_player.x, obj_player.y, obj_solid, false, false) &&
		    !collision_line(x, y, obj_player.x, obj_player.y, obj_door,  false, false)) {
			chase = true
		} else if (chase && alarm[0] < 0) {
			alarm[0] = 20
		}
		if (chase && distance_to_object(obj_player) > 0.05) {
			direction = point_direction(x, y, obj_player.x, obj_player.y)
			image_angle = direction
			force(spd, direction)
			if (alarm[5] < 0) alarm[5] = 2
		}
	}
}