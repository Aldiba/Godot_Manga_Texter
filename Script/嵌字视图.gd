extends Camera2D

var shift_bool = false
var ctrl_bool = false

var isDragging:bool
var isShift:bool
var isCtrl:bool

var dragStartMousePos = Vector2.ZERO
var dragStartCameraPos = Vector2.ZERO

func _process(delta: float) -> void:
	ClickAndDrag()

	
func _input(event: InputEvent):
	
	#sc
	if event.is_action_pressed("shift"):
		isShift = true
	if event.is_action_pressed("ctrl"):
		isCtrl = true
	if event.is_action_released("shift"):
		isShift = false
	if event.is_action_released("ctrl"):
		isCtrl = false
		
	#滚轮
	if event.is_action_pressed("scroll_up"):
		if isShift:
			position.y-=30/zoom.x
		elif isCtrl:
			position.x-=30/zoom.x
		elif zoom.x <=10:
			zoom *= 1.1
	if event.is_action_pressed("scroll_down"):
		if isShift:
			position.y+=30/zoom.x
		elif isCtrl:
			position.x+=30/zoom.x
		elif zoom.x >= 0.01:
			zoom *= 0.9
	
	
	
	#拖拽
	if !isDragging and (event.is_action_pressed("scroll_press")):
		dragStartMousePos = get_viewport().get_mouse_position()
		dragStartCameraPos = position
		isDragging = true
		
	if isDragging and (event.is_action_released("scroll_press")):
		isDragging = false
	
func ClickAndDrag():

	if isDragging:
		var moveVector = get_viewport().get_mouse_position() - dragStartMousePos
		position = dragStartCameraPos - moveVector * 1/zoom.x	
