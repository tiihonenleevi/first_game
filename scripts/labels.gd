extends Node

@onready var gate_label: Label = $GateLabel
@onready var gate_label_show_time: Timer = $GateLabel/GateLabelShowTime

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.show_gate_label.connect(show_gate_label)

func show_gate_label():
	gate_label.text = "What does the gate usually need?"
	gate_label_show_time.start()



func _on_gate_label_show_time_timeout() -> void:
	gate_label.text = ""
