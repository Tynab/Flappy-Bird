extends Node

@export var pipe_scene : PackedScene

const SCROLL_SPEED : int = 4
const PIPE_DELAY : int = 100
const PIPE_RANGE : int = 200

var game_running : bool
var game_over : bool
var screen_size : Vector2i
var ground_height : int
var pipes : Array
var scroll
var score

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_tree().root.content_scale_size
	ground_height = $Ground.get_node("Sprite2D").texture.get_height()
	new_game()

func _input(event):
	if not game_over and event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if not game_running:
			game_running = true
			$Bird.flying = true
			$Bird.flap()
			$PipeTimer.start()
		else:
			if $Bird.flying:
				$Bird.flap()
				if $Bird.position.y < 0:
					$Bird.falling = true
					stop_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if game_running:
		scroll += SCROLL_SPEED
		if scroll >= screen_size.x:
			scroll = 0
		$Ground.position.x = -scroll
		for pipe in pipes:
			pipe.position.x -= SCROLL_SPEED

func _on_pipe_timer_timeout():
	generate_pipes()

func _on_ground_hit():
	$Bird.falling = false
	stop_game()

func _on_game_over_restart():
	new_game()

func new_game():
	game_running = false
	game_over = false
	score = 0
	scroll = 0
	$ScoreLabel.text = "SCORE: " + str(score)
	$GameOver.hide()
	get_tree().call_group("pipes", "queue_free")
	pipes.clear()
	generate_pipes()
	$Bird.reset()

func generate_pipes():
	var pipe = pipe_scene.instantiate()
	pipe.position.x = screen_size.x + PIPE_DELAY
	pipe.position.y = (screen_size.y - ground_height) / 2.0 + randi_range(-PIPE_RANGE, PIPE_RANGE)
	pipe.hit.connect(bird_hit)
	pipe.scored.connect(scored)
	add_child(pipe)
	pipes.append(pipe)

func stop_game():
	$PipeTimer.stop()
	$GameOver.show()
	$Bird.flying = false
	game_running = false
	game_over = true

func bird_hit():
	$Bird.falling = true
	stop_game()
	
func scored():
	score += 1
	#$ScoreLabel.text = "SCORE: " + str(score)
	$ScoreLabel.text = str(screen_size.x) + str(score)
