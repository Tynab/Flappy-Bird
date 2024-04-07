extends CharacterBody2D

const GRAVITY : int = 1000
const MAX_VEL : int = 600
const FLAP_SPEED : int = -500
const START_POS = Vector2(100, 400)

var flying : bool = false
var falling : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	reset()

# Called every frame. 'delta’ is the elapsed time since the previous frame.
func _physics_process (delta):
	if flying or falling:
		velocity.y += GRAVITY * delta
		if velocity.y > MAX_VEL:
			velocity.y = MAX_VEL
		if flying:
			set_rotation(deg_to_rad(velocity.y * .05))
			$AnimatedSprite2D.play()
		elif falling:
			set_rotation(PI / 2)
			$AnimatedSprite2D.stop()
		move_and_collide(velocity * delta)
	else:
		$AnimatedSprite2D.stop()

func reset():
	falling = false
	flying = false
	position = START_POS
	set_rotation(0)

func flap():
	velocity.y = FLAP_SPEED
