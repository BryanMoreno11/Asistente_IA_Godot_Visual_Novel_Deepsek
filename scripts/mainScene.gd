extends Control

#Importaciones
@onready var http_request: HTTPRequest = $Button/HTTPRequest
@onready var rich_text_label: RichTextLabel = $RichTextLabel
@onready var character: Node2D = %Character
@onready var dialog_ui: Control = %DialogUI

##Variables
const  URL_API= "http://localhost:5000/api/chat"
var dialog_index:int=0
var question= "¿Quién es el coordinador de la carrera?"
var dialog_lines:Array[String]=[
	"SophIA: Hola, bienvenido a la feria","SophIA: Espero que tu estadía aquí sea acogedora"
]


func parse_line(line:String):
	var line_info= line.split(":")
	assert(len(line_info)>=2)
	return {
		"speaker_name": line_info[0],
		"dialog_line": line_info[1]
	}

func process_current_line():
	if(len(dialog_lines)>0):
		var line= dialog_lines[dialog_index]
		var line_info= parse_line(line)
		dialog_ui.speaker_name.text=line_info["speaker_name"]
		dialog_ui.dialog_line.text=line_info["dialog_line"]
	 




func _ready() -> void:
	dialog_index=0
	process_current_line()

func _input(event):
	if (event.is_action_pressed("next_line")):
		if dialog_index< len(dialog_lines)-1:
			dialog_index+=1
			process_current_line()




func _on_button_pressed() -> void:
	print("Pregunta enviada")
	var headers = ["Content-Type: application/json"]
	var data= {"question":question}
	var api_query= JSON.stringify(data)
	http_request.request(URL_API, headers, HTTPClient.METHOD_POST, api_query)
	pass # Replace with function body.


func _on_http_request_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	var data= JSON.parse_string(body.get_string_from_utf8())
	print(data.answer)
	pass # Replace with function body.
