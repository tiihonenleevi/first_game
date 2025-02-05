extends Area2D

@onready var restart_timer: Timer = $"Restart timer"
@onready var hit_sound: AudioStreamPlayer2D = $HitSound
@onready var invisible_timer: Timer = $"Invisible timer"

@export var dmg_amount: int

var respawn_position: Vector2

var player

func _on_body_entered(body: Node2D) -> void:
	player = body
	
	# Disables the collision layer of player for 0.5s so player doesn't get hit twice so easily
	player.collision_layer = false
	invisible_timer.start()
	
	# Sends signal
	SignalBus.player_hit.emit(dmg_amount)
	hit_sound.play()
	
	# Gets respawn position from player
	respawn_position = body.get("respawn_position")
	
	if body.get("hp") <= 0:
		Engine.time_scale = 0.5
		body.get_node("CollisionShape2D").set_deferred("disabled", true)
		restart_timer.start()

func _on_restart_timer_timeout() -> void:
	Engine.time_scale = 1
	if respawn_position == Vector2(0,0):
		get_tree().reload_current_scene()
	else:
		# Pelaaja voi kuolla respawnaamisen jälkeen, jo hp menee miinukselle
		# Täytyy fixata
		SignalBus.respawn.emit()
		player.collision_layer = false
		player.get_node("CollisionShape2D").set_deferred("disabled", false)
		player.position = respawn_position
		invisible_timer.start()

func _on_invisible_timer_timeout() -> void:
	player.collision_layer = 2
