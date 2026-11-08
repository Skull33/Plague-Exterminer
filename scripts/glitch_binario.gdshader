shader_type spatial;
render_mode unshaded, cull_disabled;

// Textura original del sprite (se usa solo para extraer la transparencia/silueta)
uniform sampler2D source_texture : source_color, filter_nearest;

// Parámetros
uniform float grid_size : hint_range(10.0, 100.0) = 40.0;
uniform float speed : hint_range(1.0, 30.0) = 15.0;
uniform vec4 binary_color : source_color = vec4(0.0, 1.0, 0.3, 1.0);
uniform float corruption_intensity : hint_range(0.0, 1.0) = 0.6;

// Billboard en Y nativo y seguro para Godot 4
void vertex() {
    float scale_x = length(MODEL_MATRIX[0].xyz);
    float scale_z = length(MODEL_MATRIX[2].xyz);

    MODELVIEW_MATRIX = VIEW_MATRIX * MODEL_MATRIX;
    
    MODELVIEW_MATRIX[0][0] = scale_x;
    MODELVIEW_MATRIX[0][1] = 0.0;
    MODELVIEW_MATRIX[0][2] = 0.0;

    MODELVIEW_MATRIX[2][0] = 0.0;
    MODELVIEW_MATRIX[2][1] = 0.0;
    MODELVIEW_MATRIX[2][2] = scale_z;
}

float random(vec2 st) {
    return fract(sin(dot(st.xy, vec2(12.9898, 78.233))) * 43758.5453123);
}

void fragment() {
    vec2 uv = UV;
    vec4 tex_color = texture(source_texture, uv);
    
    // Si el pixel es transparente (fuera de la rata), descartarlo
    if (tex_color.a < 0.1) {
        discard;
    }
    
    vec2 grid_uv = uv * grid_size;
    vec2 ipos = floor(grid_uv);
    vec2 fpos = fract(grid_uv);
    
    float time_step = floor(TIME * speed);
    float rand_val = random(ipos + time_step);
    float bit = step(0.5, rand_val);
    
    float shape = 0.0;
    float active = step(1.0 - corruption_intensity, random(ipos * 0.1));
    
    if (active > 0.5) {
        if (bit > 0.5) {
            if (fpos.x > 0.4 && fpos.x < 0.6 && fpos.y > 0.2 && fpos.y < 0.8) {
                shape = 1.0;
            }
        } else {
            if ((fpos.x > 0.3 && fpos.x < 0.7) && (fpos.y > 0.2 && fpos.y < 0.8)) {
                if (!(fpos.x > 0.4 && fpos.x < 0.6 && fpos.y > 0.3 && fpos.y < 0.7)) {
                    shape = 1.0;
                }
            }
        }
    }
    
    // AQUÍ ESTÁ EL CAMBIO: Definimos el cuerpo de la rata como negro puro (vec3(0.0))
    vec3 base_color = vec3(0.0); 
    
    // Mezclamos el fondo negro con el color de los ceros y unos del glitch
    vec3 final_color = mix(base_color, binary_color.rgb, shape * corruption_intensity);
    
    ALBEDO = final_color;
    ALPHA = tex_color.a;
}