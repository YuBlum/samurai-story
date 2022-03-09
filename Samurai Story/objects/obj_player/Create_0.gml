spd = 1.5
hit = noone
can_hit = true
velx = 0
vely = 0
collider = {}
collider.x = x - sprite_width / 8
collider.y = y - sprite_height / 4
collider.s = 8
hp = Player_Life
knockback = false
knockback_time = 10
knockback_dir = 0
knockout = false
arm = spr_player_cut_down
arm_subimage = 0
arm_rot = 0
arm_time = 0
depth = 0

legs = spr_player_legs
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
function die() {
	if (hp <= 0) {
		knockout = true
		hp = 0
	}
	if (knockout) {
		sprite_index = spr_player_knockout
		if (hit != noone) {
			instance_destroy(hit)
		}
		depth = 10
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

function move() {
	if (!knockout) {
		var _movx = keyboard_check(ord("D")) - keyboard_check(ord("A"))
		var _movy = keyboard_check(ord("S")) - keyboard_check(ord("W"))

		var _dir = point_direction(0, 0, _movx, _movy)
		var _len = ((_movx != 0) || (_movy != 0)) * spd
		force(_len, _dir)
		if (_len != 0) {
			arm_time += 0.1
			arm_rot = sin(arm_time) * 12
			if (alarm[4] < 0) alarm[4] = 2
		}
	
		direction = point_direction(x, y, mouse_x, mouse_y)
		image_angle = direction
	}
}

function start_knockback(_dir) {
	if (!knockout && !knockback) {
		knockback = true
		knockback_dir = _dir
		camera.shake(5, 2)
	}
}

function move_back() {
	if (!knockout) {
		if (hit != noone) {
			instance_destroy(hit)
			hit = noone
			can_hit = true
		}
		if (alarm[2] < 0) alarm[2] = knockback_time
		force(spd, knockback_dir)
	}
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
	if (!knockout) {
		if (hit == noone) {
			if (mouse_check_button_pressed(mb_left) && can_hit) {
				hit = instance_create_depth(x, y, -1, obj_hit)
				hit.sprite_index = spr_hit_player
				can_hit = false
				camera.shake(3, 1)
			}
		} else {
			if (arm_subimage < 5 /* 6 = amount of frames */) {
				if (alarm[3] < 0) alarm[3] = 2
			} else if (alarm[0] < 0) {
				alarm[0] = 5
			}
			with (obj_enemy) {
				if (place_meeting(x, y, other.hit)) {
					hp--
					if (hp <= 0 && !knockout) {
						knockout = true
						Enemy_Count--
					}
					instance_destroy(other.hit)
					other.hit = noone
					other.alarm[1] = 30
					repeat (irandom_range(15, 30)) instance_create_depth(x, y, depth + 1, obj_part_blood)
					if (!audio_is_playing(sfx_hit)) audio_play_sound(sfx_hit, 10, false)
				}
			}
		}
		update_hit()
	}
}

function recover() {
	if (!knockout) {
		var _other = instance_place(x, y, obj_recover)
		if (_other != noone) {
			instance_destroy(_other)
			hp += irandom_range(5, 15)
			//hp = (hp > 100) ? 100 : hp
		}
	}
}
