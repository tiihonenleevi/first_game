extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_body_entered(_body: Node2D) -> void:
	# Emits the key_pickup signal and deletes the key
	SignalBus.key_pickup.emit()
	animation_player.play("key_pick_up")
