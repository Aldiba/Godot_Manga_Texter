extends Control

@onready var label_but = preload("res://文本框.tscn")
@onready var label_editor = preload("res://文本输入框.tscn")

func _on_add_pressed() -> void:
	var new_label = label_but.instantiate()
	add_child(new_label)
	new_label.button.connect("pressed",gen_editor.bind(new_label))
	
	new_label._set_global_position($"../..".right_position)
	
	var default_text=DisplayServer.clipboard_get()
	if default_text:
		new_label.set_text(default_text)
	else:
		new_label.set_text("默认文本")
		
func gen_editor(label):
	var temp_editor = label_editor.instantiate()
	%outside_layer.add_child(temp_editor)
	temp_editor.set_bind_label(label)
	## TODO if横竖左右
	temp_editor.set_position(Vector2(label.position.x+40,label.position.y))
