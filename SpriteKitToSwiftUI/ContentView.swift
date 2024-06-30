//
//  ContentView.swift
//  SpriteKitToSwiftUI
//
//  Created by Timothy Andrian on 30/06/24.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    @StateObject var navigationConntroller: NavigationController = NavigationController()
    var scene: SKScene {
        let scene = StartScene(size: CGSize(width: 400, height: 400), navigationController: navigationConntroller)
        scene.scaleMode = .fill
        return scene
    }

    var body: some View {
        if navigationConntroller.isNavigatingToFinishView {
            FinishView(navigationController: navigationConntroller)
        } else {
            SpriteView(scene: scene).ignoresSafeArea()
        }

    }
}

struct FinishView: View {
    @ObservedObject var navigationController: NavigationController
    var body: some View {
        VStack{
            Text("You are in the Finish View!")
            Button {
                navigationController.isNavigatingToFinishView = false
            } label: {
                Text("Back to start")
            }
        }
    }
}

class StartScene: SKScene {
    @ObservedObject var navigationController: NavigationController
    var labelStart: SKLabelNode?
    var buttonNode: SKSpriteNode!
    
    init(size: CGSize, navigationController:NavigationController) {
        self.navigationController = navigationController
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func sceneDidLoad() {
        labelStart = SKLabelNode(text: "Click the blu box to Begin")
        labelStart?.position = CGPoint(x: 200, y: 200)
        addChild(labelStart!)

        buttonNode = SKSpriteNode(color: .blue, size: CGSize(width: 200, height: 50))
        buttonNode.position = CGPoint(x: 200, y: 150)
        addChild(buttonNode)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            if atPoint(touchLocation) == buttonNode {
                navigationController.isNavigatingToFinishView = true
            }
        }
    }
}

class NavigationController: ObservableObject {
    @Published var isNavigatingToFinishView = false
}

#Preview {
    ContentView()
}
