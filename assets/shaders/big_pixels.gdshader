shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

uniform float pixel_size = 120.0;
uniform int color_steps = 4;
uniform float dither_strength = 0.02;

float bayer4x4(vec2 p) {
    int x = int(mod(p.x, 4.0));
    int y = int(mod(p.y, 4.0));
    int index = x + y * 4;

    float[16] matrix = float[](
        0.0,  8.0,  2.0, 10.0,
        12.0, 4.0, 14.0, 6.0,
        3.0, 11.0, 1.0, 9.0,
        15.0, 7.0, 13.0, 5.0
    );

    return matrix[index] / 16.0 - 0.5;
}

void fragment() {
    vec2 uv = floor(UV * pixel_size) / pixel_size;
    vec4 col = texture(SCREEN_TEXTURE, uv);

    float dither = bayer4x4(FRAGCOORD.xy) * dither_strength;
    col.rgb += dither;

    col.rgb = floor(col.rgb * float(color_steps)) / float(color_steps);

    COLOR = col;
}
