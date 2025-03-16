extends RigidBody3D

signal score_trash(value)

var interactable = null


func _on_entered_trash_box(area: Area3D) -> void:
	print("trash has touched box")
	score_trash.emit(1)
	
