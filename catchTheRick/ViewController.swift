//
//  ViewController.swift
//  catchTheRick
//
//  Created by Fahriye Zeynep Çakır on 22.08.2022.
//

import UIKit

class ViewController: UIViewController {
    
    //Variables
    var score = 0
    var timer = Timer()
    var counter = 0
    var rickArray = [UIImageView]()
    var hideTimer = Timer()
    var hisghScore = 0
    
    //Views
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var rick1: UIImageView!
    @IBOutlet weak var rick2: UIImageView!
    @IBOutlet weak var rick3: UIImageView!
    @IBOutlet weak var rick4: UIImageView!
    @IBOutlet weak var rick5: UIImageView!
    @IBOutlet weak var rick6: UIImageView!
    @IBOutlet weak var rick7: UIImageView!
    @IBOutlet weak var rick8: UIImageView!
    @IBOutlet weak var rick9: UIImageView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "Score : \(score)"
        
        //HighScore check
            let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
            
            if storedHighScore == nil {
                hisghScore = 0
                highScoreLabel.text = "HighScore : \(hisghScore)"
            }
            
            if let newScore = storedHighScore as? Int{
                hisghScore = newScore
                highScoreLabel.text = "Highscore : \(hisghScore)"
            }
        //kullanıcıların rick'in üstüne tıklamasını etkin hale getiriyoruz
        
        rick1.isUserInteractionEnabled = true
        rick2.isUserInteractionEnabled = true
        rick3.isUserInteractionEnabled = true
        rick4.isUserInteractionEnabled = true
        rick5.isUserInteractionEnabled = true
        rick6.isUserInteractionEnabled = true
        rick7.isUserInteractionEnabled = true
        rick8.isUserInteractionEnabled = true
        rick9.isUserInteractionEnabled = true
        
        rickArray=[rick1,rick2,rick3,rick4,rick5,rick6,rick7,rick8,rick9]
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
            let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
            let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
            let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
            let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
            let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
            let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
            let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
            let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))

            rick1.addGestureRecognizer(recognizer1)
            rick2.addGestureRecognizer(recognizer2)
            rick3.addGestureRecognizer(recognizer3)
            rick4.addGestureRecognizer(recognizer4)
            rick5.addGestureRecognizer(recognizer5)
            rick6.addGestureRecognizer(recognizer6)
            rick7.addGestureRecognizer(recognizer7)
            rick8.addGestureRecognizer(recognizer8)
            rick9.addGestureRecognizer(recognizer9)
        
        //Timers
              
              counter = 10
              //timeLabel bizden string istiyor counter'ı direkt stringe çevirdim diğer bir yazım String(counter)
              timeLabel.text = "\(counter)"
              timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
              hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideRick), userInfo: nil, repeats: true)
              hideRick()
              
          }
          //rick in görsellerini random bir şekilde ekranda göstermek için
          @objc func hideRick(){
              for rick in rickArray{
                  rick.isHidden = true
              }
              let random = Int(arc4random_uniform(UInt32(rickArray.count - 1)))
              rickArray[random].isHidden = false
          }
          //geri sayım
          @objc func countDown(){
              counter -= 1
              timeLabel.text = String(counter)
              
              if counter == 0{
                  timer.invalidate() //timer' ı durdurmak için
                  hideTimer.invalidate()
                  
                  for rick in rickArray{       //zaman dolduktan sonra bütün rick görsellerini tekrar görünmez yapmak için
                      rick.isHidden = true
                  }
                  
                  //HighScore userdefaults kullanarak en yüksek scoru ekranda gösterdik
                  if self.score > self.hisghScore {
                      self.hisghScore = self.score
                      highScoreLabel.text = "Highscore : \(self.hisghScore)"
                      UserDefaults.standard.set(self.hisghScore, forKey: "highscore")
                  }
                  
                  
                  
                  //Alert
                  let alert = UIAlertController(title: "Süren Doldu", message:"Tekrar Oynamak İster Misin ?" , preferredStyle: UIAlertController.Style.alert)
                  let okButton = UIAlertAction(title:"Tamam", style: UIAlertAction.Style.cancel, handler: nil)
                  let replayButton = UIAlertAction(title: "Yeniden Başla", style:UIAlertAction.Style.default) {
                      (UIAlertAction) in
                      self.score = 0
                      self.scoreLabel.text = "Score : \(self.score)"
                      self.counter = 10
                      self.timeLabel.text = String(self.counter)
                      self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo:nil, repeats: true)
                      self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideRick), userInfo: nil, repeats: true)
                      
                      
                  }
                  alert.addAction(okButton)
                  alert.addAction(replayButton)
                  self.present(alert, animated: true, completion: nil)
              }
          }
          
          //score arttırmak için
          @objc func increaseScore(){
              
              score += 1
              scoreLabel.text = "Score :\(score)"
              //viewdidload uygulama açıldığında bir defa çalışır. Scoru arttırdıktan sonra tekrar yazdırıyoruz ki   kullanıcı görebilsin
          }
      }


