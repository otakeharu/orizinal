//
//  tukiViewController.swift
//  orizinal
//
//  Created by Haru Takenaka on 2023/11/08.
//

import UIKit
import FSCalendar

class tukiViewController: UIViewController, UITableViewDelegate,UITableViewDataSource,FSCalendarDelegate,FSCalendarDataSource,FSCalendarDelegateAppearance{

  @IBOutlet var tableView: UITableView!
  @IBOutlet var tukiViewController: UITableView!
  @IBOutlet weak var calendar: FSCalendar!

  var Todoindividual: [String] = []
  var saveData: UserDefaults = UserDefaults.standard
  var titles:[String]? = []
  var todolist: [String]?

  var selectYear: String = ""
    var selectMonth: String = ""
    var selectDay: String = ""

//  画面が開かれた時にされる処理
  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.delegate = self
    tableView.dataSource = self
    self.calendar.dataSource = self
    self.calendar.delegate = self
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    //todolist = UserDefaults.standard.stringArray(forKey: "todolist")
  
    tableView.dataSource = self
    tableView.reloadData()
    saveData.register(defaults: ["titles":[]])
    titles = saveData.object(forKey:"TodoList") as? [String]
    guard let todo = UserDefaults.standard.object(forKey: "TodoList") as? [String] else { return }
    Todoindividual = todo
    print("todoindividual",Todoindividual)
  }


  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

    return Todoindividual.count

  }

  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      Todoindividual.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .automatic)
      UserDefaults.standard.set(Todoindividual, forKey: "TodoList")

    }
  }


  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let TodoCell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath)

    TodoCell.textLabel?.text = Todoindividual[indexPath.row]

    return TodoCell

    //todolist = UserDefaults.standard.object(forKey:"todolist") as? [String]
  }

  //編集モードがオンの時に行われる処理
  override func setEditing(_ editing: Bool, animated: Bool) {

    super.setEditing(editing, animated: animated)

    tableView.setEditing(editing, animated: animated)
    tableView.isEditing = editing
    tableView.dataSource = self
    tableView.delegate = self

    UserDefaults.standard.register(defaults: ["TodoList": []])
    //Do any additional setup after loading the view.
    Todoindividual = UserDefaults.standard.object(forKey: "TodoList") as! [String]

  }

  func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition){
    print(date)
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy"
    selectYear = formatter.string(from: date)
    formatter.dateFormat = "MMM"
    selectMonth = formatter.string(from: date)
    formatter.dateFormat = "dd"
    selectDay = formatter.string(from: date)
}

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if let prevVC = segue.destination as? enViewController {
          prevVC.dataFromCalendarYear = selectYear
          prevVC.dataFromCalendarMonth = selectMonth
          prevVC.dataFromCalendarDay = selectDay
          
      }
  }

}


