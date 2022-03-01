die()
if (bullets <= 0 && gun) {
	gun = false
	attack = attack_hand
	arm = choose(spr_enemy_punch_down, spr_enemy_punch_up)
}
attack()
