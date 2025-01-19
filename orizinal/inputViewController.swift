//
//  ViewController.swift
//  orizinal
//
//  Created by Haru Takenaka on 2023/08/02.
//

import UIKit
//import FSCalendar

class inputViewController: UIViewController{

  @IBOutlet var dayTextField: UITextField!
  var datePicker: UIDatePicker = UIDatePicker()


  override func viewDidLoad() {
    super.viewDidLoad()

    datePicker.datePickerMode = UIDatePicker.Mode.dateAndTime
    datePicker.timeZone = NSTimeZone.local
    datePicker.locale = Locale.current
    datePicker.preferredDatePickerStyle = .wheels
    dayTextField.inputView = datePicker

    let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
    let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
    let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(save))
    toolbar.setItems([spacelItem, doneItem], animated: true)

    // インプットビュー設定
    dayTextField.inputView = datePicker
    dayTextField.inputAccessoryView = toolbar
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    // tableView.reloadData()
  }
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
  }


  func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
    // 遷移先が、TopViewControllerだったら
    if viewController is tukiViewController {
      // TopViewControllerのプロパティvalueの値変更。
      //controller.titles = self.titles
    }
  }

//  @IBAction func done() {
//    dayTextField.endEditing(true)
//    let formatter = DateFormatter()
//    formatter.dateFormat = "yyyy-MM-dd a h:mm"
//
//    dayTextField.text = "\(formatter.string(from: Date()))"
//    UserDefaults.standard.set(datePicker.date, forKey: "selectedDate")
//    print("保存された日時: \(datePicker.date)")
//
//    save()
//
//  }
  //save
  @IBAction func save() {
    var dataAll: All

    let jsonData = UserDefaults.standard.object(forKey: "All")

    if jsonData == nil {
      dataAll = All(days:[])
    } else {
      let decoder = JSONDecoder()
      guard let Alls = try? decoder.decode(All.self, from: jsonData as! Data) else {
        fatalError("Failed to decode from JSON.")
      }
      dataAll = Alls
    }

    if dataAll.days.isEmpty {
      dataAll.days = [Day(date: Date(), events:[])]
    }
    // イベントを新しく作り、最初の日付(All.days[0])のeventsに追加する
    let event: Event = Event(content: TodoTextField.text ?? "", time: Date(), color: "red")
    dataAll.days[0].events.append(event)

    let encoder = JSONEncoder()
    guard let jsonValue = try? encoder.encode(dataAll) else {
      fatalError("Failed to encode to JSON.")
    }
    UserDefaults.standard.set(jsonValue, forKey: "All")
    print("Saved event: " + event.content)
  }

  @IBOutlet var TodoTextField: UITextField!
//  @IBAction func TodoaddButton(_ sender: Any) {
//
//    let TodoList = TodoTextField.text!
//    //TodoListにTodoTextFieldのtextを代入
//    print("hozon ga osareta")
//    print(TodoList)
//
//
//    Todoindividual = UserDefaults.standard.stringArray(forKey: "TodoList") ?? []
//    //TodoindividualにUserDefaults内のTodoListを代入
//    print("step 1: read todoList from UserDefaults")
//    print(Todoindividual)
//    print("step 2: todolist ni yotei wo tsuika")
//
//    Todoindividual.append(TodoList)
//    //todoindividual(UserDefaults) にtodolistを追加
//    print(Todoindividual)
//
//    UserDefaults.standard.set(Todoindividual, forKey: "TodoList")
//    //UserDefaultsにtodolistという名でTodoindividualを保存
//    print("Oboeta!!")
//
//    TodoTextField.endEditing(true)
//    dismiss(animated: true)
//
//  }

}



