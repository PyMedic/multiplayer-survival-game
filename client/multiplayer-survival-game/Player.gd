extends CharacterBody2D

var is_local_player = false

const SPEED = 200.0
@onready var sprite = $AnimatedSprite2D
var last_direction = Vector2.DOWN

func _physics_process(delta):	
	if is_local_player:
		var direction = get_user_input()
		# Ensures that diagonal movement isn't faster than straight movement.
		velocity = direction.normalized() * SPEED
		move_and_slide()
	else:	# For multiplayers.
		pass

	if velocity.length() > 0:
		last_direction = velocity

	update_animation(velocity)

# Handles the user input.
func get_user_input() -> Vector2:
	var input_vector = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		input_vector.x += 1
	if Input.is_action_pressed("ui_left"):
		input_vector.x -= 1
	if Input.is_action_pressed("ui_down"):
		input_vector.y += 1
	if Input.is_action_pressed("ui_up"):
		input_vector.y -= 1
	
	return input_vector

func update_animation(direction: Vector2):
	var is_moving = direction.length() > 0
	if is_moving:
		# State: Movement
		if abs(direction.y) > abs(direction.x):
			if direction.y > 0:
				sprite.play("walk_down")
			else:
				sprite.play("walk_up")
		else:
			sprite.play("walk_right")

			# If the movement is meant for left, then flip the animation sprite.
			sprite.flip_h = direction.x < 0
	else:
		# State: Idle
		if abs(last_direction.y) > abs(last_direction.x):
			if last_direction.y > 0:
				sprite.play("idle_down")
			else:
				sprite.play("idle_up")
		else:
			sprite.play("idle_right")

			# If the last direction was to the left, the flip the idle_right animation.
			sprite.flip_h = last_direction.x < 0
