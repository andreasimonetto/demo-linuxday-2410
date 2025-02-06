extends CharacterBody2D

@export var speed := 80.0 # px/s

@onready var sprite: AnimatedSprite2D = $sprite
var input_dir := Vector2.ZERO

func _ready() -> void:
    $sprite.play("idle")

func _physics_process(_dt: float) -> void:
    velocity = speed * input_dir.normalized()
    move_and_slide()

    if input_dir != Vector2.ZERO:
        if sprite.animation != "walk":
            sprite.play("walk")
    elif sprite.animation != "idle":
        sprite.play("idle")
