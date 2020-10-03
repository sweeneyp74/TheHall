shader_type canvas_item;

uniform float amount = 3.0;

void fragment() {
	vec2 res = vec2(1.0 / SCREEN_PIXEL_SIZE.x, 1.0 / SCREEN_PIXEL_SIZE.y);
	
	res = res / amount;
	
	vec2 uvs = SCREEN_UV * res;
	
	uvs = ceil(uvs);
	
	uvs = uvs / res;
	
    COLOR.xyz = texture(TEXTURE, uvs).xyz;
}