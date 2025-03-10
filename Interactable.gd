extends Area3D

var interactable = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass	
	

func callMeMaybe():
	print("calling on someone else, huh?")

func _on_area_entered(area):
	print("entering area")
	interactable = area
	


func _on_area_exited(_area):
	print("leaving area")
	interactable = null
