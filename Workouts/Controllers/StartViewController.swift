//
//  StartViewController.swift
//  Workouts
//
//  Created by Vladimir Fibe on 10.04.2022.
//
import SwiftUI
import UIKit

class StartViewController: WOViewController {
  var sets = 0
  var workout = Workout()
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

