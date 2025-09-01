extends TextEdit

@export var bind_label:Node


func _on_text_changed() -> void:
	bind_label.set_text(text)

func set_bind_label(label):
	bind_label= label
