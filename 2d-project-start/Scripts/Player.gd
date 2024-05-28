extends CharacterBody2D

enum Alliance {Ally , Enemy}
@export var my_Alliance : Alliance 

# Variables
var speed := 300
var health := 100.0
var overlaping_bodies
var dead := false
@onready var happy_boo = $HappyBoo
@onready var hurt_box = %HurtBox
@onready var progress_bar = $ProgressBar
@onready var timer = $Timer


func _physics_process(delta):
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	velocity = direction * speed
	
	# Animation
	if direction:
		happy_boo.play_walk_animation()
	else:
		happy_boo.play_idle_animation()
	move_and_slide()
	
	#overlaping_bodies = hurt_box.get_overlapping_bodies()
	#if overlaping_bodies.size() > 0:
		#player_take_damage(delta)
	
	

func player_take_damage(damage, delta):
	health -= damage * delta
	progress_bar.value = health

	
	if health <= 0 and !dead:
		player_death()
		dead = true
		
		


func _on_timer_timeout():
	print("time")
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
	

func player_death():
	timer.start()
	Engine.time_scale = 0.5
	print("died")
