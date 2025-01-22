#pragma body

vec3 color1 = vec3(0.0, 0.337164, 0.715694); // Blue
vec3 color2 = vec3(0.304986, 0.046665, 0.309469); // Purple
vec3 color3 = vec3(0.7454, 0.042311, 0.048172); // Red
vec3 color4 = vec3(0.921577, 0.223228, 0.013702); // Orange
vec3 color5 = vec3(0.97344, 0.479321, 0.020289); // Yellow
vec3 color6 = vec3(0.122138, 0.496934, 0.06301); // Green

vec3 color;
    
vec3 position_raw = (u_inverseModelViewTransform * vec4(_surface.position, 1.0)).xyz;
vec3 bbox_center = (u_boundingBox[0] + u_boundingBox[1]) * 0.5;
vec3 bbox_extent = (u_boundingBox[1] - u_boundingBox[0]) * 0.5;
vec3 position = (position_raw - bbox_center) / bbox_extent;

if (position.y > -1.0) color = color1;

if (position.y > -0.6) color = color2;

if (position.y > -0.3) color = color3;

if (position.y > 0.0) color = color4;

if (position.y > 0.3) color = color5;

if (position.y > 0.6) color = color6;

_surface.diffuse = vec4(color, 1.0);
