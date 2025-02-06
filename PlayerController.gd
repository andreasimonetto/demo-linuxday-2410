extends Node

@onready var is_mobile := (OS.has_feature("mobile") or OS.has_feature("web_android") or OS.has_feature("web_ios"))
@onready var controller_overlay: CanvasLayer = $controller_overlay
@onready var analog_stick_area: Control = $controller_overlay/analog_stick_area
@onready var analog_stick: TextureRect = $controller_overlay/analog_stick_area/analog_stick
@onready var analog_stick_p0 := analog_stick.position + .5 * analog_stick.size

var input_node: Node : get = get_input_node
var _analog_stick_pressed := false

func _ready() -> void:
    if is_mobile:
        set_process_input(false)
        analog_stick_area.connect("gui_input", self._on_analog_stick_area_gui_input)

    controller_overlay.visible = is_mobile

func get_input_node() -> Node:
    var node := get_parent()
    if not (node and "input_dir" in node):
        return null
    return node

func _input(event: InputEvent) -> void:
    if event.is_action_pressed("ui_right") or event.is_action_released("ui_left"):
        input_node.input_dir.x += 1
    elif event.is_action_pressed("ui_left") or event.is_action_released("ui_right"):
        input_node.input_dir.x -= 1
        
    if event.is_action_pressed("ui_down") or event.is_action_released("ui_up"):
        input_node.input_dir.y += 1
    elif event.is_action_pressed("ui_up") or event.is_action_released("ui_down"):
        input_node.input_dir.y -= 1

func _on_analog_stick_area_gui_input(event: InputEvent) -> void:
    if event is InputEventMouse:
        if event is InputEventMouseButton:
            _analog_stick_pressed = event.pressed
            
        var dp: Vector2 = (event.position - analog_stick_p0) if _analog_stick_pressed else Vector2.ZERO
        analog_stick.position = analog_stick_p0 - .5 * analog_stick.size + dp.limit_length(10.0)
        input_node.input_dir = dp.normalized()
