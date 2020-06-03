//
//  ViewController.swift
//  Exercise
//
//  Created by 植田真梨 on 2020/05/20.
//  Copyright © 2020 Ueda Maririn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //0601前ページからタイマーの数字持ってくる
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

    //0531sender.tagで変数を作る
    // ボタンタップしてタグを取得、遷移する
    @IBAction func hukkin(_ sender: UIButton) {
        let tagNumber = sender.tag
        // タグをsenderでprepareに送る
        self.performSegue(withIdentifier: "toExercise", sender: tagNumber)
    }
    @IBAction func neziri(_ sender: UIButton) {
        let tagNumber = sender.tag
        // タグをsenderでprepareに送る
        self.performSegue(withIdentifier: "toExercise", sender: tagNumber)
    }
    @IBAction func takikan(_ sender: UIButton) {
        let tagNumber = sender.tag
        // タグをsenderでprepareに送る
        self.performSegue(withIdentifier: "toExercise", sender: tagNumber)
    }
    @IBAction func sukuwatto(_ sender: UIButton) {
        let tagNumber = sender.tag
        // タグをsenderでprepareに送る
        self.performSegue(withIdentifier: "toExercise", sender: tagNumber)
    }
    @IBAction func haikin(_ sender: UIButton) {
        let tagNumber = sender.tag
        // タグをsenderでprepareに送る
        self.performSegue(withIdentifier: "toExercise", sender: tagNumber)
    }
    @IBAction func sonota(_ sender: UIButton) {
        let tagNumber = sender.tag
        // タグをsenderでprepareに送る
        self.performSegue(withIdentifier: "toExercise", sender: tagNumber)
    }

      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

          if segue.identifier == "toExercise" {
              // 遷移先VCを取得して
              if let ExcerciseVC = segue.destination as? ExerciseViewController {
                  //遷移先VCのプロパティにアクセス、senderで送られてきたタグをIntに変換して渡す
                  ExcerciseVC.tappedBtnTag = sender as? Int
                
            
            //0601前ページからタイマーの数字持ってくる
            //遷移先のViewControllerの取得
            let nextView = segue.destination as! ExerciseViewController
            //値の設定
            nextView.arg = textField1.text!
              }
          }
      }
    
    
    

    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    //腹筋ボタンを押したら、次の画面のラベルに腹筋！
/*    @IBAction func hukkin(_ sender: Any) {
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
    }*/

   

    }
/*//Tagに番号をつけたことを宣言
   enum actionTag: Int {
       case action1 = 1
       case action2 = 2
       case action3 = 3
       case action4 = 4
       case action5 = 5
       case action6 = 6
   }*/
