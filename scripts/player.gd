extends CharacterBody2D

const SPEED: float = 130.0
const JUMP_VELOCITY: float = -300.0

var hp: int = 2
var has_key: bool = false
var jump_counter: int = 0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var jump_sound: AudioStreamPlayer2D = $JumpSound
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

var respawn_position: Vector2 = self.global_position

func _ready() -> void:
	# Connects the signals to player's functions
	SignalBus.respawn.connect(respawn_values)
	SignalBus.player_hit.connect(decrease_health)
	SignalBus.checkpoint_reached.connect(update_respawn_position)
	SignalBus.key_pickup.connect(key_true)

func _physics_process(delta: float) -> void:
	# Add the gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handles jump (able to double jump)
	if Input.is_action_just_pressed("jump") and jump_counter < 1:
		jump_counter += 1
		jump_sound.play()
		velocity.y = JUMP_VELOCITY
	
	if is_on_floor():
		# Sets jump counter to 0, so the player can jump again
		jump_counter = 0

	# Get the input direction: -1, 0 or 1
	var direction := Input.get_axis("move_left", "move_right")
	
	# Flip the sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	# Play animations
	if direction == 0:
		animated_sprite.play("idle")
	else:
		animated_sprite.play("run")
	
	if not is_on_floor():
		animated_sprite.play("jump")
	
	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func decrease_health(amount):
	hp -= amount
	
	if hp <= 0:
		hp = 0

func update_respawn_position(new_position):
	respawn_position = new_position

func respawn_values():
	hp = 2

func key_true():
	has_key = true
	print(has_key)
