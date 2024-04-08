# FLAPPY BIRD GAME
The Flappy Bird game project is built with the versatile Godot Engine, perfect for players and aspiring developers alike.

## LINK DEMO
<div align='center'>

[Click here to play the game](https://tynab.github.io/Flappy-Bird/build)

</div>

## IMAGE DEMO
<p align='center'>
<img src='pic/0.jpg'></img>
</p>

## CODE DEMO
```js
func generate_pipes():
	var pipe = pipe_scene.instantiate()
	pipe.position.x = screen_size.x + PIPE_DELAY
	pipe.position.y = (screen_size.y - ground_height) / 2.0 + randi_range(-PIPE_RANGE, PIPE_RANGE)
	pipe.hit.connect(bird_hit)
	pipe.scored.connect(scored)
	add_child(pipe)
	pipes.append(pipe)
```
