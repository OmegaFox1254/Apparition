@tool
extends TextureProgressBar

var atlas_texture = AtlasTexture.new()
@export var noise_texture = NoiseTexture2D.new()
var noise = FastNoiseLite.new()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	noise.seed = randi()

	noise_texture.in_3d_space = true;
	noise_texture.width = 71;
	noise_texture.height = 7;
	atlas_texture.atlas = noise_texture
	atlas_texture.region.size = Vector2(71, 7)
	atlas_texture.margin.position.x = 1;
	atlas_texture.margin.size.x = -1;
	texture_progress = atlas_texture;
	if !noise_texture.noise:
		noise_texture.noise = noise;


func _process(delta: float) -> void:
	noise_texture.noise.offset.z+=delta*10
