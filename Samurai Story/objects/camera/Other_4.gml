view_enabled = true
view_visible[0] = true
if (instance_exists(obj_player)) camera_set_view_pos(view_camera[0], obj_player.x - GAME_WIDTH / 2, obj_player.y - GAME_HEIGHT / 2)