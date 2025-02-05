extends Area2D

func _on_body_entered(body: CharacterBody2D) -> void:
	# Checks if entered body has key
	if body.get("has_key") == true:
		# If the bosy has key open_gate-signal gets emitted
		SignalBus.open_gate.emit()
	else:
		SignalBus.show_gate_label.emit()
