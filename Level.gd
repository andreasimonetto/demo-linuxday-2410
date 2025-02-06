extends Node2D

func _ready() -> void:
    if OS.has_feature("web_android") or OS.has_feature("web_ios"):
        DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
