extends Control

class_name ResponsiveControlHelper

@export_enum("Full alignment", "Horizontal alignment", "Vertical alignment") var alignment: String

@export var to_the_bottom = false
@export var to_the_right = false
@export var set_custom_margin = false

@export var custom_top_margin = 0
@export var custom_bottom_margin = 0

var rect_size_x = self.size.x
var rect_size_y = self.size.y

var time_scale_target = 1.0
var interpolation = 1.0

func _process(_delta):
	match alignment:
		"Full alignment":
			self.size = Vector2(
				get_viewport().size.x,
				get_viewport().size.y
			)
		"Horizontal alignment":
			self.size = Vector2(
				rect_size_x,
				get_viewport().size.y
			)
		"Vertical alignment":
			self.size = Vector2(
				get_viewport().size.x,
				rect_size_y
			)
		_:
			self.size = Vector2(
				rect_size_x,
				rect_size_y
			)

	if to_the_bottom:
		self.position.y = get_viewport().size.y - self.size.y
	if to_the_right:
		self.position.x = get_viewport().size.x - self.size.x
	if set_custom_margin:
		self.position.y = custom_top_margin
		self.size.y = self.size.y - custom_bottom_margin
		print(self.size)
