if (!knockout) {
	draw_sprite_ext(legs, legs_subimage, x, y, 1, 1, direction, c_white, 1)
	draw_sprite_ext(arm, arm_subimage, x - lengthdir_x(recoil_offset, direction), y - lengthdir_y(recoil_offset, direction), 1, 1, direction + arm_rot, c_white, 1)
}
draw_self()