extends Node2D

class_name FibonacciMain

@onready var fibonacci_sequence = $FibonacciSequence
@onready var number_area = $ButtonsBackgroundLabel/NumberAreaTextEdit
@onready var warning_text = $WarningText
@onready var generate_button = $BottomButtons/GenerateButton
@onready var clear_button = $BottomButtons/ClearButton

const windowed_screen_size_x = 640
const windowed_screen_size_y = 480

var terms : int = 0
var count : int = 0
var fib_0 : int = 0
var fib_1 : int = 1

var enter_pressed : bool = false

var cleaned_text
var index_column

func _ready():
	generate_sequence(2, false)

func _process(delta):
	DisplayServer.window_set_min_size(Vector2i(160, 120))
	cleaned_text = number_area.text
	index_column = cleaned_text.length()
	number_area.set_caret_column(index_column)

	for c in number_area.text:
		if (!c.is_valid_int() or number_area.text[0] == "0"):
			number_area.remove_text (0, cleaned_text.length() - 1, 0, cleaned_text.length())

	if Input.is_action_just_pressed("ui_enter"):
		enter_pressed = true
		number_area.clear()
		number_area.text = cleaned_text
		for c in number_area.text:
			if (c == "\n"):
				number_area.text = number_area.text.erase(number_area.text.length() - 1, 1)

	if Input.is_action_just_released("ui_enter"):
		enter_pressed = false

	if Input.is_action_pressed("ui_enter") and number_area.has_focus():
		terms = int(number_area.text)
		generate_sequence(terms, false)

## Generates the Fibonacci sequence.
func generate_sequence(terms : int, cleared : bool):
	if !cleared:
		var output_text = "Fibonacci sequence generated! Generated {str} terms."
		warning_text.text = output_text.format({"str": terms})
	else:
		warning_text.text = "Clearing the current input and the sequence..."

	var fibonacci_sequence_text = ""
	if (terms >= 0):
		while count < terms:
			fibonacci_sequence_text = fibonacci_sequence_text + str(fib_0) + "\n"
			fibonacci_sequence.text = fibonacci_sequence_text
			var fib = fib_0 + fib_1
			fib_0 = fib_1
			fib_1 = fib
			count += 1
	terms = 0
	count = 0
	fib_0 = 0
	fib_1 = 1

func _on_generate_button_pressed():
	terms = int(number_area.text)
	generate_sequence(terms, false)
	number_area.grab_focus()

func _on_clear_button_pressed():
	generate_sequence(2, true)
	number_area.clear()
	number_area.grab_focus()

func _on_restore_window_size_button_pressed():
	DisplayServer.window_set_size(Vector2i(windowed_screen_size_x, windowed_screen_size_y))
	number_area.grab_focus()
