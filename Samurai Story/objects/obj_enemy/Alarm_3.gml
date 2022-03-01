if (arm_subimage < 11) {
	if (arm_subimage == 5) {
		hit = instance_create_depth(x, y, 1, obj_hit)
		can_hit = false
	}
	arm_subimage++
	alarm[3] = 2
}