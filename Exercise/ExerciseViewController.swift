//
//  ExerciseViewController.swift
//  Exercise
//
//  Created by 植田真梨 on 2020/05/21.
//  Copyright © 2020 Ueda Maririn. All rights reserved.
//

import UIKit

class ExerciseViewController: UIViewController {
    

    
    //0531sender.tagで変数の受け渡し
    // ここにタップされたボタンのタグが送られてくる
    var tappedBtnTag: Int?

    
    
    //0601前ページからタイマーの数字持ってくる
    var arg: String = ""
//    var narg: Float = Float(arg)

    
    var menuString = ""

    @IBOutlet var menuLabel: UILabel!
    @IBOutlet weak var TimerLabel: UILabel!
    
    //0601 StringをFloatに変換

    

    var count: Float = 3
    //0602追加タイマー
    var count2: Float = 10.0

    
    var timer: Timer = Timer()
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //0601前ページからタイマーの数字持ってくる
        //引数をラベルにセット
        TimerLabel.text = arg
    
        
        //メニューラベルにメニュー名を表示させる動き
//        menuLabel.text = menuString
        
        //メニュー名を表示(Quizアプリ参照)
        var tmpArray = [Any]()
        
        //tmpArrayにメニュー名を格納しておく(Quizアプリ参照)
        tmpArray.append(["腹筋"])
        tmpArray.append(["ねじり"])
        tmpArray.append(["体幹"])
        tmpArray.append(["スクワット"])
        tmpArray.append(["背筋"])
        tmpArray.append(["その他"])
        
 //       choiceMenu()
        
        //0531sender.tagで変数の受け渡し
        // 取り合えすプリント、値が渡ってきていなければnil
           print("### tappedBtnTag:", tappedBtnTag as Any)
           menua()
        
        //0602自動的にスタート
           start()
           start2()
        
        //0になったら自動的にストップ
/*        if count == 0 {
           stop()
        }*/
     
        
    }
    func menua() {
        if tappedBtnTag == 1 {
            menuLabel.text = String("腹筋")
        } else if tappedBtnTag == 2 {
            menuLabel.text = String("ねじり")
        } else if tappedBtnTag == 3 {
            menuLabel.text = String("体幹")
        } else if tappedBtnTag == 4 {
            menuLabel.text = String("スクワット")
        } else if tappedBtnTag == 5 {
            menuLabel.text = String("背筋")
        } else if tappedBtnTag == 6 {
            menuLabel.text = String("その他のトレーニング")
        }
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func down() {
            //countを0.1を引く
        count = count - 0.1
            //ラベルに小数点以下1桁まで表示
            TimerLabel.text = String(format: "%.0f", count)
        if (count < 0.5) {
            TimerLabel.text = String("START")
            //タイマーが動作していたら停止する
//            timer.invalidate()
            self.down2()
        }
    }
    @objc func down2() {
            //countを0.1を引く
        count2 = count2 - 0.1
            //ラベルに小数点以下1桁まで表示
            TimerLabel.text = String(format: "%.1f", count2)
        self.textColor()
            
        if (count2 <= 0) {
            //タイマーが動作していたら停止する
            timer.invalidate()
            TimerLabel.font = TimerLabel.font.withSize(50)
            let argba = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
            TimerLabel.textColor = argba
            
            TimerLabel.text = String("Nice Fight!!")
        }
    }
    func start() {
        if !timer.isValid {
            //タイマーが動作していなかったら動かす
            timer = Timer.scheduledTimer(timeInterval: 0.1,
                                         target: self,
                                         selector: #selector(self.down),
                                         userInfo: nil,
                                         repeats: true)
        }
    }
    func start2() {
        if !timer.isValid {
            //タイマーが動作していなかったら動かす
            timer = Timer.scheduledTimer(timeInterval: 0.1,
                                         target: self,
                                         selector: #selector(self.down2),
                                         userInfo: nil,
                                         repeats: true)
        }
    }
/*    func stop() {
        if timer.isValid {
            //タイマーが動作していたら停止する
            timer.invalidate()
        }
    }*/
    
    
    //完了ボタンでトップページに戻る
    @IBAction func modoru() {
        self.dismiss(animated: true, completion: nil)
    }
    
    //0603タイマーの色を秒数によって変える
    func textColor() {
        if count2 < 3.9 {
            let rgba = UIColor(red: 1.0, green: 0.1, blue: 0.1, alpha: 1.0)
            TimerLabel.textColor = rgba
            TimerLabel.font = TimerLabel.font.withSize(120)
        } else {
            let argba = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
            TimerLabel.textColor = argba
            TimerLabel.font = TimerLabel.font.withSize(80)
        }
        TimerLabel.text = String(count2)
        TimerLabel.text = String(format: "%.1f", count2)
    }
    //0603もう一度ボタン入れたい
    @IBAction func retry() {
        self.start()
        self.start2()
    }
/*    //メニュー名表示
       func choiceMenu() {
        
      //メニュー名を表示(Quizアプリ参照)
        var tmpArray = sender.tag[] {
            
            if menuArray == 1 {
                   menuLabel.text = "腹筋"
            }
            if menuArray == 2 {
                   menuLabel.text = "ねじり"
            }
            if menuArray == 3 {
                   menuLabel.text = "体幹"
            }
            if menuArray == 4  {
                   menuLabel.text = "スクワット"
            }
            if menuArray == 5 {
                   menuLabel.text = "背筋"
            }
            if menuArray == 6 {
                   menuLabel.text = "その他"
               }
           }
    func choiceAnswer(sender: UIButton) {
        
    }
    }*/
    
    
    
}



