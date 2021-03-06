//
//  StatisticViewController.swift
//  Workouts
//
//  Created by Vladimir Fibe on 08.04.2022.
//

import UIKit
import SwiftUI
import RealmSwift

class StatisticViewController: WOViewController {
  let idCell = "StatCell"
  private let localRealm = try! Realm()
  private var workouts: Results<Workout>! = nil
  private var differences = [ResultWorkout]()
  private var filtered = [ResultWorkout]()
  private var isFiltred = false
  private let today = Date().localDate()

  private lazy var segmentControl = UISegmentedControl(items: ["Month", "Year"]).then {
    $0.backgroundColor = .specialGreen
    $0.selectedSegmentTintColor = .specialYellow
    $0.selectedSegmentIndex = 1
    $0.addTarget(self, action: #selector(selectTapped), for: .valueChanged)
    let font = UIFont.robotoMedium16()
    $0.setTitleTextAttributes([NSAttributedString.Key.font: font as Any,
                               NSAttributedString.Key.foregroundColor: UIColor.white],
                              for: .normal)
    $0.setTitleTextAttributes([NSAttributedString.Key.font: font as Any,
                               NSAttributedString.Key.foregroundColor: UIColor.specialGray],
                              for: .selected)
  }
  
  private let nameTextField = UITextField().then {
    $0.backgroundColor = .specialBrown
    $0.borderStyle = .none
    $0.textColor = .specialGray
    $0.font = .robotoBold20()
    $0.layer.cornerRadius = 10
    $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: $0.frame.height))
    $0.leftViewMode = .always
    $0.clearButtonMode = .always
    $0.returnKeyType = .search
    $0.heightAnchor.constraint(equalToConstant: 38).isActive = true
  }
  private let exercisesLabel = UILabel("Exercises")
  
  private let tableView = UITableView().then {
    $0.backgroundColor = .none
    $0.separatorStyle = .none
    $0.showsVerticalScrollIndicator = false
    $0.bounces = false
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    getDifferences()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    getworkouts(Date())
  }
  
  @objc func selectTapped() {
    getDifferences()
  }
  
  func getDifferences() {
    differences = [ResultWorkout]()
    let start = segmentControl.selectedSegmentIndex == 0 ? today.offsetDays(7) : today.offsetMonth(1)
    let end = Date().localDate()
    let names = getNames()
    for name in names {
      let predicateDifference = NSPredicate(format: "name = '\(name)' AND date BETWEEN %@", [start, end])
      workouts = localRealm.objects(Workout.self).filter(predicateDifference).sorted(byKeyPath: "date")
      guard let last = workouts.last?.reps,
            let first = workouts.first?.reps else {
        return
      }
      let difference = ResultWorkout(name: name, first: first, last: last)
      differences.append(difference)
    }
    tableView.reloadData()
  }
  
  private func getNames() -> [String] {
    var names = [String]()
    workouts = localRealm.objects(Workout.self)
    for workout in workouts {
      if !names.contains(workout.name) {
        names.append(workout.name)
      }
    }
    return names
  }
  private func getworkouts(_ date: Date) {
    let calendar = Calendar.current
    let formatter = DateFormatter()
    formatter.timeZone = TimeZone(abbreviation: "UTC")
    formatter.dateFormat = "yyyy/MM/dd HH:mm"
    let components = calendar.dateComponents([.weekday, .day, .month, .year], from: date)
    guard let weekday = components.weekday else { return }
    guard let day = components.day else { return }
    guard let month = components.month else { return }
    guard let year = components.year else { return }
    
    guard let dateStart = formatter.date(from: "\(year)/\(month)/\(day) 00:00") else { return }
    let dateEnd: Date = {
      let components = DateComponents(day: 1, second: -1)
      return Calendar.current.date(byAdding: components, to: dateStart) ?? Date()
    }()
    let predicateRepeat = NSPredicate(format: "days = \(weekday) AND repeats = true")
    let predicateUnrepeat = NSPredicate(format: "repeats = false AND date BETWEEN %@", [dateStart, dateEnd])
    let compound = NSCompoundPredicate(type: .or, subpredicates: [predicateRepeat, predicateUnrepeat])
    workouts = localRealm.objects(Workout.self).filter(compound).sorted(byKeyPath: "name")
    tableView.reloadData()
  }
  
  private func configureUI() {
    titleLabel.text = "STATISTIC"
    closeButton.isHidden = true
    tableView.delegate = self
    tableView.dataSource = self
    nameTextField.delegate = self
    tableView.register(StatisticCell.self, forCellReuseIdentifier: idCell)
    let stack = UIStackView(arrangedSubviews: [segmentControl, nameTextField, exercisesLabel, tableView], axis: .vertical, spacing: 20)
    view.addSubview(stack)
    stack.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 20, paddingRight: 20)
  }
  
  private func filteringWorkouts(searchText: String) {
    filtered = []
    for workout in differences {
      if workout.name.lowercased().contains(searchText.lowercased()) {
        filtered.append(workout)
      }
    }
    tableView.reloadData()
  }
}
// MARK: - UITextFieldDelegate
extension StatisticViewController: UITextFieldDelegate {
  func textFieldShouldClear(_ textField: UITextField) -> Bool {
    isFiltred = false
    filtered = []
    tableView.reloadData()
    return true
  }
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    if let text = textField.text, let textRange = Range(range, in: text) {
      let updatedText = text.replacingCharacters(in: textRange, with: string)
      isFiltred = updatedText.count > 0
      filteringWorkouts(searchText: updatedText)
    }
    return true
  }
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    nameTextField.resignFirstResponder()
  }
}
// MARK: - UITableViewDelegate
extension StatisticViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    100
  }
  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let action = UIContextualAction(style: .destructive, title: nil) { _, _, _ in
      let model = self.workouts[indexPath.row]
      RealmManager.shared.delete(model)
      tableView.reloadData()
    }
    action.backgroundColor = .specialBackground
    action.image = UIImage(systemName: "trash")?.withRenderingMode(.alwaysOriginal)
    return UISwipeActionsConfiguration(actions: [action])
  }
}
// MARK: - UITableViewDataSource
extension StatisticViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    isFiltred ? filtered.count : differences.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: idCell, for: indexPath) as! StatisticCell
    let model = isFiltred ? filtered[indexPath.row] : differences[indexPath.row]
    cell.configure(with: model)
    return cell
  }
}
// MARK: - Preview
struct SwiftUIStatisticViewController: UIViewControllerRepresentable {
  typealias UIViewControllerType = StatisticViewController
  
  func makeUIViewController(context: Context) -> UIViewControllerType {
    let viewController = UIViewControllerType()
    return viewController
  }
  
  func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    
  }
}

struct StatisticViewController_Previews: PreviewProvider {
  static var previews: some View {
    SwiftUIStatisticViewController()
      .edgesIgnoringSafeArea(.all)
  }
}

