extends Node2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
#variables
const animations= preload("res://animations/sophia_animations.tres")


func play_animation(animation_name:String)->void:
	animated_sprite_2d.sprite_frames=animations
	animated_sprite_2d.play(animation_name)
	
