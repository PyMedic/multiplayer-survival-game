extends CharacterBody2D

const SPEED = 200.0
@onready var sprite = $AnimatedSprite2D
var last_direction = Vector2.DOWN

func _physics_process(delta):
	var direction = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1

	# Diagonal movement speed calibration
	direction = direction.normalized()

	velocity = direction * SPEED
	move_and_slide()

	if direction.length() > 0:
		last_direction = direction

	update_animation(direction)

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
