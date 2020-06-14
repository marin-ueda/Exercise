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
    
    @IBOutlet var pointLabel: UILabel!
    @IBOutlet var nissuLabel: UILabel!
    @IBOutlet var pointhaikei: UILabel!
    
    //0613 再：日付をRealmに
    let dt = Date()
    let dateFormatter = DateFormatter()
    
    //合計日数のための関数
    var hi: Int = 0
  
    //0608Realm入れてみる
    let realm = try! Realm()
    let kiroku = try! Realm().objects(Kiroku.self).sorted(byKeyPath: "hiniti")
    var notificationToken: NotificationToken?
    
    //0613 ボタンの角を丸くする
    @IBOutlet weak var hukkin: UIButton!
    @IBOutlet weak var neziri: UIButton!
    @IBOutlet weak var sukuwatto: UIButton!
    @IBOutlet weak var taikan: UIButton!
    @IBOutlet weak var sonota: UIButton!
    @IBOutlet weak var haikin: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //0608Realm入れてみる
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        //0613　改：Realmの更新があったらすぐに反映
        notificationToken = kiroku.observe { [weak self] _ in
        self?.Points()
            
        //0613 ボタンの角を丸くする
        self?.hukkin.layer.cornerRadius = 12.0
        self?.neziri.layer.cornerRadius = 12.0
        self?.sukuwatto.layer.cornerRadius = 12.0
        self?.taikan.layer.cornerRadius = 12.0
        self?.sonota.layer.cornerRadius = 12.0
        self?.haikin.layer.cornerRadius = 12.0
        self?.nissuLabel.layer.cornerRadius = 10.0
        self?.pointhaikei.layer.cornerRadius = 10.0
            //外枠の色を指定
/*            self?.hukkin.layer.borderColor = UIColor.cyan.cgColor
            self?.neziri.layer.borderColor = UIColor.cyan.cgColor
            self?.sukuwatto.layer.borderColor = UIColor.cyan.cgColor
            self?.taikan.layer.borderColor = UIColor.cyan.cgColor
            self?.haikin.layer.borderColor = UIColor.cyan.cgColor
            self?.sonota.layer.borderColor = UIColor.cyan.cgColor
             
            //外枠の太さを指定
            self?.hukkin.layer.borderWidth = 7.0
            self?.neziri.layer.borderWidth = 7.0
            self?.sukuwatto.layer.borderWidth = 7.0
            self?.taikan.layer.borderWidth = 7.0
            self?.haikin.layer.borderWidth = 7.0
            self?.sonota.layer.borderWidth = 7.0*/
        }
        
        //0613 ここ入れる！
        
        
        Points()
        goukei()
//        nissu()
    }
    

    //0613 キーボードをreturnで閉じる
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // キーボードを閉じる
        textField.resignFirstResponder()
        return true
    }
    
    //0613 point入れる！
    func Points() {
        let point = realm.objects(Kiroku.self)
        let summ: Int = point.sum(ofProperty: "seconds")
        pointLabel.text = String(summ)
    }
    //0613 合計日数
    func goukei() {
           let gou = realm.objects(Kiroku.self)
           let sum: Int = gou.count

            nissuLabel.text = String("Day \(sum)")

       }
    
/*    //0613 連続する日数を出す!!
    func nissu() {
//   let f = DateFormatter()
//    f.dateStyle = .medium
//    f.locale = Locale(identifier: "ja_JP")
    let now = Date()
//    print(f.string(from: now))
    
    var calendar = Calendar.current
    let day = calendar.component(.day, from: now)
    
    let components = calendar.dateComponents([.day],
                                                 from: fromDate,
                                                 to: now)
    let passTime = components.day!
        if passTime <= 1 {
            hi += 1
        } else {
            hi = 0
        }
        nissuLabel.text = String(hi)
        
    }*/
    
    @IBAction func KirokuButtonTapped() {
        _ = UserDefaults.standard
/*        //0610 日付
          let dateFormater = DateFormatter()
             dateFormater.locale = Locale(identifier: "ja_JP")
             dateFormater.dateFormat = "yyyy/MM/dd HH:mm:ss"
             let date = dateFormater.string(from: Date())
             print(date)     // 2017/04/04 10:44:31*/
        // Realmのオブジェクトを取得
        let kosuu = realm.objects(Kiroku.self)
        //0613 Realmに入っているデータの個数
//        print("kosuu.count: \(kosuu.count)")
        
        if kosuu.count != 0 {
            performSegue(withIdentifier: "toKirokuTableViewController", sender: nil)
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
    @IBAction func taikan(_ sender: UIButton) {
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

