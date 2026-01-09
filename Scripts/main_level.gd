extends Node3D

@onready var temp_obstacle = preload("res://Scenes/Obstacles/temp_obstacle.tscn")
@onready var spawn_points = $Spawn_Points.get_children()
@onready var score_label = $CanvasLayer/Score

@export var cooldown = 2
var cooldown_max

@export var starting_speed = 5
var speed_for_obstacle
var score = 0

var pole_on_left = true
@export var pole_check = 2
var pole_max

func _ready() -> void:
	cooldown_max = cooldown
	pole_max = pole_check

func _process(delta):
	cooldown -= 1 * delta
	score += 1 * delta * (1 + score/100)
	score_label.score_to_display = int(round(score * 100))
	speed_for_obstacle = -starting_speed * (1 + score/100)
	cooldown_max = clamp(cooldown_max - (score/1000 * delta), .5, cooldown_max)
	
	if cooldown < 0:
		cooldown = cooldown_max
		var obstacle_instance = temp_obstacle.instantiate()
		add_child(obstacle_instance)
		obstacle_instance.global_position = spawn_points[randi_range(0,3)].global_position
		obstacle_instance.speed = speed_for_obstacle

	pole_check += 1 * delta * (1 + score/100)

	if (pole_check >= pole_max):
		if pole_on_left:
			var obstacle_instance = temp_obstacle.instantiate()
			add_child(obstacle_instance)
			obstacle_instance.global_position = spawn_points[0].global_position
			obstacle_instance.speed = speed_for_obstacle
			pole_on_left = not pole_on_left 
			
		else: 
			var obstacle_instance = temp_obstacle.instantiate()
			add_child(obstacle_instance)
			obstacle_instance.global_position = spawn_points[3].global_position
			obstacle_instance.speed = speed_for_obstacle
			pole_on_left = not pole_on_left
		pole_check = 0
