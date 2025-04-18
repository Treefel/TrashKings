extends Node

var teamNoiseScore
var trashScore
var timeRemaining
var tempColor
var numPlayers = 1
var players = [1]
var gameState = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	teamNoiseScore = 0
	trashScore = 0
	players[0] = $Player
	players[0].translate(Vector3(0, 4, 0))
	for i in range(1,numPlayers):
		players.append(load("res://player.tscn").instantiate())
		print("ADDED NEW PLAYER!!!!")
	
	
	timeRemaining = 180 #in seconds
	$HUD.update_trash_score(str(trashScore))
	$HUD.update_team_noise_score(float(teamNoiseScore))
	$HUD.update_time_remaining(str(timeRemaining))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$HUD.update_trash_score(str(trashScore))
	$HUD.update_team_noise_score(float(teamNoiseScore))
	$HUD.update_time_remaining(str(int(timeRemaining)))
	$HUD.update_noise_score(players[0].noise_score)
	#print(len(players))
	update_team_noise()
	
	
	if(teamNoiseScore >= 100):
		gameState = -1
	if(timeRemaining <= 0):
		gameState = -1
	if(trashScore >= 3):
		gameState = 1
	
	if(gameState == -1):
		$HUD/TextureRect.texture = load("res://TestTextures/TrashKings_DomesticatedScreen.png")
	if(gameState == 1):
		$HUD/TextureRect.texture = load("res://TestTextures/TrashKings_KingScreen.png")
	if(gameState == 3):
		$HUD/TextureRect.texture = load("res://TestTextures/TrashKings_InstructionsScreen.png")
		if (Input.is_key_pressed(KEY_SPACE)):
			print("close intrusctions")
			$HUD/TextureRect.texture = null
			gameState = 0
	timeRemaining -= delta	
	
func update_team_noise():
	teamNoiseScore = 0
	for player in players:
		teamNoiseScore += player.noise_score
	

func update_score(value):
	trashScore += value
	print("SCORED" + str(value))



func _on_player_score_trash(value):
	update_score(value)
	pass # Replace with function body.
	
 
