//
//  EndStoryViewController.swift
//  gameBitcoin
//
//  Created by Aditya Ramadhan on 04/05/21.
//

import UIKit
import AVFoundation

class EndStoryViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var cloud3end: UIImageView!
    @IBOutlet weak var cloud2end: UIImageView!
    @IBOutlet weak var cloud1end: UIImageView!
    @IBOutlet weak var gradientViewEnd: UIView!
    @IBOutlet weak var pageCtrl: UIPageControl!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var progressDeacrease: UIProgressView!
    var happinessLevelProgress = UIProgressView()
    
    @IBOutlet weak var progressDecrease: UIProgressView!
    var currentPage = 0 {
        didSet {
            pageCtrl.currentPage = currentPage
            if currentPage == 0 {
                progressDeacrease.progress = 0.7
            } else if currentPage == 1 {
                progressDeacrease.progress = 0.3
            } else if currentPage == slides.count - 1 {
                nextBtn.setTitle("Finish", for: .normal)
            } else if currentPage == 3 {
                nextBtn.setTitle("Practice Gratitude", for: .normal )
            } else if currentPage == 5 {
                nextBtn.setTitle("Be Thankful", for: .normal )
            } else if currentPage == 6 {
                nextBtn.setTitle("Next", for: .normal)
                progressDeacrease.progress = 0.7
            } else{
                nextBtn.setTitle("Next", for: .normal)
            }
        }
    }
    var audioPlayer: AVAudioPlayer?
    let gradientLayer:CAGradientLayer = CAGradientLayer()
    
    var slides : [storySlide] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        startBackgroundMusic(bgmFIleName: "Sad")
        let happinessLevel = UIProgressView(frame: CGRect(x: 30.0, y: 30.0, width: 300, height: 10))
        happinessLevelProgress = happinessLevel
        happinessLevelProgress.transform = CGAffineTransform(scaleX: 1.0, y: 5.0)
        happinessLevelProgress.progressTintColor = .red
        
        
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        collectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
        nextBtn.titleLabel?.font = UIFont(name: "SF-Pro-Display-Black.otf", size: 9)
        gradientViewEnd.gradientBackground(from: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), to: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), direction: .topToBottom)
        slides = [storySlide(memojiImage: #imageLiteral(resourceName: "celebration-2"), story: "CONGRATULATIONS on becoming a successful trader") ,
                  storySlide(memojiImage: #imageLiteral(resourceName: "dropp"), story: "But why is your happiness level dropping ?"),
                  storySlide(memojiImage: #imageLiteral(resourceName: "kolo"), story: "This called Arrival Fallacy an illusion that makes us think if we reach our goal we will reach lasting happiness") ,
                  storySlide(memojiImage: #imageLiteral(resourceName: "kolo"), story: "But you want to be happy right? What should i do to bring back my happiness?") ,
                  storySlide(memojiImage: #imageLiteral(resourceName: "welcome1"), story: "What would you do if you are failed to become a trader?") ,
                  storySlide(memojiImage: #imageLiteral(resourceName: "kolo"), story: "It's hard to imagine right? The only way to think about it is to be thankful about everything") ,
                  storySlide(memojiImage: #imageLiteral(resourceName: "happinessback"), story: "Wow your happiness level is increasing just by you practice gratitude ?") ,
                  storySlide(memojiImage: #imageLiteral(resourceName: "realize"), story: "Now you learn that achieving something doesn't necessarily deliver happiness ") ,
                  storySlide(memojiImage: #imageLiteral(resourceName: "realize"), story: "But think about something that you should be thankful is "),
                  storySlide(memojiImage: UIImage(imageLiteralResourceName: "coba"), story: "Last, having  multiple simultaneous goal can be helpful too "),
                  storySlide(memojiImage: #imageLiteral(resourceName: "welcome"), story: "Thank you for the experience hope you always happy with what you are doing ")
        ]
        // Do any additional setup after loading the view.
//        startBackgroundMusic(bgmFIleName: "welcomesong")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //Call Function for moving the clouds
        moveIt(cloud1end, 7.0)
        moveIt(cloud2end, 5.0)
        moveIt(cloud3end, 3.0)
    }

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let newVC = segue.destination as? GoalsPickViewController else { return }
//        newVC.audioPlayer2 = audioPlayer
//    }
//
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



extension EndStoryViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EndStoryCollectionViewCell.identifier, for: indexPath) as! EndStoryCollectionViewCell
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
        if currentPage == 1 {
                progressDeacrease.setProgress(0.2, animated: false)
            }
        if currentPage == slides.count - 1 {
//            stopBackgroundMusic()
//            stopBackgroundMusic()
//           performSegue(withIdentifier: "gotoGoals", sender: sender)
            print("dah diujung")
            audioPlayer?.stop()
            performSegue(withIdentifier: "backtonewGame", sender: sender)
            
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

   
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


