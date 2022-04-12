//
//  StartViewController.swift
//  Workouts
//
//  Created by Vladimir Fibe on 10.04.2022.
//
import SwiftUI
import UIKit

class StartViewController: WOViewController {
  var sets = 0 { didSet {
    detailView.configure(sets: "\(sets)/\(workout.sets)")}}
  var workout = Workout()
  var workoutAlert = WorkoutAlert()
  private lazy var girlView = UIImageView().then {
    let name = workout.timer == 0 ? "startgirl" : "ellipse"
    $0.image = UIImage(named: name)
  }
  let detailView = DetailView(frame: .zero)
  private let finishButton = UIButton().then {
    $0.backgroundColor = .specialGreen
    $0.setTitle("FINISH", for: .normal)
    $0.tintColor = .white
    $0.titleLabel?.font = .robotoBold16()
    $0.layer.cornerRadius = 10
    $0.heightAnchor.constraint(equalToConstant: 55).isActive = true
    $0.addTarget(nil, action: #selector(finishButtonTapped), for: .touchUpInside)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  
  @objc func finishButtonTapped() {
//    alertOKCancel(title: "Кончил?", message: nil) {
//      RealmManager.shared.update(self.workoutModel)
//      self.timer.invalidate()
//      self.dismiss(animated: true)
//    }
  }
  
  func configure(with model: Workout) {
    workout = model
    detailView.configure(model: model, sets: sets)
  }
  
  private func configureUI() {
    titleLabel.text = "START WORKOUT"
    detailView.delegate = self
    let girlStack = UIStackView(arrangedSubviews: [girlView], axis: .vertical, spacing: 0)
    girlStack.alignment = .center
    let stack = UIStackView(arrangedSubviews: [girlStack, detailView, finishButton], axis: .vertical, spacing: 20)
    stack.alignment = .fill
    view.addSubview(stack)
    stack.anchor(top: titleLabel.bottomAnchor,
                 left: view.leftAnchor,
                 right: view.rightAnchor,
                 paddingTop: 20, paddingLeft: 20, paddingRight: 20)
    NSLayoutConstraint.activate([
      girlView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
      girlView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7)
    ])
  }
}
// MARK: - StartWorkoutDelegate
extension StartViewController: DetailViewDelegate {
  func editSet() {
    workoutAlert.customAlert(self) { sets, reps in
      print(sets, reps)
//      guard let numberOfSets = Int(sets) else { return }
//      guard let numberOfReps = Int(reps) else { return }
//      if self.workoutModel.timer == 0 {
//        RealmManager.shared.update(self.workoutModel, sets: numberOfSets, reps: numberOfReps, timer: 0)
//      } else {
//        RealmManager.shared.update(self.workoutModel, sets: numberOfSets, reps: 0, timer: numberOfReps)
//      }
//      self.sets = 0
//      self.detailView.configure(model: self.workoutModel, sets: self.sets)
    }
  }
  
  func nextSet() {
    sets += 1
    if sets == workout.sets {
      self.girlView.isUserInteractionEnabled = false
      self.detailView.configureNextSet(true)
      self.timer.invalidate()
      alertOKCancel(title: "Закончил?", message: nil) {
        RealmManager.shared.update(self.workout)
        self.dismiss(animated: true)
      }
    }
  }
}
struct SwiftUIStartViewController: UIViewControllerRepresentable {
  typealias UIViewControllerType = StartViewController
  
  func makeUIViewController(context: Context) -> UIViewControllerType {
    let viewController = UIViewControllerType()
    return viewController
  }
  
  func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    
  }
}

struct StartViewController_Previews: PreviewProvider {
  static var previews: some View {
    SwiftUIStartViewController()
      .edgesIgnoringSafeArea(.all)
  }
}

