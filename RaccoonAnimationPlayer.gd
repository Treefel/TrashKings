extends Node3D

var animator

func _ready():
	animator = $AnimationPlayer

func play_walk_anim():
	animator.play("Armature")
	
func end_walk_anim():
	animator.pause()
