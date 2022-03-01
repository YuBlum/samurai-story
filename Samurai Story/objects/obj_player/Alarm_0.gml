if (hit != noone) {
	instance_destroy(hit)
	hit = noone
	alarm[1] = 30	
}
arm = arm == spr_player_cut_down ? spr_player_cut_up : spr_player_cut_down
arm_subimage = 0