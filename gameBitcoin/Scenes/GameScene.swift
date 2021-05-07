//
//  GameScene.swift
//  gameBitcoin
//
//  Created by Aditya Ramadhan on 02/05/21.
//

import SpriteKit
import UIKit
import AVFoundation

enum PlayColor {
    static let colors = [
        UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1.0),
        UIColor(red: 241/255, green: 196/255, blue: 15/255, alpha: 1.0),
        UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1.0),
        UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 1.0)
    ]
}

enum SwitchState : Int {
    case red,yellow,green,blue
    
}


class GameScene: SKScene {
    let someNode = SKNode()
    var flag = 0
    var viewController  : GameViewController?
    var colorSwitch : SKSpriteNode!
    var switchState = SwitchState.red
    var currentColorIndex : Int?
    let scoreLabel = SKLabelNode(text: "0")
    let happinessLabel = SKLabelNode(text: "Happiness Level")
    let goalLabel = SKLabelNode(text: "CryptoTrader")
    var score = 0
    var happinessLeve = UIProgressView()
    var progressGoal = UIProgressView()
    var gradient: UIView!
    var sound = SKAction.playSoundFileNamed("gameover.mp3", waitForCompletion: false)

    override func didMove(to view: SKView) {
        
        // Get label node from scene and store it for use later
        setupPhysics()
        layoutScene()
    }
    
    func playSound(sound : SKAction)
    {
        run(sound)
    }
    func setupPhysics(){
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -2.0)
        physicsWorld.contactDelegate = self
    }
    func layoutScene(){
        let happinessLevel = UIProgressView(frame: CGRect(x: 0.0, y: 0.0, width: 300, height: 10))
        happinessLeve = happinessLevel
        happinessLeve.transform = CGAffineTransform(scaleX: 1.0, y: 5.0)
        happinessLeve.center = CGPoint(x: frame.midX, y: 80)
        view?.addSubview(happinessLevel)
        happinessLeve.progressTintColor =   #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        
        let progressLevel = UIProgressView(frame: CGRect(x: 0.0, y: 0.0, width: 300, height: 10))
        progressGoal = progressLevel
        progressGoal.transform = CGAffineTransform(scaleX: 1.0, y: 5.0)
        progressGoal.center = CGPoint(x: frame.minX + 30, y: 420)
        rotate()
        view?.addSubview(progressGoal)
        progressGoal.progressTintColor = .green
        
        colorSwitch = SKSpriteNode(imageNamed: "ColorCircle")
        colorSwitch.size = CGSize(width: frame.size.width/3, height: frame.size.width/3)
        colorSwitch.position = CGPoint(x: frame.midX, y: frame.minY + colorSwitch.size.height)
        colorSwitch.physicsBody = SKPhysicsBody(circleOfRadius: colorSwitch.size.width/2)
        colorSwitch.physicsBody?.categoryBitMask = PhysicsCategories.switchCategory
        colorSwitch.physicsBody?.isDynamic = false
        addChild(colorSwitch)
        
        scoreLabel.fontName = ""
        scoreLabel.fontSize = 60.0
        scoreLabel.fontColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        scoreLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(scoreLabel)
        happinessLabel.fontName = ""
        happinessLabel.fontSize = 20.0
        happinessLabel.fontColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        happinessLabel.position = CGPoint(x: frame.midX, y: 787)
        addChild(happinessLabel)
        goalLabel.fontName = ""
        goalLabel.fontSize = 20.0
        goalLabel.fontColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        goalLabel.position = CGPoint(x: frame.minX, y: 580)
        addChild(goalLabel)
        SpawnBall()
        
        
    }
    
    private func rotate(){
        progressGoal.transform = CGAffineTransform(rotationAngle: .pi / -2)
    }
    
    func updatescoreLabel(){
        scoreLabel.text = "\(score)"
        happinessLeve.progress += 0.1
        progressGoal.progress += 0.15
    }
    
    func SpawnBall() {
        currentColorIndex = Int(arc4random_uniform(UInt32(4)))
        let ball = SKSpriteNode(texture: SKTexture(imageNamed: "ball"), color: PlayColor.colors[currentColorIndex!], size: CGSize(width: 40.0, height: 40.0))
        ball.colorBlendFactor = 1.0
        ball.name = "Ball"
        ball.position = CGPoint(x: frame.midX, y: frame.maxY - colorSwitch.size.height)
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width/2)
        ball.physicsBody?.categoryBitMask = PhysicsCategories.ballCategory
        ball.physicsBody?.contactTestBitMask = PhysicsCategories.switchCategory
        ball.physicsBody?.collisionBitMask = PhysicsCategories.none
        addChild(ball)
    }
    func turnWheel(){
        if let newState = SwitchState(rawValue: switchState.rawValue + 1){
            switchState = newState
        }else {
            switchState = .red
        }
        colorSwitch.run(SKAction.rotate(byAngle: .pi/2, duration: 0.25))
    }
    
    func gameOver(){
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "welcome")
//        vc.view.frame = (self.view?.frame)!
//        UIView.transition(with: self.view!, duration: 0.1, options: .curveEaseOut, animations:
//                    {
//                        self.view?.window?.rootViewController = vc
//                }, completion: { completed in
//
//                })
        SFXPlayer.shared.PlaySFX(SFXFileName: "gameover")
        let menuScene = RetryScene2(size: view!.bounds.size)
        view?.presentScene(menuScene)
        print("game over")
    }
    
    func gameFinish(){
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "endstory")
                vc.view.frame = (self.view?.frame)!
                UIView.transition(with: self.view!, duration: 0.1, options: .curveEaseOut, animations:
                            {
                                self.view?.window?.rootViewController = vc
                        }, completion: { completed in
        
                        })
    }
        
//            self.navigationController?.pushViewController(controller, animated: true)
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        turnWheel()
    }
   
}

extension GameScene : SKPhysicsContactDelegate{
    
    func didBegin(_ contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if contactMask == PhysicsCategories.ballCategory | PhysicsCategories.switchCategory{
            print("Contact")
            if let ball = contact.bodyA.node?.name == "Ball" ? contact.bodyA.node as? SKSpriteNode : contact.bodyB.node as? SKSpriteNode{
                    if currentColorIndex == switchState.rawValue{
                        SFXPlayer.shared.PlaySFX(SFXFileName: "bitcoinmatch")
                        score += 1
                        updatescoreLabel()
                        print("correct")
                        ball.run(SKAction.fadeOut(withDuration: 0.25),completion: { ball.removeFromParent()
                            self.SpawnBall()
                            if self.score == 7 {
                                MusicPlayer.shared.startBackgroundMusic(bgmFIleName: "congrats")
                                self.gameFinish()
                            }
                        })
                        } else {
                            gameOver()
                        }
                    }else{
                        
                    }
                }
        }
    }

class SFXPlayer{
    static let shared = SFXPlayer()
    var audioPlayer: AVAudioPlayer?
    var SFXAllowStatus = true
    func PlaySFX(SFXFileName: String) {
        if SFXAllowStatus {
            if let bundle = Bundle.main.path(forResource: SFXFileName, ofType: "wav") {
                let SFXSound = NSURL(fileURLWithPath: bundle)
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: SFXSound as URL)
                    guard let audioPlayer = audioPlayer else {return}
                    audioPlayer.prepareToPlay()
                    audioPlayer.play()
                } catch  {
                    print(error)
                }
            }
        }
    }

    func StopSFX() {
        guard let audioPlayer = audioPlayer else { return }
        audioPlayer.stop()
    }

}

class MusicPlayer{
    static let shared = MusicPlayer()
    var audioPlayer: AVAudioPlayer?
    var BGMAllowStatus = true
    func startBackgroundMusic(bgmFIleName: String) {
        if (BGMAllowStatus) {
            if let bundle = Bundle.main.path(forResource: bgmFIleName, ofType: "mp3") {
                let backgroundMusic = NSURL(fileURLWithPath: bundle)
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: backgroundMusic as URL)
                    guard let audioPlayer = audioPlayer else {return}
                    audioPlayer.prepareToPlay()
                    audioPlayer.play()
                } catch  {
                    print(error)
                }
            }
        }
    }

    func stopBackgroundMusic() {
        guard let audioPlayer = audioPlayer else { return }
        audioPlayer.stop()
    }

}




extension WelcomeStoryViewController{
}

