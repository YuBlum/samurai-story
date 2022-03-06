window_set_size(GAME_WIDTH * Window_Scale, GAME_HEIGHT * Window_Scale)
alarm[0] = 1
surface_resize(application_surface, GAME_WIDTH * Window_Scale, GAME_HEIGHT * Window_Scale)

shake_power = 0
shaking = false

function shake(_time, _power) {
	if (!shaking) {
		alarm[1] = _time
		shake_power = _power
		change_shake = true
	}
}