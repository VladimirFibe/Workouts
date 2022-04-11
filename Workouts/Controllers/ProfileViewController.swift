//
//  ProfileViewController.swift
//  Workouts
//
//  Created by Vladimir Fibe on 08.04.2022.
//

import UIKit
import SwiftUI

class ProfileViewController: WOViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  private func configureUI() {
    titleLabel.text = "PROFILE"
    closeButton.isHidden = true
  }
}

struct SwiftUIProfileViewController: UIViewControllerRepresentable {
  typealias UIViewControllerType = ProfileViewController
  
  func makeUIViewController(context: Context) -> UIViewControllerType {
    let viewController = UIViewControllerType()
    return viewController
  }
  
  func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    
  }
}

struct ProfileViewController_Previews: PreviewProvider {
  static var previews: some View {
    SwiftUIProfileViewController()
      .edgesIgnoringSafeArea(.all)
  }
}
