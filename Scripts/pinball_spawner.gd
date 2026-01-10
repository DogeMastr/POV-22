extends Node2D

@export var pinball_packed: PackedScene
@export var launch_force := Vector2(-100.0, -5000.0)

var to_launch = null


func _ready() -> void:
	spawn_uninit()


func get_pinballs() -> Array[Node]:
	return get_tree().get_nodes_in_group("ballz")


func spawn_uninit():
	var inst := pinball_packed.instantiate()
	inst.position = $SpawnPos.position	
	to_launch = inst
	add_child(to_launch)


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("PinballLaunch") and to_launch != null:
		to_launch.apply_force(launch_force)
		to_launch = null
