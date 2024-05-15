extends Area2D

var damage = 10


func _on_body_entered(body):
	body.health_decreesed(damage)
	Engine.time_scale = 0.5



func _on_body_exited(_body):
	Engine.time_scale = 1.0
