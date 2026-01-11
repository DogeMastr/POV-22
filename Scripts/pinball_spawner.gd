extends Node2D

@export var pinball_packed: PackedScene
@export var launch_force := Vector2(-10.0, -10.0)

var to_launch = []

func _ready() -> void:
	spawn_uninit()
	

func get_pinballs() -> Array[Node]:
	return get_tree().get_nodes_in_group("ballz")


func spawn_uninit():
	var inst := pinball_packed.instantiate()
	inst.position = $SpawnPos.position	
	to_launch.push_back(inst)
	add_child(inst)


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("PinballLaunch") and to_launch != null and not EventBus.is_dead:
		for item in to_launch:
			item.apply_force(launch_force)
		to_launch = []
