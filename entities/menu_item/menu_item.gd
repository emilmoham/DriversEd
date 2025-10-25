@tool
extends Area2D

signal menu_item_clicked

@export var label_text: String = "Put Text Here"

var button_label: Label
var click_box: CollisionShape2D

func _ready() -> void:
	button_label = $ButtonLabel
	click_box = $ClickBox
	
	button_label.text = label_text
	button_label.add_theme_color_override("font_color", Color.BLACK)

func _process(_delta: float) -> void:
	if !Engine.is_editor_hint():
		pass
		
	button_label.text = label_text
	click_box.shape.size.x = button_label.size.x


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("left_mouse_button"):
		GlobalSoundFx.on_menu_item_selected()
		emit_signal("menu_item_clicked")

func _on_mouse_entered() -> void:
	button_label.add_theme_color_override("font_color", Color.WHITE)
	$HoverSound.play()

func _on_mouse_exited() -> void:
	button_label.add_theme_color_override("font_color", Color.BLACK)
