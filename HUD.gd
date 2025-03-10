extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func update_TrashScore(text):
	$TrashScore.text = text

func update_TimeRemaining(text):
	$TimeRemaining.text = text
	
func update_noiseScore(score):
	$NoiseScore.set_value(score)

func update_TeamNoiseScore(score):
	$TeamNoiseScore.set_value(score)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
