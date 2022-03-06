function print() {
	var _t = ""
	for (var i = 0; i < argument_count; i++) {
		if (is_string(argument[i])) _t += argument[i]
		else _t += string(argument[i])
	}
	show_debug_message(_t)
}