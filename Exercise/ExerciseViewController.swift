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
    

    
    //0614 メッセージ入れる
    @IBOutlet var image: UIImageView!
    @IBOutlet var hukidasi: UIImageView!
    @IBOutlet var serihuLabel: UILabel!
    
    //0613 音楽入れる
    var audioPlayer:AVAudioPlayer!
//    var audioPlayer2:AVAudioPlayer!
    
    //0608Realm入れてみる
    let realm = try! Realm()
    
    let kiroku = try! Realm().objects(Kiroku.self).sorted(byKeyPath: "hiniti")
    var notificationToken: NotificationToken?
    
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
    

    
    //0608Realmを入れてみる(変えるのはここか？？日付入れる、合計秒数にする）
    func addKiroku() {
        let newkiroku = Kiroku()
        newkiroku.seconds = narg!

        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "ja_JP")

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
                realm.add(newkiroku)
            }
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        UserDefaults.standard.set(now_day, forKey: "date")
        //0608Realm入れてみる
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        //0613　改：Realmの更新があったらすぐに反映
        notificationToken = kiroku.observe { [weak self] _ in
            self?.Point()
        }
        //0613 音入れる
        // 再生する audio ファイルのパスを取得
        let audioPath = Bundle.main.path(forResource: "sound36", ofType:"mp3")!
        let audioUrl = URL(fileURLWithPath: audioPath)
//        let audioPath2 = Bundle.main.path(forResource: "sound09", ofType:"mp3")!
//        let audioUrl2 = URL(fileURLWithPath: audioPath2)
        // auido を再生するプレイヤーを作成する
        var audioError:NSError?
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioUrl)
        } catch let error as NSError {
            audioError = error
            audioPlayer = nil
        }
        
/*        var audioError2:NSError?
        do {
            audioPlayer2 = try AVAudioPlayer(contentsOf: audioUrl2)
        } catch let error as NSError {
            audioError2 = error
            audioPlayer2 = nil
        }*/
        
        // エラーが起きたとき
        if let error = audioError {
            print("Error \(error.localizedDescription)")
        }
        // エラーが起きたとき2
/*        if let error2 = audioError2 {
            print("Error \(error2.localizedDescription)")
        }*/
        
        audioPlayer.delegate = self
        audioPlayer.prepareToPlay()
//        audioPlayer2.delegate = self
//        audioPlayer2.prepareToPlay()
        
        //0601前ページからタイマーの数字持ってくる
        //引数をラベルにセット
        TimerLabel.text = arg
        //0606　argを小数型に変換
        narg = Double(arg)
        

        
        
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
        Point()
        
//        messege()
    }
    
    func menua() {
        if tappedBtnTag == 1 {
            menuLabel.text = String("腹筋")
        } else if tappedBtnTag == 2 {
            menuLabel.text = String("背筋")
        } else if tappedBtnTag == 3 {
            menuLabel.text = String("足パカ")
        } else if tappedBtnTag == 4 {
            menuLabel.text = String("スクワット")
        } else if tappedBtnTag == 5 {
            menuLabel.text = String("体幹")
        } else if tappedBtnTag == 6 {
            menuLabel.text = String("ストレッチ")
        }
    }
    //0616
    func Point() {
        let point = realm.objects(Kiroku.self)
        let summ: Int = point.sum(ofProperty: "seconds")
        let img1 = UIImage(named:"zou.png")
        let img2 = UIImage(named: "cat.png")
        let img3 = UIImage(named: "buta.png")
        let img4 = UIImage(named: "cat_green.png")
        let img5 = UIImage(named: "penpen.png")
        let img6 = UIImage(named: "tako.png")
        let img7 = UIImage(named: "kuzira.png")

        let serihu:[String] = ["その調子！その調子！", "頑張れ〜!", "ファイトー！", "筋肉意識してね。", "呼吸大事だよ！", "息吸ってーはいてー", "肩の力抜いて！", "運動している君は偉い！", "毎日頑張ろう！", "明日もっと美しく！", "ナイスファイト", "もっといける！", "続ける事が大事！", "コツコツ頑張ろう！", "憧れに近づいてるよ！", "やればできる！", "目指せ10000ポイント！"]


        if summ >= 20000 && summ < 30000 {
            let ii:[UIImage?] = [img1, img2, img3, img4, img5, img6, img7]
            view.backgroundColor = UIColor.init(red: 255/255, green: 249/255, blue: 128/255, alpha: 1)
            let nu = arc4random_uniform(UInt32(ii.count))
            image.image = ii[Int(nu)]

        } else if summ >= 10000 {
            let iii:[UIImage?] = [img4, img6, img3]
            view.backgroundColor = UIColor.init(red: 227/255, green: 219/255, blue: 255/255, alpha: 1)
            let nu = arc4random_uniform(UInt32(iii.count))
            image.image = iii[Int(nu)]
        } else {
            let iiii:[UIImage?] = [img1]
            view.backgroundColor = UIColor.init(red: 194/255, green: 247/255, blue: 159/255, alpha: 1)
            let nu = arc4random_uniform(UInt32(iiii.count))
            image.image = iiii[Int(nu)]
        }

        let num = arc4random_uniform(UInt32(serihu.count))
        serihuLabel.text = serihu[Int(num)]

    }

    
    func nonmessege() {
        serihuLabel.text = ""
        hukidasi.image = nil
        image.image = nil
    }
    
        //0614 メッセージ入れる
    /*    func messege() {
            let serihu:[String] = ["その調子！その調子！", "頑張れ〜!", "ファイトー！", "筋肉意識してね。", "呼吸大事だよ！", "息吸ってーはいてー", "肩の力抜いて！", "運動している君は偉い！", "毎日頑張ろう！", "明日もっと美しく！", "ナイスファイト", "もっといける！", "続ける事が大事！", "コツコツ頑張ろう！", "憧れに近づいてるよ！", "やればできる！"]
            let nu = arc4random_uniform(UInt32(serihu.count))

            serihuLabel.text = serihu[Int(nu)]
        }*/
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func down() {
        //countを0.1を引く
        count = count - 0.1
        //ラベルに小数点以下1桁まで表示
        TimerLabel.text = String(format: "%.0f", count)
        if count < 0.5 {
//            audioPlayer2.play()
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
            TimerLabel.font = TimerLabel.font.withSize(52)
            let argba = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
            TimerLabel.textColor = argba
            TimerLabel.text = String("Nice Fight!!")
            count = 3
            narg = Double(arg)
            addKiroku()
            audioPlayer.play()
            nonmessege()

//            saveData.set(now_day, forKey: "date")
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
        if timer.isValid {
            timer.invalidate()
            count = 3
            narg = Double(arg)
        }
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



