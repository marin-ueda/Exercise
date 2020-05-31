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

    
    
    //前ページからタイマーの数字持ってくる
    var argString = ""
    var menuString = ""

    @IBOutlet var menuLabel: UILabel!
    @IBOutlet weak var TimerLabel: UILabel!

    var count: Float = 0.0
    
    var timer: Timer = Timer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //前ページからタイマーの数字持ってくる
        //引数をラベルにセット
        TimerLabel.text = argString
        
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

        
    }
    func menua() {
        if tappedBtnTag == 1 {
            menuLabel.text = String("腹筋")
        }
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func up() {
        //countを0.01足す
        count = count + 0.01
        //ラベルに小数点以下2桁まで表示
        TimerLabel.text = String(format: "%.2f", count)
    }
    
    @IBAction func start() {
        if !timer.isValid {
            //タイマーが動作していなかったら動かす
            timer = Timer.scheduledTimer(timeInterval: 0.01,
                                         target: self,
                                         selector: #selector(self.up),
                                         userInfo: nil,
                                         repeats: true
            )
        }
    }
    @IBAction func stop() {
        if timer.isValid {
            //タイマーが動作していたら停止する
            timer.invalidate()
        }
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.*/



