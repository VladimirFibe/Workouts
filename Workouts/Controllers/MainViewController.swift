//
//  MainViewController.swift
//  Workouts
//
//  Created by Vladimir Fibe on 08.04.2022.
//

import UIKit
import SwiftUI
import RealmSwift

class MainViewController: UIViewController {
  let idCell = "MainCell"
  let diameter = 100.0
  let buttonWidth = 80.0
  let calendarHeight = 70.0
  private let localRealm = try! Realm()
  private var workouts: Results<Workout>! = nil

  private lazy var userPhotoImageView = UIImageView().then {
    $0.backgroundColor = .systemGray4
    $0.layer.borderColor = UIColor.white.cgColor
    $0.layer.borderWidth = 5
    $0.layer.cornerRadius = diameter / 2
  }
  
  private let userNameLabel = UILabel().then {
    $0.text = "User Name"
    $0.textColor = .specialGray
    $0.font = .robotoMedium24()
    $0.minimumScaleFactor = 0.5
    $0.adjustsFontSizeToFitWidth = true
  }
  
  private let calendarView = CalendarView(frame: .zero)
  
  private lazy var addWorkoutButton = UIButton(type: .system).then {
    $0.backgroundColor = .specialYellow
    $0.layer.cornerRadius = 10
    $0.setImage(UIImage(named: "+"), for: .normal)
    $0.tintColor = .specialDarkGreen
    $0.addShadowOnView()
    $0.addTarget(self, action: #selector(addWorkoutAction), for: .touchUpInside)
  }
  
  private let weatherView = WeatherView(frame: .zero)
  
  private let workoutTodayLabel = UILabel("Workout today")
  
  private let tableView = UITableView().then {
    $0.backgroundColor = .none
    $0.separatorStyle = .none
    $0.showsVerticalScrollIndicator = false
    $0.bounces = false
  }
  
  private let imageView = UIImageView(image: UIImage(named: "notraining")).then {
    $0.contentMode = .scaleAspectFit
  }
  func hideornot() {
    tableView.reloadData()
    if workouts.count == 0 {
      imageView.isHidden = false
      tableView.isHidden = true
    } else {
      imageView.isHidden = true
      tableView.isHidden = false
    }
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    hideornot()
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    getWorkouts(Date())
    configureUI()
  }
  private func getWorkouts(_ date: Date) {
    let dateTimeZone = date.localDate()
    let weekday = dateTimeZone.getWeekday()
    let (dateStart, dateEnd) = dateTimeZone.startEndDate()
    let predicateRepeat = NSPredicate(format: "days = \(weekday) AND repeats = true")
    let predicateUnrepeat = NSPredicate(format: "repeats = false AND date BETWEEN %@", [dateStart, dateEnd])
    let compund = NSCompoundPredicate(type: .or, subpredicates: [predicateRepeat, predicateUnrepeat])
    workouts = localRealm.objects(Workout.self).filter(compund).sorted(byKeyPath: "name")
    hideornot()
  }
  // MARK: - Actions
  @objc private func addWorkoutAction() {
    let viewController = NewWorkoutViewController()
    viewController.modalPresentationStyle = .fullScreen
    present(viewController, animated: true)
  }
  // MARK: - UI
  private func configureUI() {
    view.backgroundColor = .specialBackground
    calendarView.delegate = self
    tableView.delegate = self
    tableView.register(WorkoutCell.self, forCellReuseIdentifier: idCell)
    tableView.dataSource = self
    let stack = UIStackView(arrangedSubviews: [imageView, tableView], axis: .vertical, spacing: 0)
    setupSubviews()
    setupConstraints()
    view.addSubview(stack)
    stack.anchor(top: workoutTodayLabel.bottomAnchor,
                     left: view.leftAnchor,
                     bottom: view.bottomAnchor,
                     right: view.rightAnchor)
  }
  
  private func setupSubviews() {
    view.addSubview(calendarView)
    view.addSubview(userPhotoImageView)
    view.addSubview(userNameLabel)
    view.addSubview(addWorkoutButton)
    view.addSubview(weatherView)
    view.addSubview(workoutTodayLabel)
    
  }
  
  private func setupConstraints() {
    let margins = view.layoutMarginsGuide
    userPhotoImageView.anchor(top: margins.topAnchor,
                              left: margins.leftAnchor,
                              width: diameter, height: diameter)
    calendarView.anchor(top: userPhotoImageView.topAnchor,
                        left: userPhotoImageView.leftAnchor,
                        right: margins.rightAnchor,
                        paddingTop: diameter / 2,
                        height: calendarHeight)
    userNameLabel.anchor(top: userPhotoImageView.topAnchor,
                         left: userPhotoImageView.rightAnchor,
                         bottom: calendarView.topAnchor,
                         right: calendarView.rightAnchor,
                         paddingLeft: 10)
    addWorkoutButton.anchor(top: calendarView.bottomAnchor,
                            left: calendarView.leftAnchor,
                            paddingTop: 5,
                            width: buttonWidth, height: buttonWidth)
    weatherView.anchor(top: addWorkoutButton.topAnchor,
                       left: addWorkoutButton.rightAnchor,
                       bottom: addWorkoutButton.bottomAnchor,
                       right: margins.rightAnchor,
                       paddingLeft: 10)
    workoutTodayLabel.anchor(top: addWorkoutButton.bottomAnchor,
                             left: addWorkoutButton.leftAnchor,
                             paddingTop: 10)
    
  }
}
// MARK: - CalenderViewDelegate
extension MainViewController: CalenderViewDelegate {
  func selectDate(_ date: Date) {
    getWorkouts(date)
  }
}
// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
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
extension MainViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    workouts.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: idCell, for: indexPath) as! WorkoutCell
    let model = workouts[indexPath.row]
    cell.configure(with: model)
    cell.delegate = self
    return cell
  }
}
// MARK: - WorkoutCellDelegate
extension MainViewController: WorkoutCellDelegate {
  func startButtonTapped(_ model: Workout) {
    let viewController = StartViewController()
    viewController.configure(with: model)
    viewController.modalPresentationStyle = .fullScreen
    present(viewController, animated: true)
  }
}
// MARK: - Preview
struct SwiftUIMainViewController: UIViewControllerRepresentable {
  typealias UIViewControllerType = MainViewController
  
  func makeUIViewController(context: Context) -> UIViewControllerType {
    let viewController = UIViewControllerType()
    return viewController
  }
  
  func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    
  }
}
struct MainViewController_Previews: PreviewProvider {
  static var previews: some View {
    SwiftUIMainViewController()
      .edgesIgnoringSafeArea(.all)
  }
}

