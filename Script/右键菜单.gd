extends VBoxContainer
var follow:bool = false
func _ready() -> void:
	#right_menu_show()
	pass

func _process(delta: float) -> void:
	if follow:
		position = get_global_mouse_position()

func right_menu_show():
	# 2. 创建一个新的 Tween
	# create_tween() 会创建一个与节点生命周期绑定的补间动画
	var tween = create_tween()

	# 3. 设置初始状态 (可选，但推荐)
	# 让控件在动画开始前是完全不可见的
	material.set_shader_parameter("fade_progress", 0.0)
	material.set_shader_parameter("alpha", 0.0)

	# 4. 为 "fade_progress" 创建动画
	# 这会让控件在 1.0 秒内从下往上浮现
	# tween_property(对象, "属性:子属性", 最终值, 持续时间)
	tween.tween_property(material, "shader_parameter/fade_progress", 1.0, 0.3).set_ease(Tween.EASE_IN_OUT)

	# 5. 并行地为 "alpha" 创建动画
	# 这会让控件在 1.0 秒内从完全透明变为完全不透明
	# 使用 parallel() 可以让下一个动画与上一个同时开始
	tween.parallel().tween_property(material, "shader_parameter/alpha", 1.0, 0.3).set_ease(Tween.EASE_IN_OUT)
	
	# 你也可以链式调用，例如先浮现，再淡入
	# tween.tween_property(material, "shader_parameter/fade_progress", 1.0, 1.0)
	# tween.tween_property(material, "shader_parameter/alpha", 1.0, 0.5) # 在浮现之后再花0.5秒淡入

func right_menu_hide():
	# 2. 创建一个新的 Tween
	# create_tween() 会创建一个与节点生命周期绑定的补间动画
	var tween = create_tween()
	# 4. 为 "fade_progress" 创建动画
	# 这会让控件在 1.0 秒内从下往上浮现
	# tween_property(对象, "属性:子属性", 最终值, 持续时间)
	tween.tween_property(material, "shader_parameter/fade_progress", 0, 0.1).set_ease(Tween.EASE_IN_OUT)

	# 5. 并行地为 "alpha" 创建动画
	# 这会让控件在 1.0 秒内从完全透明变为完全不透明
	# 使用 parallel() 可以让下一个动画与上一个同时开始
	tween.parallel().tween_property(material, "shader_parameter/alpha", 0, 0.1).set_ease(Tween.EASE_IN_OUT)
	await tween.finished
	visible = false
	# 你也可以链式调用，例如先浮现，再淡入
	# tween.tween_property(material, "shader_parameter/fade_progress", 1.0, 1.0)
	# tween.tween_property(material, "shader_parameter/alpha", 1.0, 0.5) # 在浮现之后再花0.5秒淡入
