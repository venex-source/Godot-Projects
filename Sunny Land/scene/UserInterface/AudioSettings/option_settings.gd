extends Control

var background_music = AudioServer.get_bus_index("Music")
var sound_effect = AudioServer.get_bus_index("SoundEffect")

func _ready():
	%MusicSlider.change_value(db_to_linear(background_music))
	%EffectSlider.change_value(db_to_linear(sound_effect))

func _on_back_button_pressed():
	hide()

func set_bus_volume(audio_bus, value) -> void:
	AudioServer.set_bus_volume_db(audio_bus, linear_to_db(value))
	AudioServer.set_bus_mute(
		audio_bus,
		true if not value else false
	)

func _on_music_slider_value_changed(value):
	set_bus_volume(background_music, value)

func _on_effect_slider_value_changed(value):
	set_bus_volume(sound_effect, value)
