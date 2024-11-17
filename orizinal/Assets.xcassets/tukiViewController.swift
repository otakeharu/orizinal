//
//  tukiViewController.swift
//  orizinal
//
//  Created by Haru Takenaka on 2023/11/08.
//


import UIKit

class tukiViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
  
  
  

  @IBOutlet var enLabel: UILabel!
  @IBOutlet var tableView: UITableView!
  //@IBOutlet var titleLabel: UILabel!
  
  var Todoindividual: [String] = []
  var saveData: UserDefaults = UserDefaults.standard
  var titles:[String]? = []
  var todolist: [String]?
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    //todolist = UserDefaults.standard.stringArray(forKey: "todolist")
    
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
  
  // let alert = UIAlertController(title: "保存", message:"メモの保存が完了しました。", preferredStyle: .alert)
  
  //  let alartAction = UIAlertAction(
  //    title: "OK",
  //    style: .default,
  //    handler: { action in
  //      //ボタンが押された時の動作
  //      self.navigationController?.popViewController(animated: true)
  //    }
  //  )
  //  alert.addAction(alartAction)
  //
  //  present(alert, animated: true, completion: nil)
  
  
  
  
  
  
}
