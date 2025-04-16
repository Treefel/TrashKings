extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func update_trash_score(text):
	$TrashScore.text = text + "/3"

func update_time_remaining(text):
	$TimeRemaining.text = text
	
func update_noise_score(score):
	$NoiseScore.set_value(score)

func update_team_noise_score(score):
	$TeamNoiseScore.set_value(score)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
