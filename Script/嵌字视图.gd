extends Camera2D

@export var scroll_v:int

var shift_bool = false
var ctrl_bool = false

var isDragging:bool
var isShift:bool
var isCtrl:bool
var isAlt:bool

var dragStartMousePos = Vector2.ZERO
var dragStartCameraPos = Vector2.ZERO

func _process(delta: float) -> void:
	ClickAndDrag()

	
func _input(event: InputEvent):
	
	#sc
	if event.is_action_pressed("shift"):
		isShift = true
	elif event.is_action_pressed("ctrl"):
		isCtrl = true
	elif event.is_action_pressed("alt"):
		isAlt = true
	if event.is_action_released("shift"):
		isShift = false
	elif event.is_action_released("ctrl"):
		isCtrl = false
	elif event.is_action_released("alt"):
		isAlt = false
		
	#滚轮
	if event.is_action_pressed("scroll_up"):
		if isCtrl:
			position.x-=40/zoom.x
		elif isShift:
			position.y-=200/zoom.x
		elif isAlt and zoom.x <=10:
			zoom *= 1.15
		else:
			position.y-=40/zoom.x
	if event.is_action_pressed("scroll_down"):
		if isCtrl:
			position.x+=40/zoom.x
		elif isShift:
			position.y+=200/zoom.x
		elif isAlt and zoom.x >= 0.01:
			zoom *= 0.85
		else:
			position.y+=40/zoom.x

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
