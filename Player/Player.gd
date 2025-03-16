extends CharacterBody3D

#signal score_trash(value)
signal play_walk_anim()
signal end_walk_anim()
#signal pickup_trash()

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var busy = false
var interactable = null
var floorType = null
var carryingTrashBool = false
var pickedUpTrash = null
var noise_score = 0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	set_process(true)
	pass

func _physics_process(delta):
	## Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
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
			play_walk_anim.emit()
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
			$Raccoon.rotation.y = atan2(velocity.x,velocity.z)
			if(floorType != null):
				
				print(floorType.get_meta("FloorScore"))
				noise_score += float( direction.length()) * floorType.get_meta("FloorScore")
		else:
			end_walk_anim.emit()
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)
		if(interact):
			if(carryingTrashBool == true):
				if(pickedUpTrash):
					drop_trash(interactable)
					print("dropping")
			elif(interactable != null):
				print("Interacting !!!")
				print(interactable)
				if(carryingTrashBool == false):
					if(interactable.get_parent().get_parent().get_name() == "Trash"):
						print("attempting pickup")
						pickup_trash(interactable)
						#pickup_trash.emit()
				
			else:
				print("Nothing here!")
		
		#noise_score -= 1;
		#$Model.rotation.y = 2*PI - angle()  + PI/2
		
		#rotate_object_local(input_dir.angle(),1)
	move_and_slide()
	if(carryingTrashBool == true):
		pickedUpTrash.global_position =$"Raccoon/Interaction Range".global_position
	
func _process(_delta):
#if Input.is_action_just_pressed("ui_accept"):
		#var check = 0
	pass

func _on_interactable_area_exited(_area):
	interactable = null
	print("Interaction exited")


func _on_interaction_area_entered(area):
	interactable = area
	print("Interaction entered")


func _on_floor_checker_area_entered(area: Area3D) -> void:
	print("new floor boys!")
	floorType = area


func _on_floor_checker_area_exited(_area: Area3D) -> void:
	print("floor gone boys!")
	floorType = null

func pickup_trash(interactable):
	carryingTrashBool = true
	pickedUpTrash = interactable.get_parent().get_parent()
	if(pickedUpTrash == null):
		print("doesnt exist 93")
	pickedUpTrash.gravity_scale = 0
	pickedUpTrash.translate(Vector3(0,0.5,0))

func drop_trash(_interactable):
	pickedUpTrash.gravity_scale = 1
	carryingTrashBool = false
	pickedUpTrash = null
	
