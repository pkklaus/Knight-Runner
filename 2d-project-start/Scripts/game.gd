extends Node2D


const ENEMY = preload("res://Scenes/enemy.tscn")

var should_spawn_enemy := true
var spawned_enemies := 0
var wave_count := 0
var wave_timer_time := 120.0
var enemy_list = []
@onready var path_follow_2d = %PathFollow2D
@onready var wave_timer = $WaveTimer
@onready var spawn_timer = $SpawnTimer
@onready var wavedisplay = %Wavedisplay

func _ready():
	start_waves()

func start_waves():
	Engine.time_scale = 1.0
	print("A New Wave" + str(wave_count))
	print(enemy_list)
	should_spawn_enemy = true
	wave_count += 1
	wavedisplay.text = "wave " + str(wave_count)
	spawn_timer.start()
	wave_timer.start(wave_timer_time)
	print(wave_timer.wait_time)
	

func make_enemy():
	var new_enemy = ENEMY.instantiate()
	path_follow_2d.progress_ratio = randf()
	
	#print(new_enemy.global_position, path_follow_2d.global_position, path_follow_2d.progress_ratio)
	add_child(new_enemy)
	new_enemy.global_position = path_follow_2d.global_position
	return new_enemy
	#print(new_enemy.global_position, path_follow_2d.global_position, path_follow_2d.progress_ratio)


func rand_spawn_enemy(value_a :int ,value_b :int ,max_enemy :int ):
	if should_spawn_enemy and spawned_enemies != max_enemy:
		var random_number := randi_range(value_a,value_b)
		if spawned_enemies + random_number  <= max_enemy:
			spawn_enemy(random_number)
		else:
			random_number = max_enemy - spawned_enemies
			spawn_enemy(random_number)
			
		print(spawned_enemies)



func spawn_enemy(number):
	for i in number:
		enemy_list.append(make_enemy())
		spawned_enemies += 1
		#print(enemy_list)



func _on_spawn_timer_timeout():
	print(spawned_enemies)
	var diff_values = diff_calc()
	#print(diff_values)
	rand_spawn_enemy(diff_values[0],diff_values[1],diff_values[2])

func diff_calc():
	var value_a = int(wave_count * 1)
	var value_b = int(wave_count * 5)
	var max_value = int(wave_count * 10)
	return [value_a,value_b,max_value]


func _on_wave_timer_timeout():
	Engine.time_scale = 0.5
	print(enemy_list)
	for i in enemy_list:
		i.death()
	enemy_list.clear()
	start_waves()
