//
//  WelcomeStoryViewController.swift
//  gameBitcoin
//
//  Created by Aditya Ramadhan on 02/05/21.
//

import UIKit
import AVFoundation

class WelcomeStoryViewController: UIViewController {
    
    @IBOutlet weak var pageCtrl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var gradient: UIView!
    @IBOutlet weak var tesd: UIImageView!
    @IBOutlet weak var cloudImage: UIImageView!
    @IBOutlet weak var cloudImage2: UIImageView!
    @IBOutlet weak var cloudImage3: UIImageView!
    @IBOutlet weak var coba: UIButton!
    var currentPage = 0 {
        didSet {
            pageCtrl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                nextBtn.setTitle("Set Goals", for: .normal)
            } else {
                nextBtn.setTitle("Next", for: .normal)
            }
        }
    }
    var audioPlayer: AVAudioPlayer?
    let gradientLayer:CAGradientLayer = CAGradientLayer()
    
    var slides : [storySlide] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        nextBtn.titleLabel?.font = UIFont(name: "SF-Pro-Display-Black.otf", size: 9)
        gradient.gradientBackground(from: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), to: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), direction: .topToBottom)
        slides = [storySlide(memojiImage: #imageLiteral(resourceName: "welcome"), story: "Hi! This is you with spirit and passion to achieve happiness") , storySlide(memojiImage: #imageLiteral(resourceName: "welcome1"), story: "You always think if you achieve your goals you will be happy"), storySlide(memojiImage: #imageLiteral(resourceName: "welcome3"), story: "So you set a goals to be achieved")
        ]
       startBackgroundMusic(bgmFIleName: "welcomesong")

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //Call Function for moving the clouds
        moveIt(cloudImage, 7.0)
        moveIt(cloudImage2, 9.0)
        moveIt(cloudImage3, 8.0)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let newVC = segue.destination as? GoalsPickViewController else { return }
        newVC.audioPlayer2 = audioPlayer
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let vc
//    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}


extension WelcomeStoryViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WelcomeStoryCollectionViewCell.identifier, for: indexPath) as! WelcomeStoryCollectionViewCell
        cell.setup(slides[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height:   collectionView.frame.height)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x/width)
        print(currentPage)
        
    }
    
    @IBAction func btngoGame(_ sender: UIButton) {
        if currentPage == slides.count - 1 {
//            stopBackgroundMusic()
//            stopBackgroundMusic()
           performSegue(withIdentifier: "gotoGoals", sender: sender)
        }else{
        currentPage += 1
        let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
        
    }
    
    
    func moveIt(_ imageView: UIImageView,_ speed:CGFloat) {
    let speeds = speed
    let imageSpeed = speeds / view.frame.size.width
    let averageSpeed = (view.frame.size.width - imageView.frame.origin.x) * imageSpeed
    UIView.animate(withDuration: TimeInterval(averageSpeed), delay: 0.0, options: .curveLinear, animations: {
    imageView.frame.origin.x = self.view.frame.size.width
    }, completion: { (_) in
    imageView.frame.origin.x = -imageView.frame.size.width
    self.moveIt(imageView,speeds)
    })
    }
    
    func startBackgroundMusic(bgmFIleName: String) {
            if let bundle = Bundle.main.path(forResource: bgmFIleName, ofType: "mp3") {
                let backgroundMusic = NSURL(fileURLWithPath: bundle)
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: backgroundMusic as URL)
                    guard let audioPlayer = audioPlayer else {return}
                    audioPlayer.numberOfLoops = -1
                    audioPlayer.prepareToPlay()
                    audioPlayer.play()
                } catch  {
                    print(error)
                }
            }
    }
    func stopBackgroundMusic() {
        guard let audioPlayer = audioPlayer else { return }
        audioPlayer.stop()
    }

}

enum GradientDirection {
    case leftToRight
    case rightToLeft
    case topToBottom
    case bottomToTop
}

extension UIView {
    func gradientBackground(from color1: UIColor, to color2: UIColor, direction: GradientDirection) {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [color1.cgColor, color2.cgColor]

        switch direction {
        case .leftToRight:
            gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        case .rightToLeft:
            gradient.startPoint = CGPoint(x: 1.0, y: 0.5)
            gradient.endPoint = CGPoint(x: 0.0, y: 0.5)
        case .bottomToTop:
            gradient.startPoint = CGPoint(x: 0.5, y: 1.0)
            gradient.endPoint = CGPoint(x: 0.5, y: 0.0)
        case .topToBottom:
            gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        default:
            break
        }

        self.layer.insertSublayer(gradient, at: 0)
    }
}



