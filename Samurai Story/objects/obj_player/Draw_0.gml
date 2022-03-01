if (!knockout) {
	draw_sprite_ext(legs, legs_subimage, x, y, 1, 1, direction, c_white, 1)
	draw_sprite_ext(arm, arm_subimage, x, y, 1, 1, direction + arm_rot, c_white, 1)
}
draw_self()
//draw_rectangle(collider.x, collider.y, collider.x + collider.s, collider.y + collider.s, true)
