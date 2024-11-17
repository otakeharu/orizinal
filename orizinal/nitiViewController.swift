//
//  ViewControllerniti.swift
//  orizinal
//
//  Created by Haru Takenaka on 2023/08/22.
//

import UIKit


class nitiViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {



  @IBOutlet var enLabel: UILabel!
  @IBOutlet var tableView: UITableView!
  //@IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var yearLabel: UILabel!
    @IBOutlet var monthLabel: UILabel!
    @IBOutlet var dayLabal: UILabel!

  var Todoindividual: [String] = []
  var saveData: UserDefaults = UserDefaults.standard
  var titles:[String]? = []
  var todolist: [String]?


  var dataFromCalendarYear: String?
    var dataFromCalendarMonth: String?
    var dataFromCalendarDay: String?


  override func viewDidLoad() {

    super.viewDidLoad()
    enLabel.layer.cornerRadius = 160
    enLabel.clipsToBounds = true
    tableView.dataSource = self
    tableView.reloadData()
    saveData.register(defaults: ["titles":[]])
    titles = saveData.object(forKey:"TodoList") as? [String]
    guard let todo = UserDefaults.standard.object(forKey: "TodoList") as? [String] else { return }
    Todoindividual = todo
    print("todoindividual",Todoindividual)
      
  }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        if let receivedDate = dataFromNextVC {
//            print("Received date: \(receivedDate)")
//        }
//    }
    
    @IBAction func unwindToNitiViewController(_ segue: UIStoryboardSegue) {
        if let sourceVC = segue.source as? tukiViewController {
            yearLabel.text = sourceVC.selectYear
            monthLabel.text = sourceVC.selectMonth
            dayLabal.text = sourceVC.selectDay
            
        }
    }


  class CircleGraphViewController: UIViewController {

    override func viewDidLoad() {
      super.viewDidLoad()
      drawCircleGraph(percentage: 75)
    }

    func drawCircleGraph(percentage: Int) {
      let circlePath = UIBezierPath(arcCenter: view.center, radius: 100, startAngle: .pi * -0.5, endAngle: .pi * 1.5, clockwise: true)

      // 背景のサークル
      let backgroundLayer = CAShapeLayer()
      backgroundLayer.path = circlePath.cgPath
      backgroundLayer.strokeColor = UIColor.lightGray.cgColor
      backgroundLayer.fillColor = UIColor.clear.cgColor
      backgroundLayer.lineWidth = 10
      view.layer.addSublayer(backgroundLayer)

      // パーセント表示のサークル
      let progressLayer = CAShapeLayer()
      progressLayer.path = circlePath.cgPath
      progressLayer.strokeColor = UIColor.red.cgColor
      progressLayer.fillColor = UIColor.clear.cgColor
      progressLayer.lineWidth = 10
      progressLayer.strokeEnd = CGFloat(percentage) / 100.0
      view.layer.addSublayer(progressLayer)
    }
  }

  class ColoredCircleGraphViewController: UIViewController {

    override func viewDidLoad() {
      super.viewDidLoad()
      drawColoredCircleGraph(data: [30, 25, 45])
    }

    func drawColoredCircleGraph(data: [Int]) {
      let colors = [UIColor.red, UIColor.green, UIColor.blue]
      var startAngle = CGFloat.pi * -0.5
      let radius = CGFloat(100)

      for (index, value) in data.enumerated() {
        let circlePath = UIBezierPath(arcCenter: view.center, radius: radius, startAngle: startAngle, endAngle: startAngle + CGFloat(Double(value) / 100.0 * 2.0 * Double.pi), clockwise: true)

        let progressLayer = CAShapeLayer()
        progressLayer.path = circlePath.cgPath
        progressLayer.strokeColor = colors[index % colors.count].cgColor
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineWidth = 10
        view.layer.addSublayer(progressLayer)

        startAngle += CGFloat(Double(value) / 100.0 * 2.0 * Double.pi)
      }
    }
  }


  class DynamicCircleGraphViewController: UIViewController {

    var progressLayer: CAShapeLayer!

    override func viewDidLoad() {
      super.viewDidLoad()

      drawInitialCircleGraph()

      let updateButton = UIButton(frame: CGRect(x: 50, y: 400, width: 200, height: 40))
      updateButton.setTitle("データ更新", for: .normal)
      updateButton.addTarget(self, action: #selector(updateGraphData), for: .touchUpInside)
      view.addSubview(updateButton)
    }

    func drawInitialCircleGraph() {
      let circlePath = UIBezierPath(arcCenter: view.center, radius: 100, startAngle: .pi * -0.5, endAngle: .pi * 1.5, clockwise: true)

      // 背景のサークル
      let backgroundLayer = CAShapeLayer()
      backgroundLayer.path = circlePath.cgPath
      backgroundLayer.strokeColor = UIColor.lightGray.cgColor
      backgroundLayer.fillColor = UIColor.clear.cgColor
      backgroundLayer.lineWidth = 10
      view.layer.addSublayer(backgroundLayer)

      // パーセント表示のサークル
      progressLayer = CAShapeLayer()
      progressLayer.path = circlePath.cgPath
      progressLayer.strokeColor = UIColor.red.cgColor
      progressLayer.fillColor = UIColor.clear.cgColor
      progressLayer.lineWidth = 10
      view.layer.addSublayer(progressLayer)
    }

    @objc func updateGraphData() {
      let randomPercentage = CGFloat(arc4random_uniform(101)) / 100.0
      progressLayer.strokeEnd = randomPercentage
    }
  }




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
