extends CharacterBody2D


var speed = 100.0
var death = false
var health = 10.0
const JUMP_VELOCITY = -300.0
@onready var death_message = $"Death Message"
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var timer = $Timer
@onready var animation_player = $AnimationPlayer


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	
	
	# Get Input Direction 1, 0 ,-1
	var direction = Input.get_axis("Left", "Right")
	
	
	if death == false:
		# Flip the sprite
		if direction > 0:
			animated_sprite_2d.flip_h = false
		elif direction < 0:
			animated_sprite_2d.flip_h = true
			
			
		if is_on_floor():
			if Input.is_action_pressed("Roll"): # Handle Roll
				animated_sprite_2d.play("Roll")
				speed = 120.0
			else:
				speed = 100.0
				if direction == 0:
					animated_sprite_2d.play("Idle")
				else:
					animated_sprite_2d.play("Run")
		else:
				animated_sprite_2d.play("Jump")
		
		if direction:
			velocity.x = direction * speed
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
	else:
		pass
	move_and_slide()

	


func health_decreesed(damage):
	#set_physics_process(false)
	health -= damage
	print(health)
	animated_sprite_2d.play("hurt")
	if health == 0:
		deathfunc()

func message_display():
	death_message.visible = true
	
func deathfunc():
	timer.start()
	print("You Died")
	death = true
	Engine.time_scale = 0.5
	animation_player.play("hurt")
	message_display()
	if is_on_floor():
		animated_sprite_2d.play("Death")
	
	
	

func _on_timer_timeout():
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()


#func _on_animated_sprite_2d_animation_finished():
	#set_physics_process(true)
