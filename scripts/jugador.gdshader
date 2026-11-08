shader_type spatial;
render_mode unshaded;

uniform sampler2D textura : hint_screen_texture;
const int tamano_pixel = 4;

// Controla los escalones de luz. 8.0 mantiene más detalles de tus texturas
const float niveles_color = 8.0; 

// Controla qué tanto se revelan los detalles en la sombra (0.15 a 0.25 es ideal)
const float realce_textura = 0.20; 

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
    
    // Capturamos tu textura pixelada original
    vec3 color_original = texture(textura, uv).rgb;
    
    // --- EFECTO EXTERMINADOR DE PLAGAS ---
    // En lugar de meter luz gris artificial, rescatamos un porcentaje del color 
    // de tus propias texturas directamente desde la penumbra.
    vec3 color_ajustado = mix(color_original, color_original + realce_textura, color_original);
    
    // Posterizamos para mantener el look retro/2D sin destruir las líneas de tus mallas
    vec3 color_posterizado = floor(color_ajustado * niveles_color) / niveles_color;
    
    ALBEDO = color_posterizado;
}
