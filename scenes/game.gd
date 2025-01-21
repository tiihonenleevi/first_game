extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$GreenSlimes/Slime/Killzone.player_hit.connect($Player.decrease_health)
