//
//  NameView.swift
//  Workouts
//
//  Created by Vladimir Fibe on 10.04.2022.
//

import UIKit

class NameView: TitleView, UITextFieldDelegate {
  let nameTextField = UITextField().then {
    $0.borderStyle = .none
    $0.clearButtonMode = .always
    $0.returnKeyType = .done
    $0.font = .robotoBold20()
    $0.textColor = .specialGray
  }
  override init(frame: CGRect) {
    super.init(frame: frame)
    titleLabel.text = "Name"
    nameTextField.delegate = self
    heightAnchor.constraint(equalToConstant: 65).isActive = true
    roundRect.addSubview(nameTextField)
    nameTextField.anchor(left: roundRect.leftAnchor, right: roundRect.rightAnchor, paddingLeft: 15, paddingRight: 15)
    nameTextField.centerYAnchor.constraint(equalTo: roundRect.centerYAnchor).isActive = true
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  // MARK: - UITextFieldDelegate
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    nameTextField.resignFirstResponder()
  }
  func configure(name: String, value: String) {
    titleLabel.text = name
    nameTextField.text = value
  }
  func changeValue(_ value: String) {
    nameTextField.text = value
  }
  var value: String {
    nameTextField.text ?? ""
  }
}
