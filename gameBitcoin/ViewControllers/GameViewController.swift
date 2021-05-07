//
//  GameViewController.swift
//  gameBitcoin
//
//  Created by Aditya Ramadhan on 02/05/21.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    @IBOutlet weak var happinessLevel: UIProgressView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            let scene = RetryScene(size: view.bounds.size)
                // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
           
                // Present the scene
            view.presentScene(scene)
            
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
            
        }
    }
    
    
}
