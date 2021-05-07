//
//  RetryScene2.swift
//  gameBitcoin
//
//  Created by Aditya Ramadhan on 04/05/21.
//

import SpriteKit
import UIKit


class RetryScene2 : SKScene {
    var gradient: UIView!
override func didMove(to view: SKView) {
    backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    addLogo()
    addLabel()
}

override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    SFXPlayer.shared.PlaySFX(SFXFileName: "startgame")
    let gameScene = GameScene(size: view!.bounds.size)
    view?.presentScene(gameScene)
}


func addLogo(){
    let gambar = SKSpriteNode(imageNamed: "Rectangle1")
    gambar.position = CGPoint(x:frame.midX, y: frame.midY)
    gambar.zPosition = -1
    addChild(gambar)
    let logo = SKSpriteNode(texture: SKTexture(imageNamed: "ball"), color: #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1), size: CGSize(width: frame.size.width/2, height: frame.size.width/2)
    )
    logo.colorBlendFactor = 1.0
    logo.position = CGPoint(x: frame.midX, y: frame.midY+frame.size.height/4)
    addChild(logo)
    let image = SKSpriteNode(texture: SKTexture(imageNamed: "bitcoinmmj"), color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), size: CGSize(width: frame.size.width/2, height: frame.size.width/2)
    )
    image.position = CGPoint(x: frame.midX, y: frame.midY)
    addChild(image)
}

func animate(label: SKNode){
    let fadeOut = SKAction.fadeOut(withDuration: 0.5)
    let fadeIn = SKAction.fadeIn(withDuration: 0.5)
    let sequence = SKAction.sequence([fadeOut,fadeIn])
    label.run(SKAction.repeatForever(sequence))
}

func addLabel(){
    let gameLabel = SKLabelNode(text: "Catch the Bitcoin")
    gameLabel.fontName = ""
    gameLabel.fontSize = 35.0
    gameLabel.fontColor = #colorLiteral(red: 0.1315995455, green: 0.1316291094, blue: 0.131595701, alpha: 1)
    gameLabel.position = CGPoint(x: frame.midX, y: frame.midY - frame.size.height/6)
    addChild(gameLabel)
    let retryLabel = SKLabelNode(text: "Retry to achieve goal")
    retryLabel.fontName = ""
    retryLabel.fontSize = 30.0
    retryLabel.fontColor = #colorLiteral(red: 0.1315995455, green: 0.1316291094, blue: 0.131595701, alpha: 1)
    retryLabel.position = CGPoint(x: frame.midX, y: frame.midY - frame.size.height/4)
    addChild(retryLabel)
    animate(label: retryLabel)
}
}

