// Godot 4 Control Node Fade Shader
// Godot 4 控件节点浮现着色器

shader_type canvas_item;

// uniform (统一变量) 用于控制整体透明度
// 0.0 是完全透明, 1.0 是完全不透明
uniform float alpha : hint_range(0.0, 1.0) = 1.0;

// uniform 用于控制从下到上浮现的进度
// 0.0 表示完全隐藏 (从顶部开始消失)
// 1.0 表示完全显示
uniform float fade_progress : hint_range(0.0, 1.0) = 1.0;

// uniform 用于控制浮现效果边缘的柔和度
// 较小的值会产生锐利的边缘，较大的值会产生更柔和、更渐变的淡入效果
uniform float softness : hint_range(0.0, 1.0) = 0.1;

void fragment() {
	// 1. 获取当前像素 (UV坐标) 的原始颜色
	vec4 original_color = COLOR;

	// 2. 计算浮现效果的垂直边界
	// 当 fade_progress 从 0.0 变化到 1.0 时，这个边界会从底部 (1.0) 移动到顶部 (0.0)
	float fade_boundary = 1.0 - fade_progress;

	// 3. 使用 smoothstep 计算淡入的遮罩 (mask)
	// 这个函数会根据像素的垂直位置 (UV.y) 相对于边界，平滑地生成一个 0.0 到 1.0 的值
	// UV.y 坐标越大的像素 (越靠下的像素) 会越先变得不透明
	float fade_mask = smoothstep(fade_boundary - softness, fade_boundary, UV.y);

	// 4. 将浮现效果的遮罩应用到原始颜色的 alpha 通道上
	original_color.a *= fade_mask;

	// 5. 再应用整体的透明度
	original_color.a *= alpha;

	// 6. 设置像素的最终颜色
	COLOR = original_color;
}
