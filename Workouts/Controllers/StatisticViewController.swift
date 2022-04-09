//
//  StatisticViewController.swift
//  Workouts
//
//  Created by Vladimir Fibe on 08.04.2022.
//

import UIKit
import SwiftUI

class StatisticViewController: WOViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  private func configureUI() {
    titleLabel.text = "STATISTIC"
    closeButton.isHidden = true
  }
}

struct SwiftUIStatisticViewController: UIViewControllerRepresentable {
  typealias UIViewControllerType = StatisticViewController
  
  func makeUIViewController(context: Context) -> UIViewControllerType {
    let viewController = UIViewControllerType()
    return viewController
  }
  
  func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    
  }
}

struct StatisticViewController_Previews: PreviewProvider {
  static var previews: some View {
    SwiftUIStatisticViewController()
      .edgesIgnoringSafeArea(.all)
  }
}

