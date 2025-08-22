extends Control

func  _ready() -> void:
	connect_right_menu_button(%"嵌字主窗口".connect_right_menu_button())

func connect_right_menu_button(a):
	a[1].connect("_on_add_pressed")#a
	a[2].connect("_on_delete_pressed")#d
	a[3].connect("_on_copy_pressed")#c
	a[4].connect("_on_paste_pressed")#p

func _on_add_pressed() -> void:
	pass # Replace with function body.


func _on_delete_pressed() -> void:
	pass # Replace with function body.


func _on_copy_pressed() -> void:
	pass # Replace with function body.


func _on_paste_pressed() -> void:
	pass # Replace with function body.
