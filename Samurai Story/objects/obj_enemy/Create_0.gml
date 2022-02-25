// types = idle, walk
// idle == ficar parado enquanto não estiver perseguindo
// walk == andar em um padrão enquanto não estiver persequindo

knockout = false
chase = false

velx = 0
vely = 0
spd = 1.25
collider = {}
collider.x = x - sprite_width / 2
collider.y = y - sprite_height / 4
collider.s = 8

function die() {
	if (knockout) {
		sprite_index = spr_enemy_knockout
	}
}

function chase_player() {
	if(!knockout) {
		if (!collision_line(x, y, obj_player.x, obj_player.y, obj_solid, false, false)) {
			chase = true
		} else if (chase && alarm[0] < 0) {
			alarm[0] = 15
		}
		if (chase) {
			direction = point_direction(x, y, obj_player.x, obj_player.y)
			image_angle = direction
			
			velx = lengthdir_x(spd, direction)
			if (collision_rectangle((collider.x + velx), collider.y, (collider.x + velx) + collider.s, collider.y + collider.s, obj_solid, false, false)) {
				while (!collision_rectangle((collider.x + sign(velx)), collider.y, (collider.x + sign(velx)) + collider.s, collider.y + collider.s, obj_solid, false, false)) {
					collider.x += sign(velx)
				}
				velx = 0
			}
			collider.x += velx
	
			vely = lengthdir_y(spd, direction)
			if (collision_rectangle(collider.x, (collider.y + vely), collider.x + collider.s, (collider.y + vely) + collider.s, obj_solid, false, false)) {
				while (!collision_rectangle(collider.x, (collider.y + sign(vely)), collider.x + collider.s, (collider.y + sign(vely)) + collider.s, obj_solid, false, false)) {
					collider.y += sign(vely)
				}
				vely = 0
			}
			collider.y += vely
	
			x = collider.x + sprite_width / 2
			y = collider.y + sprite_height / 4
		}
	}
}