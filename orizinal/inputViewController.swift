//
//  ViewController.swift
//  orizinal
//
//  Created by Haru Takenaka on 2023/08/02.
//

import UIKit
import FSCalendar

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
           let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
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

  @objc func done() {
    dayTextField.endEditing(true)
    // 日付のフォーマット
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd a h:mm"
    dayTextField.text = "\(formatter.string(from: Date()))"
    UserDefaults.standard.set(datePicker.date, forKey: "selectedDate")
        print("保存された日時: \(datePicker.date)")

  }
  @IBOutlet var TodoTextField: UITextField!
  var Todoindividual: [String] = []
  @IBAction func TodoaddButton(_ sender: Any) {

    let TodoList = TodoTextField.text!
    Todoindividual = UserDefaults.standard.stringArray(forKey: "TodoList") ?? []
    print(Todoindividual)
//    Todoindividual.append(todo)
//    UserDefaults.standard.set(Todoindividual, forKey: "TodoList")
//   TodoTextField.endEditing(true)
//    print(todo)
//    dismiss(animated: true)
 }




}


