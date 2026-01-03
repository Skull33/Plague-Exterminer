shader_type spatial;
render_mode unshaded;

uniform sampler2D textura : hint_screen_texture;
const int tamano_pixel = 5;

void fragment() {
    float shake_x = sin(TIME * 20.0) * 1.5;
    float shake_y = cos(TIME * 25.0) * 1.5;

    // Calculamos posición de pixel en pantalla
    vec2 screen_pos = FRAGCOORD.xy;

    float x = float(int(screen_pos.x + shake_y) % tamano_pixel);
    float y = float(int(screen_pos.y + shake_x) % tamano_pixel);

    x = screen_pos.x + floor(float(tamano_pixel) / 2.0) - x;
    y = screen_pos.y + floor(float(tamano_pixel) / 2.0) - y;

    vec2 uv = vec2(x, y) / VIEWPORT_SIZE;
    ALBEDO = texture(textura, uv).rgb;
}
