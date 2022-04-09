//
//  StartViewController.swift
//  Workouts
//
//  Created by Vladimir Fibe on 10.04.2022.
//

import UIKit

class StartViewController: WOViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  private func configureUI() {
    titleLabel.text = "START WORKOUT"
  }
}
