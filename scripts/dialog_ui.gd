extends Control
@onready var dialog_line = %DialogLine
@onready var speaker_name = %SpeakerName
@onready var text_edit: TextEdit = $DialogBox/TextEdit
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var text_blip_timer: Timer = $textBlipTimer

const ANIMATION_SPEED:int=30
const NO_SOUND_CHARACTERS=[".", "!", "?"]
var animate_text:bool=false
var current_visible_characters:int=0 

func _ready()->void:
	text_blip_timer.timeout.connect(_on_text_blip_timeout)
	text_edit.grab_focus()
	
func _process(delta):
	if animate_text:
		if(dialog_line.visible_ratio<1):
			dialog_line.visible_ratio+=(1.0/dialog_line.text.length())* (ANIMATION_SPEED*delta)
			if dialog_line.visible_characters>current_visible_characters:
				current_visible_characters=dialog_line.visible_characters
				var last_char=dialog_line.text[current_visible_characters-1]
		else:
			text_blip_timer.stop()
			animate_text=false
	
func change_line(line:String):
	current_visible_characters=0
	dialog_line.visible_characters=0
	dialog_line.text=line
	animate_text=true
	text_blip_timer.start()

func skip_text_animation():
	dialog_line.visible_ratio=1
	
func _on_text_blip_timeout():
	audio_stream_player.play()
	pass
