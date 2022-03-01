if (!knockout && hit != noone) {
	instance_destroy(hit)
	hit = noone
	alarm[2] = 30
	arm = arm == spr_enemy_punch_down ? spr_enemy_punch_up : spr_enemy_punch_down
	arm_subimage = 0
}