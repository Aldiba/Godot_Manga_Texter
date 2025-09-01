extends Control

@onready var image_display = %image_display
@onready var label_port = %label_port
@onready var outside_layer = %outside_layer
@onready var right_menu = %right_menu

@export var copy_panel:Node

var right_position:Vector2

func _ready() -> void:
	#%Add.pressed.connect()
	pass

func connect_right_menu_button():
	return [%Add.pressed,%Delete.pressed,%Copy.pressed,%Paste.pressed]

# This function will be called when the scene is ready.
func save():
	# Wait one frame to ensure all nodes have been rendered.
	await get_tree().process_frame
	
	# Get the viewport of the current scene.
	var viewport = get_viewport()
	
	# Get the nodes we want to capture.
	var text_label = get_node("TextLabel")
	
	# Check if the nodes exist.
	if not is_instance_valid(image_display) or not is_instance_valid(text_label):
		printerr("Error: 'ImageDisplay' or 'TextLabel' node not found.")
		return

	# Calculate the bounding box that encompasses both nodes.
	var combined_rect = Rect2(image_display.position, image_display.size)
	combined_rect = combined_rect.merge(Rect2(text_label.position, text_label.size))
	
	# Get the entire viewport's texture.
	var viewport_texture = viewport.get_texture()
	
	# Create a new image from the viewport texture.
	var full_image = viewport_texture.get_image()
	
	# Create an empty image for our final cropped screenshot.
	var final_image = Image.create(int(combined_rect.size.x), int(combined_rect.size.y), false, Image.FORMAT_RGBA8)
	
	# Copy the specific region from the full image to the final image.
	final_image.blit_rect(full_image, combined_rect, Vector2.ZERO)
	
	# Save the final image as a PNG file (lossless).
	var error = final_image.save_png("res://combined_screenshot.png")
	
	if error != OK:
		printerr("Error saving screenshot: ", error)
	else:
		print("Combined screenshot saved successfully to res://combined_screenshot.png")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("right_click"):
		right_menu.follow = true
		right_menu.position = get_global_mouse_position()
		right_menu.visible = true
		right_menu.right_menu_show()
		right_position = get_global_mouse_position()
		
	if event.is_action_released("right_click"):
		right_menu.follow = false
		
		
	if event.is_action_pressed("left_click"):
		right_menu.right_menu_hide()
		right_menu.follow = false
		right_position = get_global_mouse_position()
		#await right_menu.visible = false

func _on_add_pressed() -> void:
	pass # Replace with function body.


func _on_delete_pressed() -> void:
	pass # Replace with function body.


func _on_copy_pressed() -> void:
	pass # Replace with function body.


func _on_paste_pressed() -> void:
	pass # Replace with function body.
