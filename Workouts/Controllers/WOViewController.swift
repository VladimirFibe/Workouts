//
//  WOViewController.swift
//  Workouts
//
//  Created by Vladimir Fibe on 08.04.2022.
//

import UIKit
import SwiftUI

class WOViewController: UIViewController {
  let titleLabel = UILabel().then {
    $0.text = "TITLE"
    $0.font = .robotoMedium24()
    $0.textColor = .specialGray
    $0.textAlignment = .center
    $0.heightAnchor.constraint(equalToConstant: 30).isActive = true
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  
  private func configureUI() {
    view.backgroundColor = .specialBackground
    view.addSubview(titleLabel)
    titleLabel.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 10)
  }
}
