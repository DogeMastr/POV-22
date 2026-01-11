extends Node2D

@export var pinball_packed: PackedScene
@export var launch_force := Vector2(-10.0, -10.0)

var to_launch = []

func _ready() -> void:
	spawn_uninit()
	

func get_pinballs() -> Array[Node]:
	return get_tree().get_nodes_in_group("ballz")

func forward_ballsunk_signal(sinkhole: Node):
	get_parent()._on_pinball_ball_sunk(sinkhole);
	pass

func handle_back_in(body):
	if body not in to_launch:
		to_launch.push_back(body)
	pass
	
func spawn_uninit():
	var inst := pinball_packed.instantiate()
	inst.position = $SpawnPos.position	
	inst.connect("ballSunk", forward_ballsunk_signal.bind())
	inst.connect("hitGlorbo", %Glorbo.gotHit)
	inst.connect("backInChamber", handle_back_in.bind())
	to_launch.push_back(inst)
	add_child(inst)


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("PinballLaunch") and to_launch != null and not EventBus.is_dead:
		for item in to_launch:
			var random_force := Vector2(randf_range(-100, -500), randf_range(-100, -500))
			item.apply_force(launch_force + random_force)
		to_launch = []
