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
  var day = Date()
  private let localRealm = try! Realm()
  private var workout = Workout()
  private let defaultImage = UIImage(named: "workout1")
    
  private let scrollView = UIScrollView().then {
    $0.bounces = false
    $0.showsVerticalScrollIndicator = false
  }
  private let nameView = NameView(frame: .zero)
  private let dateView = DateAndRepeatView(frame: .zero)
  private let repsView = RepsOrTimerView(frame: .zero)
  
  private lazy var saveButton = UIButton().then {
    $0.backgroundColor = .specialGreen
    $0.setTitle("SAVE", for: .normal)
    $0.tintColor = .white
    $0.titleLabel?.font = .robotoBold16()
    $0.layer.cornerRadius = 10
    $0.heightAnchor.constraint(equalToConstant: 55).isActive = true
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
    nameView.endEditing(true)
  }
  
  @objc func saveAction() {
    guard let name = nameView.nameTextField.text,
          name.filter({ $0.isNumber || $0.isLetter }).count > 0 else {
            print("Введите имя")
            return
          }
    workout.name = name
    workout.date = dateView.getDate().localDate()
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
    workout.repeats = dateView.getRepeat()
    RealmManager.shared.save(workout)
    print("Сохранено")
    workout = Workout()
    nameView.nameTextField.text = ""
    dateView.resetValues()
    repsView.resetValues()
  }
  // MARK: - UI
  private func configureUI() {
    titleLabel.text = "NEW WORKOUT"
    dateView.day = day
    let stack = UIStackView(arrangedSubviews: [nameView, dateView, repsView, saveButton], axis: .vertical, spacing: 20)
    view.addSubview(scrollView)
    scrollView.addSubview(stack)
    scrollView.anchor(top: titleLabel.bottomAnchor,
                      left: view.leftAnchor,
                      bottom: view.safeAreaLayoutGuide.bottomAnchor,
                      right: view.rightAnchor)
    stack.anchor(top: scrollView.topAnchor,
                 left: scrollView.leftAnchor,
                 bottom: scrollView.bottomAnchor,
                 paddingTop: 10, paddingLeft: 20, paddingBottom: 10)
    stack.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 40).isActive = true

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
