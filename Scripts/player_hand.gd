extends Node2D

@onready var container = $Hand_Container

var set_position

var screen_size
var lerp_strength = 5.0


func _ready() -> void:
	set_position = container.global_position
	screen_size = get_viewport().get_visible_rect().size


func _process(delta: float) -> void:
	var mouse_pos = get_viewport().get_mouse_position()
	if not EventBus.is_dead:
		container.global_position = container.global_position.slerp(mouse_pos + screen_size/4,lerp_strength * delta)
	else:
		container.global_position = container.global_position.slerp(set_position,lerp_strength * delta)
		
