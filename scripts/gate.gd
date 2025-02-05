extends AnimatableBody2D

var animation_counter: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.open_gate.connect(open_gate)

func open_gate():
	# When open_gate signal is emitted plays 'gate_open'-animation but only the first time
	if animation_counter < 1:
		$AnimationPlayer.play("gate_open")
		animation_counter += 1
