if (!knockout && hit != noone) {
	instance_destroy(hit)
	hit = noone
	alarm[2] = 30
	arm = arm == ( boss ? spr_enemy_3_punch_down : (enemy == 1 ? spr_enemy_1_punch_down: spr_enemy_2_punch_down)) ?
		  ( boss ? spr_enemy_3_punch_up : (enemy == 1 ? spr_enemy_1_punch_up: spr_enemy_2_punch_up)) : (boss ? spr_enemy_3_punch_down : (enemy == 1 ? spr_enemy_1_punch_down: spr_enemy_2_punch_down))
	arm_subimage = 0
}