extends Control

#Importaciones
@onready var http_request: HTTPRequest = $HTTPRequest
@onready var rich_text_label: RichTextLabel = $RichTextLabel
@onready var character: Node2D = %Character
@onready var dialog_ui: Control = %DialogUI

##Variables
enum STATE {AI, HUMAN}
var conversationTurn= STATE.HUMAN
const  URL_API= "http://localhost:5000/api/chat"
const ASSISTANT_NAME= "SophIA"
var dialog_index:int=0
var question= ""
var dialog_lines:Array[String]=[
	
]




func process_current_line():
	if(len(dialog_lines)>0):
		var line= dialog_lines[dialog_index]
		dialog_ui.speaker_name.text=ASSISTANT_NAME
		dialog_ui.dialog_line.text=line
	 
func process_human_dialog():
	conversationTurn=STATE.AI
	question= dialog_ui.text_edit.text
	dialog_ui.text_edit.text=""
	dialog_ui.text_edit.visible=false
	dialog_ui.dialog_line.visible=true
	dialog_ui.speaker_name.text="SophIA"
	dialog_ui.dialog_line.text="Estoy procesando tu pregunta..."
	callApi()



func _ready() -> void:
	dialog_index=0
	dialog_ui.speaker_name.text="Tú"
	process_current_line()

func _input(event):
	if (event.is_action_pressed("next_line")):
		if(conversationTurn==STATE.HUMAN):
			process_human_dialog()
		if(conversationTurn==STATE.AI):
			if dialog_index== len (dialog_lines)-1 and len(dialog_lines)>0:
				process_current_line()
				dialog_index=0
				dialog_lines=[]
				dialog_ui.speaker_name.text="Tú"
				dialog_ui.text_edit.visible=true
				dialog_ui.dialog_line.visible=false
				conversationTurn=STATE.HUMAN
				await get_tree().create_timer(0.25).timeout
				dialog_ui.text_edit.grab_focus()
				
			elif dialog_index< len(dialog_lines)-1:
				dialog_index+=1
				process_current_line()
			






	
	
func callApi()->void:
	print("Pregunta enviada")
	var headers = ["Content-Type: application/json"]
	var data= {"question":question}
	var api_query= JSON.stringify(data)
	http_request.request(URL_API, headers, HTTPClient.METHOD_POST, api_query)
	pass # Replace with function body.


func _on_http_request_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	var data= JSON.parse_string(body.get_string_from_utf8())
	print(data.answer)
	var answer=	data.answer.split("\n\n")
	dialog_lines= Array( Array(answer), TYPE_STRING, "", null )
	process_current_line()
	pass # Replace with function body.
