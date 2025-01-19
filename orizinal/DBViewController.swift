//
//  DBViewController.swift
//  orizinal
//
//  Created by Haru Takenaka on 2024/12/15.
//

import UIKit

class DBViewController: UIViewController {


  @IBOutlet var contentInput: UITextField!
  @IBOutlet var resultText: UITextView!

  var result: Event = Event(content: "", strTime: Date(), endTime: Date(), color: "")

    override func viewDidLoad() {
        super.viewDidLoad()
        //load()
      // Do any additional setup after loading the view.
    }


  @IBAction func save() {
    var hall : All
    //保存
//    var hdays : [Day]
//    var hevents : [Event]

    let jsonData = UserDefaults.standard.object(forKey: "hall")

    if jsonData == nil {
      hall = All(days:[])
    } else {
      let decoder = JSONDecoder()
      guard let halls = try? decoder.decode(All.self, from: jsonData as! Data) else {
        fatalError("Failed to decode from JSON.")
      }
      hall = halls
    }


    if hall.days.isEmpty {
      hall.days = [Day(date: Date(), events:[])]
    }

    // イベントを新しく作り、最初の日付(hall.days[0])のeventsに追加する
    let hevent: Event = Event(content: contentInput.text ?? "", strTime: Date(), endTime: Date(),  color: "red")
    hall.days[0].events.append(hevent)

    let encoder = JSONEncoder()
    guard let jsonValue = try? encoder.encode(hall) else {
        fatalError("Failed to encode to JSON.")
    }
    UserDefaults.standard.set(jsonValue, forKey: "hall")
    resultText.text = "Saved event: " + hevent.content

  }



  @IBAction func load() {
    //表示
    let jsonData = UserDefaults.standard.object(forKey: "hall")

    if jsonData == nil {
      resultText.text = "No Data"
    } else {
      let decoder = JSONDecoder()
      guard let hall: All = try? decoder.decode(All.self, from: jsonData as! Data) else {
        fatalError("Failed to decode from JSON.")
      }

      let hday = hall.days[0]
      let hevents : [Event] = hday.events
      resultText.text = "content: "
      for hevent in hevents {
        resultText.text += hevent.content + ","
      }
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

// 遙がやりたいのは
// days のなかに目的の日付があるか探す
// ある場合はその日付のDayをhday に入れる
// ない場合はその日付のDayを新しく作って hday に入れる
// hallの中のdaysに何も日付のデータがなければ、
// 新しく日付のデータを作り hall の最初の日付に登録する。
