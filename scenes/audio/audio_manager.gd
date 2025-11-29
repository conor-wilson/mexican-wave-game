extends Node

@export var music_tune:AudioStreamWAV 
@export var music_beats:AudioStreamWAV

@export var _audio_stream_player_scene:PackedScene

var _audio_players: Array[AudioStreamPlayer] = []

func stop_all_audio():
	for i in range(_audio_players.size()):
		_audio_players[i].stop()

func play_audio(audio:AudioStreamWAV):
	var audioPlayer = _get_audio_player_for_audio(audio)
	audioPlayer.play()

func stop_audio(audio:AudioStreamWAV):
	var audioPlayer = _get_audio_player_for_audio(audio)
	audioPlayer.stop()

func _get_audio_player_for_audio(audio:AudioStreamWAV):
	for i in range(_audio_players.size()):
		if _audio_players[i].stream == audio:
			return _audio_players[i]
	var new_audio_player = _audio_stream_player_scene.instantiate() as AudioStreamPlayer
	self.add_child(new_audio_player)
	_audio_players.append(new_audio_player)
	new_audio_player.stream = audio
	return new_audio_player
