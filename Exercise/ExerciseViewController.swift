//
//  ExerciseViewController.swift
//  Exercise
//
//  Created by 植田真梨 on 2020/05/21.
//  Copyright © 2020 Ueda Maririn. All rights reserved.
//

import UIKit

class ExerciseViewController: UIViewController {
    //前ページからタイマーの数字持ってくる
    var argString = ""

    @IBOutlet var menu: UILabel!
    @IBOutlet weak var TimerLabel: UILabel!

    var count: Float = 0.0
    
    var timer: Timer = Timer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //前ページからタイマーの数字持ってくる
        //引数をラベルにセット
        TimerLabel.text = argString
        
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
        

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
