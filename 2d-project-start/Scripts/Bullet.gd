extends Area2D

# Variables
var direction
var speed := 1000
var wapon_range := 500
var traveed_distance := 0
var damage := 10

func _physics_process(delta):
	direction = Vector2.RIGHT.rotated(rotation)
	position += direction * speed * delta
	
	traveed_distance += speed * delta
	if traveed_distance > wapon_range:
		queue_free()


func _on_body_entered(body):
	queue_free()
	if body.has_method("take_damage"):
		body.take_damage(damage)
