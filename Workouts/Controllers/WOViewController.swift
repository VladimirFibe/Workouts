//
//  WOViewController.swift
//  Workouts
//
//  Created by Vladimir Fibe on 08.04.2022.
//

import UIKit
import SwiftUI

class WOViewController: UIViewController {
  var timer = Timer()
  let titleLabel = UILabel().then {
    $0.text = "TITLE"
    $0.font = .robotoMedium24()
    $0.textColor = .specialGray
    $0.textAlignment = .center
    $0.heightAnchor.constraint(equalToConstant: 30).isActive = true
  }
  lazy var closeButton = UIButton().then {
    $0.setImage(UIImage(named: "close")?.withRenderingMode(.alwaysOriginal), for: .normal)
    $0.addTarget(nil, action: #selector(closeAction), for: .touchUpInside)
    $0.layer.cornerRadius = $0.frame.height / 2
  }
  @objc func closeAction() {
    timer.invalidate()
    dismiss(animated: true)
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  
  private func configureUI() {
    view.backgroundColor = .specialBackground
    view.addSubview(titleLabel)
    titleLabel.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 10)
    view.addSubview(closeButton)
    closeButton.anchor(top: view.layoutMarginsGuide.topAnchor,
                       right: view.layoutMarginsGuide.rightAnchor)
  }
}
