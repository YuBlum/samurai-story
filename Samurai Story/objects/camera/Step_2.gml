camera_set_view_size(VIEW, GAME_WIDTH, GAME_HEIGHT)
// get camera pos
var _x = camera_get_view_x(view_camera[0]), _y = camera_get_view_y(view_camera[0])

// calculate the target position (player and mouse)
var _tx = 0, _ty = 0, _dir2m = 0, _dis2m = 0, _limit = 0
if (instance_exists(obj_player)) {
	_tx = obj_player.x _ty = obj_player.y
	_dir2m = point_direction(_tx, _ty, mouse_x, mouse_y)
	_dis2m = point_distance(_tx, _ty, mouse_x, mouse_y)
	_limit = 30
	_dis2m = _dis2m > _limit ? _limit : _dis2m
	_tx = _tx + lengthdir_x(_dis2m, _dir2m) - GAME_WIDTH / 2
	_ty = _ty + lengthdir_y(_dis2m, _dir2m) - GAME_HEIGHT / 2
}

// shake
var _sx = random_range(-shake_power, shake_power), _sy = random_range(-shake_power, shake_power)

// update camera
var _spd = .025
camera_set_view_pos(view_camera[0], lerp(_x, _tx, _spd) + _sx, lerp(_y, _ty, _spd) + _sy)
camera_set_view_angle(view_camera[0], random_range(-shake_power, shake_power))