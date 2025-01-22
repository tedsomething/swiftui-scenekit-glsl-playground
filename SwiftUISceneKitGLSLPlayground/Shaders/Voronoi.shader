vec3 random3(vec3 c) {
    float j = dot(c, vec3(127.1, 311.7, 74.7));
    vec3 p = fract(sin(vec3(j, j+1.0, j+2.0)) * 43758.5453);
    
    return p;
}

float random1(vec3 c) {
    return random3(c).x;
}

float dist(vec3 a, vec3 b) {
    vec3 diff = a - b;
    return sqrt(dot(diff, diff));
}

#pragma body

vec3 position_raw = (u_inverseModelViewTransform * vec4(_surface.position, 1.0)).xyz;
vec3 bbox_center = (u_boundingBox[0] + u_boundingBox[1]) * 0.5;
vec3 bbox_extent = (u_boundingBox[1] - u_boundingBox[0]) * 0.5;
vec3 position = (position_raw - bbox_center) / bbox_extent;

vec3 color1 = vec3(0.7454, 0.042311, 0.048172); // Red
vec3 color2 = vec3(0.921577, 0.223228, 0.013702); // Orange
vec3 color3 = vec3(0.97344, 0.479321, 0.020289); // Yellow
vec3 color4 = vec3(0.122138, 0.496934, 0.06301); // Green

float scale = 10.0;
float normal_scale = 1.5;
vec3 p = position * scale;

vec3 cell_base = floor(p);

float min_dist = 1e6;
float value = -1.0;
float3 value_offset = vec3(0.0);

for (int z = -1; z <= 1; z++) {
    for (int y = -1; y <= 1; y++) {
        for (int x = -1; x <= 1; x++) {
            // Neighbor cell coordinates
            vec3 neighbor = cell_base + vec3(x, y, z);

            // Random offset within this neighbor cell
            vec3 rand_offset = random3(neighbor);

            // Actual "seed" position in that cell
            vec3 cell_point = neighbor + rand_offset;

            // Distance from our fragment's position to the cell's seed
            float d = dist(cell_point, p);

            // If it's closer, record the new min_dist & cell ID
            if (d < min_dist) {
                min_dist = d;
                value = clamp(random1(neighbor), 0.0, 1.0);
                value_offset = rand_offset;
            }
        }
    }
}

vec3 color;

if (value < 1.0) {
    color = color4;
}

if (value < 0.7) {
    color = color3;
}

if (value < 0.4) {
    color = color2;
}

if (value < 0.2) {
    color = color1;
}

_surface.normal = normalize(_surface.normal + ((value_offset - 0.5) * normal_scale));
_surface.diffuse = vec4(color, 1.0);
