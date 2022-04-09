//
//  NewWorkoutViewController.swift
//  Workouts
//
//  Created by Vladimir Fibe on 08.04.2022.
//

import UIKit
import SwiftUI
import RealmSwift

class NewWorkoutViewController: WOViewController {
  private let localRealm = try! Realm()
  private var workout = Workout()
  private let defaultImage = UIImage(named: "workout1")
    
  private let scrollView = UIScrollView().then {
    $0.bounces = false
    $0.showsVerticalScrollIndicator = false
  }
  
  private let nameLabel = UILabel("Name")
  private let nameTextField = UITextField().then {
    $0.backgroundColor = .specialBrown
    $0.borderStyle = .none
    $0.layer.cornerRadius = 10
    $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: $0.frame.height))
    $0.leftViewMode = .always
    $0.clearButtonMode = .always
    $0.returnKeyType = .done
    $0.font = .robotoBold20()
    $0.textColor = .specialGray
  }
  
  private let dateLabel = UILabel("Date and repeat")
  private let dateAndRepeatView = DateAndRepeatView(frame: .zero)
  
  private let repsLabel = UILabel("Reps or timer")
  private let repsView = RepsOrTimerView(frame: .zero)
  
  private lazy var saveButton = UIButton().then {
    $0.backgroundColor = .specialGreen
    $0.setTitle("SAVE", for: .normal)
    $0.tintColor = .white
    $0.titleLabel?.font = .robotoBold16()
    $0.layer.cornerRadius = 10
    $0.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    addTapsAndSwipe()
  }
  
  func addTapsAndSwipe() {
    let tapScreen = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
    tapScreen.cancelsTouchesInView = false
    view.addGestureRecognizer(tapScreen)
    
    let swipeScreen = UISwipeGestureRecognizer(target: self, action: #selector(hideKeyboard))
    swipeScreen.cancelsTouchesInView = false
    view.addGestureRecognizer(swipeScreen)
  }
  
  // MARK: - Action
  @objc func hideKeyboard() {
    view.endEditing(true)
  }
  
  @objc func saveAction() {
    guard let name = nameTextField.text,
          name.filter({ $0.isNumber || $0.isLetter }).count > 0 else {
            print("Введите имя")
            return
          }
    workout.name = name
    workout.date = dateAndRepeatView.getDate()
    workout.days = workout.date.getWeekday()
    workout.sets = repsView.getSet()
    if workout.sets == 0 {
      print("Zero sets!!!")
      return
    }
    workout.reps = repsView.getReps()
    workout.timer = repsView.getTimer()
    if workout.reps == 0 && workout.timer == 0 {
      print("Что делать?")
      return
    }
    workout.repeats = dateAndRepeatView.getRepeat()
    RealmManager.shared.save(workout)
    print("Сохранено")
    workout = Workout()
    nameTextField.text = ""
    dateAndRepeatView.resetValues()
    repsView.resetValues()
  }
  // MARK: - UI
  private func configureUI() {
    titleLabel.text = "NEW WORKOUT"
    nameTextField.delegate = self
    setSubviews()
    setConstraints()
  }
  func setSubviews() {
    view.addSubview(scrollView)
    scrollView.addSubview(nameLabel)
    scrollView.addSubview(nameTextField)
    scrollView.addSubview(dateLabel)
    scrollView.addSubview(dateAndRepeatView)
    scrollView.addSubview(repsLabel)
    scrollView.addSubview(repsView)
    scrollView.addSubview(saveButton)
  }
  func setConstraints() {
    scrollView.anchor(top: titleLabel.bottomAnchor,
                      left: view.leftAnchor,
                      bottom: view.safeAreaLayoutGuide.bottomAnchor,
                      right: view.rightAnchor)
    nameLabel.anchor(top: scrollView.topAnchor,
                     left: view.leftAnchor,
                     right: view.rightAnchor,
                     paddingTop: 10, paddingLeft: 25, paddingRight: 20)
    nameTextField.anchor(top: nameLabel.bottomAnchor,
                         left: view.leftAnchor,
                         right: view.rightAnchor,
                         paddingTop: 3, paddingLeft: 20, paddingRight: 20, height: 38)
    dateLabel.anchor(top: nameTextField.bottomAnchor,
                     left: view.leftAnchor,
                     right: view.rightAnchor,
                     paddingTop: 10, paddingLeft: 25, paddingRight: 20)
    dateAndRepeatView.anchor(top: dateLabel.bottomAnchor,
                         left: view.leftAnchor,
                         right: view.rightAnchor,
                         paddingTop: 3, paddingLeft: 20, paddingRight: 20, height: 94)
    repsLabel.anchor(top: dateAndRepeatView.bottomAnchor,
                     left: view.leftAnchor,
                     right: view.rightAnchor,
                     paddingTop: 10, paddingLeft: 25, paddingRight: 20)
    repsView.anchor(top: repsLabel.bottomAnchor,
                         left: view.leftAnchor,
                         right: view.rightAnchor,
                         paddingTop: 3, paddingLeft: 20, paddingRight: 20, height: 300)
    saveButton.anchor(top: repsView.bottomAnchor,
                      left: view.leftAnchor,
                      bottom: scrollView.bottomAnchor,
                      right: view.rightAnchor,
                      paddingTop: 20, paddingLeft: 20, paddingBottom: 20, paddingRight: 20, height: 55)
  }
}
// MARK: - UITextFieldDelegate
extension NewWorkoutViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    nameTextField.resignFirstResponder()
  }
}
// MARK: - Preview
struct SwiftUINewWorkoutViewController: UIViewControllerRepresentable {
  typealias UIViewControllerType = NewWorkoutViewController
  
  func makeUIViewController(context: Context) -> UIViewControllerType {
    let viewController = UIViewControllerType()
    return viewController
  }
  
  func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    
  }
}

struct NewWorkoutViewController_Previews: PreviewProvider {
  static var previews: some View {
    SwiftUINewWorkoutViewController()
      .edgesIgnoringSafeArea(.all)
  }
}
