extends CharacterBody2D

enum Alliance {Ally , Enemy}
@export var my_Alliance : Alliance 

const SMOKE_SCENE = preload("res://Assets/smoke_explosion/smoke_explosion.tscn")

#Variables
@onready var player = get_node("/root/Game/Player")
@onready var slime = $Slime
@onready var damage_shape = $damage

var direction
var speed := 200
var health := 20
var min_damage := 50

func _ready():
	slime.play_walk()

func _physics_process(delta):
	direction = global_position.direction_to(player.global_position)
	velocity = direction * speed
	move_and_slide()
	
	
	
	var overlaping_bodies = damage_shape.get_overlapping_bodies()
	if overlaping_bodies.size() > 0:
		for body in overlaping_bodies:
			if body == player and body.has_method("player_take_damage"):
				body.player_take_damage(min_damage, delta)
	
func take_damage(damage=10):
	health -= damage
	slime.play_hurt()
	if health <= 0:
		death()
	#print(health)

func death():
	queue_free()
	var smoke = SMOKE_SCENE.instantiate()
	get_parent().add_child(smoke)
	get_parent().spawned_enemies -= 1
	smoke.global_position = global_position
