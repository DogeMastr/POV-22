extends Node3D

@onready var temp_obstacle = preload("res://Scenes/Obstacles/temp_obstacle.tscn")
@onready var spawn_points = $Spawn_Points.get_children()

@export var cooldown = 2
var cooldown_max

func _ready() -> void:
	cooldown_max = cooldown

func _process(delta):
	if cooldown < 0:
		cooldown = cooldown_max
		var obstacle_instance = temp_obstacle.instantiate()
		add_child(obstacle_instance)
		obstacle_instance.global_position = spawn_points[randi_range(0,3)].global_position
	cooldown -= 1 * delta
