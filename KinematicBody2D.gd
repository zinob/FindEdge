extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

var velocity = Vector2()
var target = Vector2()

func _input(event):
	if event is InputEventMouseButton:
		target = get_global_mouse_position()
		self.position = target
		print(target)
func _physics_process(delta):
	velocity = move_and_slide(velocity, Vector2.UP,false,4,90,false)
	
