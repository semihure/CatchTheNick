//
//  ViewController.swift
//  CatchTheNick
//
//  Created by smh on 4.09.2019.
//  Copyright © 2019 smh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    //Variables

    var score = 0
    var timer = Timer()
    var counter = 0
    var nickArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    
    
    //Views
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    
    
    @IBOutlet weak var nick1: UIImageView!
    @IBOutlet weak var nick2: UIImageView!
    @IBOutlet weak var nick3: UIImageView!
    @IBOutlet weak var nick4: UIImageView!
    @IBOutlet weak var nick5: UIImageView!
    @IBOutlet weak var nick6: UIImageView!
    @IBOutlet weak var nick7: UIImageView!
    @IBOutlet weak var nick8: UIImageView!
    @IBOutlet weak var nick9: UIImageView!
    @IBOutlet weak var nick10: UIImageView!
    @IBOutlet weak var nick11: UIImageView!
    @IBOutlet weak var nick12: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        scoreLabel.text = "Score: \(score)"
        
        //Highscore Check
        
        let storedHighscore = UserDefaults.standard.object(forKey: "highscore")
 
        if storedHighscore == nil {
            highScore = 0
            highScoreLabel.text = "Highscore: \(highScore) "
            
        }
        if let newScore = storedHighscore as? Int {
        highScore = newScore
            highScoreLabel.text = "Highscore: \(highScore)"
            
        }
        
        //Images
        
        nick1.isUserInteractionEnabled = true
        nick2.isUserInteractionEnabled = true
        nick3.isUserInteractionEnabled = true
        nick4.isUserInteractionEnabled = true
        nick5.isUserInteractionEnabled = true
        nick6.isUserInteractionEnabled = true
        nick7.isUserInteractionEnabled = true
        nick8.isUserInteractionEnabled = true
        nick9.isUserInteractionEnabled = true
        nick10.isUserInteractionEnabled = true
        nick11.isUserInteractionEnabled = true
        nick12.isUserInteractionEnabled = true
        
        
        let recognizer1 = UITapGestureRecognizer(target: self, action:#selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action:#selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action:#selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action:#selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action:#selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action:#selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action:#selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action:#selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action:#selector(increaseScore))
        let recognizer10 = UITapGestureRecognizer(target: self, action:#selector(increaseScore))
        let recognizer11 = UITapGestureRecognizer(target: self, action:#selector(increaseScore))
        let recognizer12 = UITapGestureRecognizer(target: self, action:#selector(increaseScore))
      
        nick1.addGestureRecognizer(recognizer1)
        nick2.addGestureRecognizer(recognizer2)
        nick3.addGestureRecognizer(recognizer3)
        nick4.addGestureRecognizer(recognizer4)
        nick5.addGestureRecognizer(recognizer5)
        nick6.addGestureRecognizer(recognizer6)
        nick7.addGestureRecognizer(recognizer7)
        nick8.addGestureRecognizer(recognizer8)
        nick9.addGestureRecognizer(recognizer9)
        nick10.addGestureRecognizer(recognizer10)
        nick11.addGestureRecognizer(recognizer11)
        nick12.addGestureRecognizer(recognizer12)
        
        
        nickArray = [nick1,nick2,nick3,nick4,nick5,nick6,nick7,nick8,nick9,nick10,nick11,nick12]
        
        //Timers
        counter = 10
        timeLabel.text = "\(counter)"
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        
        hideTimer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(hideNick), userInfo: nil, repeats: true)
        
        
        hideNick()
        
    }
    
    @objc func hideNick() {
        
        for nick in nickArray{
            
            nick.isHidden = true
            
            
        }
        
        let random = Int(arc4random_uniform(UInt32(nickArray.count - 1)))
        nickArray[random].isHidden = false
        
        
        
    }
    
    
    @objc func increaseScore() {
        
        score += 1
        scoreLabel.text = "Score \(score)"
    }
    
    @objc func countDown() {
        
        counter -= 1
        timeLabel.text = "\(counter)"
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            for nick in nickArray{
                
                nick.isHidden = true
            //Highscore
                if self.score > self.highScore{
                    self.highScore = self.score
                    highScoreLabel.text = "Highscore: \(self.highScore)"
                    UserDefaults.standard.set(self.highScore, forKey: "highscore")
                }
                
                
            
            //Alert
            
            let alert = UIAlertController(title: "Time's Up", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            
            let repayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                //replay func
                
                
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.hideNick), userInfo: nil, repeats: true)
                
            }
            
            alert.addAction(okButton)
            alert.addAction(repayButton)
            self.present(alert, animated: true, completion: nil)
            
            
        }
        
    }

}
}
