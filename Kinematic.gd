extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var collision_count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.

var velocity = Vector2()
var target = Vector2()

func _input(event):
	if event is InputEventMouseButton:
		target = get_global_mouse_position()
		self.position = target
		print(target)
	
func _physics_process(delta):
	if get_slide_count() > 0:
		collision_count+=1
		var cc:KinematicCollision2D =get_slide_collision(0)
		if collision_count > 5: #We are a little bit stuck, nudge away
			position+= cc.normal * 2
		elif collision_count > 30: #We are probbably stuck, DO SOMETHING RAICAL...
			print("stuck at" + str(position)+ " for " + str(collision_count))
			var curve = Curve2D.new()
			
			var shape:CollisionPolygon2D=cc.get_collider_shape()
			for i in shape.polygon:
				curve.add_point(i)
			var my_local=global_position-shape.global_position
			var local_point = curve.interpolate_baked(curve.get_closest_offset(my_local))
			#curve.get_closest_point(my_local)

			print(my_local)
			print("new target %s"%[local_point])
			position = local_point  + shape.global_position
			print("moving to" + str(position))
			print(curve.get_baked_length())
			collision_count = 0
	else:
		collision_count = 0
		velocity= Vector2.ZERO
	velocity = move_and_slide(velocity, Vector2.UP,false,4,90,false)
