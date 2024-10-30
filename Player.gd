extends CharacterBody2D

@export var speed := 80.0 # px/s

func _ready() -> void:
    $sprite.play("idle")

func _physics_process(_dt: float) -> void:
    if Input.is_action_pressed("ui_left"):
        velocity.x = -speed
    elif Input.is_action_pressed("ui_right"):
        velocity.x = speed
    else:
        velocity.x = 0.0

    if Input.is_action_pressed("ui_up"):
        velocity.y = -speed
    elif Input.is_action_pressed("ui_down"):
        velocity.y = speed
    else:
        velocity.y = 0.0

    if velocity.x != 0 or velocity.y != 0:
        $sprite.play("walk")
    else:
        $sprite.play("idle")
    
    move_and_slide()
