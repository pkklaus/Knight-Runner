extends Area2D


const BULLET = preload("res://Scenes/bullet.tscn")

# Varibles
var enimies_in_range 
var target_enemy
@onready var bulletshot = %bulletshot



func _physics_process(delta):
	enimies_in_range = get_overlapping_bodies()
	if enimies_in_range.size() > 0:
		target_enemy = enimies_in_range[0]
		look_at(target_enemy.global_position)



func shoot():

	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = bulletshot.global_position
	new_bullet.global_rotation = bulletshot.global_rotation
	bulletshot.add_child(new_bullet)




func _on_timer_timeout():
		shoot()
	
