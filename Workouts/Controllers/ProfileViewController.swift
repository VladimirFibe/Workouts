//
//  ProfileViewController.swift
//  Workouts
//
//  Created by Vladimir Fibe on 08.04.2022.
//

import UIKit
import SwiftUI
import RealmSwift

class ProfileViewController: WOViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  private func configureUI() {
    titleLabel.text = "PROFILE"
    closeButton.isHidden = true
    let stack = UIStackView(arrangedSubviews: [], axis: .vertical, spacing: 10)
    view.addSubview(stack)
    stack.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor)
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
