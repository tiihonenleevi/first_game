extends Area2D

@onready var restart_timer: Timer = $"Restart timer"
@onready var hit_sound: AudioStreamPlayer2D = $HitSound

@export var dmg_amount: int

signal player_hit(dmg)

func _on_body_entered(body: Node2D) -> void:
	player_hit.emit(dmg_amount)
	hit_sound.play()
	print(body.get("hp"))
	if body.get("hp") <= 0:
		Engine.time_scale = 0.5
		body.get_node("CollisionShape2D").queue_free()
		restart_timer.start()

func _on_restart_timer_timeout() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()
