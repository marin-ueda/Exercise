//
//  ExerciseViewController.swift
//  Exercise
//
//  Created by 植田真梨 on 2020/05/21.
//  Copyright © 2020 Ueda Maririn. All rights reserved.
//

import UIKit
import RealmSwift
import AVFoundation

class ExerciseViewController: UIViewController, AVAudioPlayerDelegate {
    
    //0613 音楽入れる
    var audioPlayer:AVAudioPlayer!
    
    //0608Realm入れてみる
    let realm = try! Realm()
    
    //0610new 日付をRealmに
    let dt = Date()
    let dateFormatter = DateFormatter()
    
    //0531sender.tagで変数の受け渡し
    // ここにタップされたボタンのタグが送られてくる
    var tappedBtnTag: Int?
    
    //0601前ページからタイマーの数字持ってくる
    var arg = ""
    //0606 argを小数として使うために
    var narg: Double!
    
    
    var menuString = ""
    
    @IBOutlet var menuLabel: UILabel!
    @IBOutlet weak var TimerLabel: UILabel!
    
    var count: Double = 3
    var timer: Timer = Timer()
    
    //0609日付情報取得
    // 現在日時を取得
    /*    let dt = Date()
     let formatter: DateFormatter = DateFormatter()*/
    
    //0610 日付リベンジ！
    /*    lazy var dateFormatter: DateFormatter = {
     var formatter = DateFormatter()
     formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "ydMMM",
     options: 0,
     locale: Locale(identifier: "ja_JP"))
     formatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
     return formatter
     }()*/
    
    
    
    //0608Realmを入れてみる(変えるのはここか？？日付入れる、合計秒数にする）
    func addKiroku() {
        let newkiroku = Kiroku()
        newkiroku.seconds = narg!
        //0610new 日付をRealmに
        // DateFormatter を使用して書式とロケールを指定する
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yMMMd", options: 0, locale: Locale(identifier: "ja_JP"))
        //        print(dateFormatter.string(from: dt))
        newkiroku.hiniti = dateFormatter.string(from: dt)
        
        //0612もし日付が同じだったら、秒数のところだけを更新
        //0612 オブジェクトの取得
        let kaburi = NSPredicate(format: "hiniti == %@", dateFormatter.string(from: dt))
        let results = realm.objects(Kiroku.self).filter(kaburi)
        
        //0612 日にちがかぶっていたら
        if let newkiroku = results.first {  //PCは何個かのデータが入っているとみなしているから、一番最初のデータという設定をする必要あり。
            try! realm.write() {
                newkiroku.seconds = narg + newkiroku.seconds
            }
        } else {
            try! realm.write {
                realm.add(newkiroku/*, update: .all*/)
            }
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //0613 音入れる
        // 再生する audio ファイルのパスを取得
        let audioPath = Bundle.main.path(forResource: "sound36", ofType:"mp3")!
        let audioUrl = URL(fileURLWithPath: audioPath)
        // auido を再生するプレイヤーを作成する
        var audioError:NSError?
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioUrl)
        } catch let error as NSError {
            audioError = error
            audioPlayer = nil
        }
        
        // エラーが起きたとき
        if let error = audioError {
            print("Error \(error.localizedDescription)")
        }
        
        audioPlayer.delegate = self
        audioPlayer.prepareToPlay()
        
        //0601前ページからタイマーの数字持ってくる
        //引数をラベルにセット
        TimerLabel.text = arg
        //0606　argを小数型に変換
        narg = Double(arg)
        
        //0608Realm入れてみる
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        
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
            //            TimerLabel.text = String("START")
            //タイマーが動作していたら停止する
            //            timer.invalidate()
            self.down2()
            
        }
    }
    @objc func down2() {
        //countを0.1を引く
        narg = narg - 0.1
        //ラベルに小数点以下1桁まで表示
        TimerLabel.text = String(format: "%.1f", narg)
        self.textColor()
        
        if (narg <= 0) {
            //タイマーが動作していたら停止する
            timer.invalidate()
            TimerLabel.font = TimerLabel.font.withSize(50)
            let argba = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
            TimerLabel.textColor = argba
            TimerLabel.text = String("Nice Fight!!")
            count = 3
            narg = Double(arg)
            addKiroku()
            audioPlayer.play()
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
    //完了ボタンでトップページに戻る
    @IBAction func modoru() {
        self.dismiss(animated: true, completion: nil)
    }
    
    //0603タイマーの色を秒数によって変える
    func textColor() {
        if narg < 3.9 {
            let rgba = UIColor(red: 1.0, green: 0.1, blue: 0.1, alpha: 1.0)
            TimerLabel.textColor = rgba
            TimerLabel.font = TimerLabel.font.withSize(130)
        } else {
            let argba = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
            TimerLabel.textColor = argba
            TimerLabel.font = TimerLabel.font.withSize(100)
        }
        TimerLabel.text = String(narg)
        TimerLabel.text = String(format: "%.1f", narg)
    }
    //0603もう一度ボタン入れたい
    @IBAction func retry() {
        self.start()
        self.down()
        
    }
    
    
    
    
}



