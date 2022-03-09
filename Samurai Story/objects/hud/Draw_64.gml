draw_set_font(fnt_regular)
if (room == rm_start) {
	draw_set_halign(fa_center)
	var _c = c_red
	draw_text_transformed_color(GAME_WIDTH / 2, GAME_HEIGHT / 2 - 100 + game_over_offset, "Samurai Story", 2, 2, 0, _c, _c, _c, _c, 1)
	draw_text(GAME_WIDTH / 2, GAME_HEIGHT / 2, "Press 'Enter' to start")
} else if (room == rm_start_2) {
	draw_set_halign(fa_center)
	var _c = c_red
	draw_text_transformed_color(GAME_WIDTH / 2, GAME_HEIGHT / 2 - 10, "Save your daughter\nfrom the yakusa", 1, 1, 0, _c, _c, _c, _c, 1)
} else if (room == rm_end) {
	draw_set_halign(fa_center)
	var _c = c_red
	draw_text_transformed_color(GAME_WIDTH / 2, GAME_HEIGHT / 2 - 50, "Congratulations!\n\nyou killed all yakusas\nand saved your daughter", 1, 1, 0, _c, _c, _c, _c, 1)
} else if (instance_exists(obj_player)) {
	if (!obj_player.knockout) {
		draw_set_halign(fa_left)
		draw_text(0, 0, "life: " + string(obj_player.hp))
		if (Enemy_Count > 0) {
			draw_text(0, 15, "Kill all Enemies")
		} else {
			draw_text(0, 15, "Go to the Ladder")
		}
	} else {
		var _c = c_black
		draw_set_halign(fa_center)
		draw_text_transformed_color(GAME_WIDTH / 2, GAME_HEIGHT / 2 - 100 + game_over_offset, "Game Over!", 2.1, 2.1, 0, _c, _c, _c, _c, 1)
		_c = c_red
		draw_text_transformed_color(GAME_WIDTH / 2, GAME_HEIGHT / 2 - 100 + game_over_offset, "Game Over!", 2, 2, 0, _c, _c, _c, _c, 1)
		draw_text(GAME_WIDTH / 2, GAME_HEIGHT / 2, "Press 'R' to restart")
	}
}