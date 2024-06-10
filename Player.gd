extends CharacterBody2D

@onready var animatedSprite = %AnimatedSprite2D
const SPEED = 150.0
const SPRINT_SPEED = 250.0
var speed = SPEED

func _physics_process(_delta):
	playerMovement()

func playerMovement():
	speed = SPEED if not Input.is_action_pressed("shift") else SPRINT_SPEED
	var direction:Vector2 = Input.get_vector("left", "right", "up", "down")
	if direction:
		velocity = direction * SPEED
		
		if direction[1] and !direction[0]: animatedSprite.changeAnimation("walk", "up" if direction[1] > 0 else "down")
		if direction[0]: animatedSprite.changeAnimation("walk", "right" if direction[0] > 0 else "left")
		
	else:
		velocity = Vector2.ZERO
		var facing = animatedSprite.animation.split("-")[1]
		animatedSprite.changeAnimation("idle", facing)

	move_and_slide()
