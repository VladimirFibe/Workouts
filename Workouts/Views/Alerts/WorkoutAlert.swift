//
//  WorkoutAlert.swift
//  Workouts
//
//  Created by Vladimir Fibe on 11.04.2022.
//

import UIKit

class WorkoutAlert {
  let x = 40.0
  let height = 460.0
  
  private let backgroundView = UIView().then {
    $0.backgroundColor = .black
    $0.alpha = 0
  }
  
  private let alertView = UIView().then {
    $0.backgroundColor = .specialBackground
    $0.layer.cornerRadius = 20
  }
  
  private let girlView = UIImageView(image: UIImage(named: "sportgirl")).then {
    $0.contentMode = .scaleAspectFit
    $0.heightAnchor.constraint(equalToConstant: 170).isActive = true
  }
  
  private let editing = UILabel("Editing").then {
    $0.textColor = .specialBlack
    $0.font = .robotoMedium24()
    $0.textAlignment = .center
  }
  
  private let setsView = NameView()
  private let repsView = NameView()
  
  private let okButton = UIButton(type: .system).then {
    $0.backgroundColor = .specialGreen
    $0.titleLabel?.font = .robotoBold16()
    $0.setTitle("OK", for: .normal)
    $0.layer.cornerRadius = 10
    $0.heightAnchor.constraint(equalToConstant: 55).isActive = true
  }
  
  var buttonAction: ((String, String) -> Void)?
  private var mainView: UIView?
  private let scrollView = UIScrollView()
  
  func customAlert(_ viewController: StartViewController, completion: @escaping (String, String) -> Void) {
    registerForKeyboardNotification()
    guard let parentView = viewController.view else { return }
    mainView = parentView
    let model = viewController.workout
    scrollView.frame = parentView.frame
    parentView.addSubview(scrollView)
    scrollView.addSubview(backgroundView)
    scrollView.addSubview(alertView)
    backgroundView.frame = parentView.frame
    
    alertView.frame = CGRect(x: x, y: -height, width: parentView.frame.width - 2 * x, height: height)
    buttonAction = completion
    setsView.configure(name: "Sets", value: "\(model.sets)")
    if model.timer == 0 {
      repsView.configure(name: "Reps", value: "\(model.reps)")
    } else {
      repsView.configure(name: "Time of set", value: "\(model.timer)")
    }
    setsView.nameTextField.keyboardType = .numberPad
    repsView.nameTextField.keyboardType = .numberPad
    okButton.addTarget(self, action: #selector(okAction), for: .touchUpInside)
    let stack = UIStackView(arrangedSubviews: [girlView, editing, setsView, repsView, okButton], axis: .vertical, spacing: 10)
    alertView.addSubview(stack)
    stack.anchor(top: alertView.topAnchor,
                 left: alertView.leftAnchor,
                 right: alertView.rightAnchor,
    paddingTop: 10, paddingLeft: x, paddingRight: x)
    UIView.animate(withDuration: 0.3) {
      self.backgroundView.alpha = 0.8
    } completion: { done in
      if done {
        UIView.animate(withDuration: 0.3) {
          self.alertView.center = parentView.center
        }
      }
    }
  }
  
  @objc func okAction() {
    let sets = setsView.value
    let reps = repsView.value
    buttonAction?(sets, reps)
    guard let targetView = mainView else { return }
    UIView.animate(withDuration: 0.3) {
      self.alertView.frame = CGRect(x: self.x, y: targetView.frame.height, width: targetView.frame.width - 2 * self.x, height: self.height)
    } completion: { done in
      if done {
        UIView.animate(withDuration: 0.3) {
          self.backgroundView.alpha = 0
        } completion: { done in
          if done {
            self.scrollView.removeFromSuperview()
            self.removeKeyboardNotification()
          }
        }
      }
    }
  }
  
  @objc private func keyboardWillShow() {
    scrollView.contentOffset = CGPoint(x: 0, y: 130)
  }
  @objc private func keyboardWillHide() {
    scrollView.contentOffset = .zero
  }
  private func registerForKeyboardNotification() {
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(keyboardWillShow),
                                           name: UIResponder.keyboardWillShowNotification,
                                           object: nil)
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(keyboardWillHide),
                                           name: UIResponder.keyboardWillHideNotification,
                                           object: nil)
  }
  private func removeKeyboardNotification() {
    NotificationCenter.default.removeObserver(self,
                                              name: UIResponder.keyboardWillShowNotification,
                                              object: nil)
    NotificationCenter.default.removeObserver(self,
                                              name: UIResponder.keyboardWillHideNotification,
                                              object: nil)
  }
}
