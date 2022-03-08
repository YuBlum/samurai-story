if (place_meeting(x, y, obj_player) && Enemy_Count <= 0 && !obj_player.knockout) {
	Player_Life = obj_player.hp
	room_goto_next()
}