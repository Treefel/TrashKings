extends Node

var teamNoiseScore
var trashScore
var timeRemaining
var numPlayers = 1
var players


# Called when the node enters the scene tree for the first time.
func _ready():
	teamNoiseScore = 0
	trashScore = 0
	players[0] = $Player
	for i in range(1,numPlayers):
		players.append(load("res://player.tscn").instantiate())
	
	
	timeRemaining = 180 #in seconds
	$HUD.update_TrashScore(str(trashScore))
	$HUD.update_TeamNoiseScore(float(teamNoiseScore))
	$HUD.update_TimeRemaining(str(timeRemaining))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$HUD.update_TrashScore(str(trashScore))
	$HUD.update_TeamNoiseScore(float(teamNoiseScore))
	$HUD.update_TimeRemaining(str(timeRemaining))

func updateTeamNoise(scores):
	for player in players:
		teamNoiseScore += player.noiseScore
		teamNoiseScore -= 3
