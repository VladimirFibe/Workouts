//
//  MainViewController.swift
//  Workouts
//
//  Created by Vladimir Fibe on 08.04.2022.
//

import UIKit
import SwiftUI

class MainViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  func configureUI() {
    view.backgroundColor = .specialBackground
  }
}

struct SwiftUIMainViewController: UIViewControllerRepresentable {
  typealias UIViewControllerType = MainViewController
  
  func makeUIViewController(context: Context) -> UIViewControllerType {
    let viewController = UIViewControllerType()
    return viewController
  }
  
  func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    
  }
}

struct MainViewController_Previews: PreviewProvider {
  static var previews: some View {
    SwiftUIMainViewController()
      .edgesIgnoringSafeArea(.all)
  }
}

