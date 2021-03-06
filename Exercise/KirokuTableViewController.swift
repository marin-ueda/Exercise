//
//  KirokuTableViewController.swift
//  Exercise
//
//  Created by 植田真梨 on 2020/05/21.
//  Copyright © 2020 Ueda Maririn. All rights reserved.
//

import UIKit
import RealmSwift

class KirokuTableViewController: UITableViewController {
    let realm = try! Realm()

       let kiroku = try! Realm().objects(Kiroku.self).sorted(byKeyPath: "hiniti")
       var notificationToken: NotificationToken?
    

    
    //0609日付情報取得
    // 現在日時を取得
/*    let dt = Date()
    let formatter: DateFormatter = DateFormatter()*/


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        //Realmの更新があったらすぐに反映
        notificationToken = kiroku.observe { [weak self] _ in
        self?.tableView.reloadData()
        }
        
    }
    

 /*   //日付入れてみた
    func hiniti() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yMdkHms", options: 0, locale: Locale(identifier: "ja_JP"))


    }*/
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kiroku.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! KirokuTableViewCell
        cell.secondsLabel.text = String(Int(kiroku[indexPath.row].seconds))

        //0609日付入れてみた
        // ロケールをアメリカ（英語）に設定
/*        formatter.locale = Locale(identifier: "en_US")
        formatter.dateStyle = .short
        print(formatter.string(from: dt))*/
        
        cell.dateLabel.text = String(kiroku[indexPath.row].hiniti)
        return cell
    }
//    formatter.dateStyle = .medium



   

    
    @IBAction func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    

    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


