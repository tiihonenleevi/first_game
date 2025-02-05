extends Area2D

@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var cpu_particles: CPUParticles2D = $CPUParticles2D
@onready var audio_stream_player: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		audio_stream_player.play()
		cpu_particles.emitting = true
		collision_shape.queue_free()
		timer.start()

func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/start_screen.tscn")
