extends Node

var teamNoiseScore
var trashScore
var timeRemaining
var numPlayers = 1
var players = [1]


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
		$HUD/GameOverScreen.text = "Game Over"
	if(timeRemaining <= 0):
		$HUD/GameOverScreen.text = "Game Over"
		
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
