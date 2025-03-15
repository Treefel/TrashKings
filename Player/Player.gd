extends CharacterBody3D

signal score_trash(value)

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var busy = false
var interactable = null
var floor = null
var noiseScore = 0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	set_process(true)
	pass

func _physics_process(_delta):
	## Add the gravity.
	#if not is_on_floor():
		#velocity.y -= gravity * delta
#
	### Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	if not busy:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
		var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		var interact = (Input.is_action_just_pressed("ui_accept"))
		if direction:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
			$Model.rotation.y = atan2(velocity.x,velocity.z)
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)
		if(interact):
			if(interactable != null):
				print("Interacting !!!")
				print(interactable)
				score_trash.emit(1);
			else:
				print("Nothing here!")
		
		#$Model.rotation.y = 2*PI - angle()  + PI/2
		
		#rotate_object_local(input_dir.angle(),1)
	move_and_slide()
	
func _process(_delta):
#if Input.is_action_just_pressed("ui_accept"):
		#var check = 0
	pass

func _on_interactable_area_exited(_area):
	interactable = null
	print("exited")



func _on_interaction_area_entered(area):
	interactable = area
	print("entered PLAYER")


func _on_floor_checker_area_entered(area: Area3D) -> void:
	print("new floor boys!")
	floor = area


func _on_floor_checker_area_exited(area: Area3D) -> void:
	print("floor gone boys!")
	floor = null
