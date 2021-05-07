//
//  GoalsPickViewController.swift
//  gameBitcoin
//
//  Created by Aditya Ramadhan on 04/05/21.
//

import UIKit
import AVFoundation

class GoalsPickViewController: UIViewController {

    @IBOutlet weak var gradientgoal: UIView!
    @IBOutlet weak var cloud1goal: UIImageView!
    @IBOutlet weak var cloud2goal: UIImageView!
    @IBOutlet weak var cloud3goal: UIImageView!
    @IBOutlet weak var goalsLabel: UILabel!
    @IBOutlet weak var btnPickGoal: UIButton!
    var audioPlayer2: AVAudioPlayer?
    override func viewDidLoad() {
        super.viewDidLoad()
        goalsLabel.textColor = #colorLiteral(red: 0.1315995455, green: 0.1316291094, blue: 0.131595701, alpha: 1)
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        gradientgoal.gradientBackground(from: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), to: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), direction: .topToBottom)
        moveIt(cloud1goal, 7.0)
        moveIt(cloud2goal, 5.0)
        moveIt(cloud3goal, 3.0)
        btnPickGoal.setTitle("CryptoTrader", for: .normal)
        goalsLabel.text = "Pick your Goals"
        self.navigationController?.setNavigationBarHidden(true, animated: false)

        // Do any additional setup after loading the view.
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
    
    @IBAction func gotogame(_ sender: UIButton) {
        performSegue(withIdentifier: "gotoGame", sender: sender)
        audioPlayer2?.stop()
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let controller = storyboard.instantiateViewController(identifier: "gameStoryboard") as! UINavigationController
////            self.navigationController?.pushViewController(controller, animated: true)
//        controller.modalPresentationStyle = .fullScreen
//        controller.modalTransitionStyle = .crossDissolve
//        present(controller, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}
