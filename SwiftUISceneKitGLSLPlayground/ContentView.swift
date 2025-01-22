import SwiftUI
import SceneKit

struct ContentView: View {
    @State var scene = SCNScene()
    @State var sceneOptions: SceneView.Options = [
        .autoenablesDefaultLighting,
        .allowsCameraControl,
        .rendersContinuously
    ]
    
    @State var sphereWrapNode = SCNNode()
    @State var cameraWrapNode = SCNNode()
    
    init() {
        setupScene()
        setupSphere()
        setupCamera()
    }
    
    func setupScene() {
        scene.wantsScreenSpaceReflection = true
        scene.background.contents = UIColor.black
        
        scene.rootNode.addChildNode(sphereWrapNode)
        scene.rootNode.addChildNode(cameraWrapNode)
    }
    
    func setupCamera() {
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 5)
        
        cameraWrapNode.addChildNode(cameraNode)
    }
    
    func setupSphere() {
        let sphereNode = SCNNode()
        
        let material = SCNMaterial()
        material.lightingModel = .physicallyBased
        material.diffuse.contents = UIColor(Color.white)
        material.diffuse.intensity = 1
        
        if let shader = loadShader(named: "ColorFade.shader") {
            material.shaderModifiers = [.surface: shader]
        }
        
        let geometry = SCNSphere(radius: 1)
        geometry.materials = [material]
        geometry.segmentCount = 100
        
        sphereNode.geometry = geometry
        sphereNode.position = .init(0, 0, 0)
        
        sphereWrapNode.addChildNode(sphereNode)
    }
    
    private func loadShader(named name: String) -> String? {
        guard let path = Bundle.main.path(forResource: name, ofType: nil) else {
            print("Failed to find shader file: \(name)")
            return nil
        }
        
        do {
            return try String(contentsOfFile: path, encoding: .utf8)
        } catch {
            print("Failed to load shader: \(error.localizedDescription)")
            return nil
        }
    }
    
    var body: some View {
        SceneView(scene: scene, options: sceneOptions)
            .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
