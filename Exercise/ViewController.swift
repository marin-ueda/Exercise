//
//  ViewController.swift
//  Exercise
//
//  Created by 植田真梨 on 2020/05/20.
//  Copyright © 2020 Ueda Maririn. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    //0601前ページからタイマーの数字持ってくる
    @IBOutlet weak var textField1: UITextField!
/*    //Datepiker入れてみた
    @IBOutlet var datePiker: UIDatePicker!*/
  

    
    //0608Realm入れてみる
    let realm = try! Realm()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //0608Realm入れてみる
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    
    @IBAction func KirokuButtonTapped() {
        _ = UserDefaults.standard
/*        //0610 日付
          let dateFormater = DateFormatter()
             dateFormater.locale = Locale(identifier: "ja_JP")
             dateFormater.dateFormat = "yyyy/MM/dd HH:mm:ss"
             let date = dateFormater.string(from: Date())
             print(date)     // 2017/04/04 10:44:31*/
        if kaisu != 0
        {
            if kaisu > 0 {
                performSegue(withIdentifier: "toKirokuTableViewController", sender: nil)
            }
        } else {
            let alert = UIAlertController(
                title: "",
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
    
    func alert() {
        let alert = UIAlertController(
            title: "アナウンス",
            message: "秒数を入力してください",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(
            title: "OK!",
            style: .default,
            handler: nil
        ))
        
        self.present(alert, animated: true, completion: nil)
    }

    //0531sender.tagで変数を作る
    // ボタンタップしてタグを取得、遷移する
    @IBAction func hukkin(_ sender: UIButton) {
        if textField1.text == nil || textField1.text == ""  {
            alert()
        } else {
        let tagNumber = sender.tag
        // タグをsenderでprepareに送る
        self.performSegue(withIdentifier: "toExercise", sender: tagNumber)
        }
    }
    @IBAction func neziri(_ sender: UIButton) {
        if textField1.text == nil || textField1.text == ""  {
            alert()
        } else {
        let tagNumber = sender.tag
        // タグをsenderでprepareに送る
        self.performSegue(withIdentifier: "toExercise", sender: tagNumber)
        }
    }
    @IBAction func takikan(_ sender: UIButton) {
     if textField1.text == nil || textField1.text == ""  {
            alert()
        } else {
        let tagNumber = sender.tag
        // タグをsenderでprepareに送る
        self.performSegue(withIdentifier: "toExercise", sender: tagNumber)
        }
    }
    @IBAction func sukuwatto(_ sender: UIButton) {
        if textField1.text == nil || textField1.text == ""  {
            alert()
        } else {
        let tagNumber = sender.tag
        // タグをsenderでprepareに送る
        self.performSegue(withIdentifier: "toExercise", sender: tagNumber)
        }
    }
    @IBAction func haikin(_ sender: UIButton) {
        if textField1.text == nil || textField1.text == ""  {
            alert()
        } else {
        let tagNumber = sender.tag
        // タグをsenderでprepareに送る
        self.performSegue(withIdentifier: "toExercise", sender: tagNumber)
        }
    }
    @IBAction func sonota(_ sender: UIButton) {
        if textField1.text == nil || textField1.text == ""  {
            alert()
        } else {
        let tagNumber = sender.tag
        // タグをsenderでprepareに送る
        self.performSegue(withIdentifier: "toExercise", sender: tagNumber)
        }
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

