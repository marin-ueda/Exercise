//
//  ExerciseViewController.swift
//  Exercise
//
//  Created by 植田真梨 on 2020/05/21.
//  Copyright © 2020 Ueda Maririn. All rights reserved.
//

import UIKit

class ExerciseViewController: UIViewController {
    
    var timerObj: Timer?
    var counter = 0
    @IBOutlet var TimerLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        func startTimer(_ sender: Any) {
            if timerObj == nil {
                timerObj = Timer.scheduledTimer (
                timeInterval: TimeInterval(1),
                target: self,
                selector: #selecter(ViewController.timerActionRepeat),
                userInfo: nil
                repeats: true)
            }
        }
        func timerActionRepeat() {
            TimerLabel.text = String(repeating: "niko", count: counter)
            counter += 1
        }
        
        func stopTimer(_ sender: Any) {
            if timerObj != nil {
                timerObj?.invalidate()
                timerObj = nil
                TimerLabel.text = "Nice Fight!!"
                counter = 0
            }
        }

    
//    @IBAction func restart() {
        
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
