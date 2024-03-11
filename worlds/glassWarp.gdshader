shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}
uniform float scale : hint_range(0.1, 10) = 1.0;
uniform sampler2D screen_texture : hint_screen_texture, filter_nearest;

void fragment() {
	vec2 distortedUV = SCREEN_UV + texture(TEXTURE, UV).a * 0.01;
	vec4 screenColor = texture(screen_texture, distortedUV);
	COLOR = screenColor;
	
	
	//vec2 distortedUV = UV;
	//distortedUV.x += distortedUV.y * 0.1;
	//
	//// Called for every pixel the material is visible on.
	//vec4 pixelColor = texture(TEXTURE, distortedUV * scale);
	//COLOR = pixelColor;
	
	
}
