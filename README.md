A fun SwiftUI and SceneKit demo showcasing a variety of GLSL shader modifiers.

## Preview

<video src="Preview/Preview.mp4" alt="SceneKit GLSL Shader Preview" width="250">

## Usage

I currently don’t have a shader picker. To use a different shader, open ContentView.swift and change the parameter in

```
loadShader(named: "ColorFade.shader")
```

## Why?

Every time I added a new dice theme to the [Boring Dice app](https://boringdice.app/), the overall app size ballooned significantly because I had to export textures for each dice shape (d6, d8, d10, d20, etc.). To keep the download size manageable, I also had to reduce texture quality. However, many of these themes were originally created using simple Blender material shader nodes, so I decided to convert them directly into code. It allowed me to avoid large file sizes but also gave me the freedom to experiment with new custom effects.

As I continue exploring the fascinating world of shaders, I’ve collected a few interesting and useful techniques along the way, and I plan to keep expanding this collection in the future.
