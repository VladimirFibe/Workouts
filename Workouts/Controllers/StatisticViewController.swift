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
  private let segmentControl = UISegmentedControl(items: ["Month", "Year"]).then {
    $0.backgroundColor = .specialGreen
    $0.tintColor = .red
    $0.selectedSegmentIndex = 1
    $0.addTarget(nil, action: #selector(selectTapped), for: .valueChanged)
  }
  
  private let exercisesLabel = UILabel("Exercises").then {
    $0.font = .robotoMedium14()
    $0.textColor = .specialLightBrown
  }
  
  private let tableView = UITableView().then {
    $0.backgroundColor = .none
    $0.separatorStyle = .none
    $0.showsVerticalScrollIndicator = false
    $0.bounces = false
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tableView.reloadData()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    getworkouts(Date())
  }
  
  @objc func selectTapped() {
    print(segmentControl.selectedSegmentIndex)
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
    tableView.register(StatisticCell.self, forCellReuseIdentifier: idCell)
    let stack = UIStackView(arrangedSubviews: [segmentControl, exercisesLabel, tableView], axis: .vertical, spacing: 20)
    view.addSubview(stack)
    stack.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 20, paddingRight: 20)
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
    workouts.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: idCell, for: indexPath) as! StatisticCell
    let model = workouts[indexPath.row]
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

