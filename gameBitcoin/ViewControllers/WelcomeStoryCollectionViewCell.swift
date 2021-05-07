//
//  WelcomeStoryCollectionViewCell.swift
//  gameBitcoin
//
//  Created by Aditya Ramadhan on 02/05/21.
//

import UIKit

class WelcomeStoryCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: WelcomeStoryCollectionViewCell.self)
    
    @IBOutlet weak var memojiImageView: UIImageView!
    @IBOutlet weak var storyLabel: UILabel!
    
    
    
    func setup(_ slide : storySlide){
        memojiImageView.image = slide.memojiImage
        storyLabel.textColor = #colorLiteral(red: 0.1315995455, green: 0.1316291094, blue: 0.131595701, alpha: 1)
        storyLabel.text = slide.story
    }
}
