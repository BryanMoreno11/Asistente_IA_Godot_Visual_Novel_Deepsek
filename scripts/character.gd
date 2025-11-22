extends Node2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
#variables
const animations= preload("res://animations/sophia_animations.tres")
const responseAnimations=["response1","response2"]
#"response1","response2","response3"

func play_animation(animation_name:String)->void:
	animated_sprite_2d.sprite_frames=animations
	if(animation_name=="response"):
		animated_sprite_2d.play(responseAnimations.pick_random())
	else:
		animated_sprite_2d.play(animation_name)
	
