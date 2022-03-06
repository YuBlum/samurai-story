die()
if (bullets <= 0 && gun) {
	gun = false
	attack = attack_hand
	arm = choose((enemy == 1 ? spr_enemy_1_punch_down: spr_enemy_2_punch_down), (enemy == 1 ? spr_enemy_1_punch_up: spr_enemy_2_punch_up))
	instance_create_depth(x, y, depth-1, obj_gun)
}
attack()
