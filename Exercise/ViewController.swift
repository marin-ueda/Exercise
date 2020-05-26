//
//  ViewController.swift
//  Exercise
//
//  Created by 植田真梨 on 2020/05/20.
//  Copyright © 2020 Ueda Maririn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //前ページからタイマーの数字持ってくる
    @IBOutlet weak var textField1: UITextField!
    
    @IBAction func KirokuButtonTapped() {
        let saveData = UserDefaults.standard
        if saveData.array(forKey: "WORD") != nil{
            if saveData.array(forKey: "WORD")!.count > 0 {
                performSegue(withIdentifier: "toKirokuTableView", sender: nil)
            }
            
        } else {
            let alert = UIAlertController(
                title: "記録",
                message: "トレーニングが終了すると、見ることができます",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(
                title: "OK!",
                style: .default,
                handler: nil
            ))
            
            self.present(alert, animated: true, completion: nil)
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    //前ページからタイマーの数字持ってくる
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toExerciseView" {
            let nextView = segue.destination as! ExerciseViewController
            nextView.argString = textField1.text!
        }
    }


}

