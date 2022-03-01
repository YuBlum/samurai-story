die()
if (bullets <= 0 && gun) {
	gun = false
	attack = attack_hand
	arm = choose(spr_enemy_punch_down, spr_enemy_punch_up)
	instance_create_depth(x, y, depth-1, obj_gun)
}
attack()
