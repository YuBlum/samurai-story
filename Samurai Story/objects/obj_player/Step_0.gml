var _movx = keyboard_check(ord("D")) - keyboard_check(ord("A"))
var _movy = keyboard_check(ord("S")) - keyboard_check(ord("W"))

var _dir = point_direction(0, 0, _movx, _movy)
var _len = ((_movx != 0) || (_movy != 0)) * spd

x += lengthdir_x(_len, _dir)
y += lengthdir_y(_len, _dir)

direction = point_direction(x, y, mouse_x, mouse_y)
image_angle = direction