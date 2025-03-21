extends Area2D

@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var respawn_position: Marker2D = $RespawnPosition
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var cpu_particles: CPUParticles2D = $CPUParticles2D
@onready var audio_stream_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		animated_sprite.play("raise_flag")
		SignalBus.checkpoint_reached.emit(respawn_position.global_position)
		audio_stream_player.play()
		collision_shape.queue_free()

func _on_animated_sprite_2d_animation_finished() -> void:
	cpu_particles.emitting = true
