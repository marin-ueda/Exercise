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
    //コードで画面遷移
    
    
    
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
    //腹筋ボタンを押したら、次の画面のラベルに腹筋！
    @IBAction func hukkin(_ sender: Any) {
        self.performSegue(withIdentifier: "toExercise", sender: nil)
    }
    @IBAction func neziri(_ sender: Any) {
        self.performSegue(withIdentifier: "toExercise", sender: nil)
    }
    @IBAction func takikan(_ sender: Any) {
        self.performSegue(withIdentifier: "toExercise", sender: nil)
    }
    @IBAction func sukuwatto(_ sender: Any) {
        self.performSegue(withIdentifier: "toExercise", sender: nil)
    }
    @IBAction func haikin(_ sender: Any) {
        self.performSegue(withIdentifier: "toExercise", sender: nil)
    }
    @IBAction func sonota(_ sender: Any) {
        self.performSegue(withIdentifier: "toExercise", sender: nil)
    }
   
    //Tagに番号をつけたことを宣言
/*    enum actionTag: Int {
        case action1 = 0
        case action2 = 1
        case action3 = 2
        case action4 = 3
        case action5 = 4
        case action6 = 5
    }
    func buttonAction(_ sender: Any) {
           let storyboard: UIStoryboard = self.storyboard!
           let second = storyboard.instantiateViewController(withIdentifier: "second")
           self.present(second, animated: true, completion: nil)
       }*/
    }

