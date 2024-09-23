shader_type canvas_item;

uniform sampler2D noise_texture;
uniform sampler2D gradient_texture;

void fragment() {
    vec4 noise_color = texture(noise_texture, UV);
    vec4 gradient_color = texture(gradient_texture, UV);

    // Simple blending: Average the colors
    COLOR = (noise_color + gradient_color) / 2.0;

    // Or, use a mix factor for more control
    // float mix_factor = 0.5; // Adjust between 0.0 (full gradient) and 1.0 (full noise)
    // COLOR = mix(gradient_color, noise_color, mix_factor);
}