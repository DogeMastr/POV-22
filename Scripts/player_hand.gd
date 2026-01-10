extends Node2D

@onready var container = $Hand_Container

var set_position

var screen_size
var lerp_strength = 5.0

func _ready() -> void:
	set_position = container.global_position
	screen_size = get_viewport().get_visible_rect().size
	
func _input(event):
	if event is InputEventMouseButton:
		print("Mouse click at: ", event.position)
		print(container.global_position)
		print(lerp(container.global_position, event.position, lerp_strength))

func _process(delta: float) -> void:
	var mouse_pos = get_viewport().get_mouse_position()
	if mouse_pos.x >= screen_size.x * .45:
		container.global_position = container.global_position.slerp(mouse_pos, lerp_strength * delta)
	else:
		container.global_position = container.global_position.slerp(set_position, lerp_strength * delta)
	
	container.global_position.y = clampf(container.global_position.y, screen_size.y/2, screen_size.y)
