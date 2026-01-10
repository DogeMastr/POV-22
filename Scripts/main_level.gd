extends Node3D

# Gameobjects
@onready var temp_obstacle = preload("res://Scenes/Obstacles/temp_obstacle.tscn")
@onready var Pole = preload("res://Scenes/Obstacles/Pole.tscn")
@onready var Car = preload("res://Scenes/Obstacles/Car.tscn")
@onready var Person = preload("res://Scenes/Obstacles/Person.tscn")
@onready var Bin = preload("res://Scenes/Obstacles/Bin.tscn")
@onready var spawn_points = $Spawn_Points.get_children()
@onready var score_label = $CanvasLayer/Score
@onready var car_speed_label = $CanvasLayer/Car_Speed



var pathway_obstacles
var road_obstacles

#Spawn rates of objects
@export var cooldown = 2
var cooldown_max

#Starting speed allows us to speed up objects over time
@export var starting_speed = 5.0
var speed_for_obstacle
var car_acceleration = 1.0
var score = 0

# Pole logic / Swaps side of road once score % pole_check = 0
var pole_on_left = true
@export var pole_check = 7.5
var pole_max

func _ready() -> void:
	cooldown_max = cooldown
	pole_max = pole_check
	pathway_obstacles = [Person, Bin]
	road_obstacles = [Car, Person, Bin] 

func _process(delta):
	#Cooldown, score update, set speed
	cooldown -= 1 * delta
	score_label.score_to_display = int(round(score))
	speed_for_obstacle = -starting_speed * car_acceleration
	score += -speed_for_obstacle/10
	cooldown_max = clamp(cooldown_max - (score/10000 * delta), .6, cooldown_max)
	
	#Spawn of random obstacle
	if cooldown < 0:
		var lane = randi_range(0,3)
		cooldown = cooldown_max
		if lane == 0 or lane == 3:
			var obstacle_instance = pathway_obstacles[randi_range(0, 1)].instantiate()
			add_child(obstacle_instance)
			obstacle_instance.global_position = spawn_points[lane].global_position
			obstacle_instance.speed = speed_for_obstacle
		else:
			var object_selection = randi_range(0, 2)
			var obstacle_instance = road_obstacles[object_selection].instantiate()
			add_child(obstacle_instance)
			obstacle_instance.global_position = spawn_points[lane].global_position
			obstacle_instance.speed = speed_for_obstacle	
			
			#if object is a Car
			if object_selection == 0:
				if lane == 1:
					obstacle_instance.speed *= .75
				else:
					obstacle_instance.speed *= 1.5
		
	if Input.is_action_pressed("move_forward"):
		car_acceleration += .001
		car_speed_label.score_to_display = int(round(car_acceleration))

	#Pole logic
	pole_check += 1 * delta * -speed_for_obstacle

	if (pole_check >= pole_max):
		if pole_on_left:
			var obstacle_instance = Pole.instantiate()
			add_child(obstacle_instance)
			obstacle_instance.global_position = spawn_points[4].global_position
			obstacle_instance.speed = speed_for_obstacle
			pole_on_left = not pole_on_left 
			
		else: 
			var obstacle_instance = Pole.instantiate()
			add_child(obstacle_instance)
			obstacle_instance.global_position = spawn_points[5].global_position
			obstacle_instance.speed = speed_for_obstacle
			obstacle_instance.transform.basis = Basis()
			obstacle_instance.rotate_object_local(Vector3.UP, PI)
			pole_on_left = not pole_on_left
		pole_check = 0
