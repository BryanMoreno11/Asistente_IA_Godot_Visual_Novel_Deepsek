extends Control
@onready var dialog_line = %DialogLine
@onready var speaker_name = %SpeakerName
@onready var text_edit: TextEdit = $DialogBox/TextEdit

func _ready()->void:
	text_edit.grab_focus()
