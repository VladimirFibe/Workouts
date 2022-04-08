//
//  ViewController.swift
//  Workouts
//
//  Created by Vladimir Fibe on 08.04.2022.
//

import UIKit
import SwiftUI

class ViewController: UITabBarController {
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }

  private func configureUI() {
    tabBar.backgroundColor = .specialTabBar
    tabBar.tintColor = .specialDarkGreen
    tabBar.unselectedItemTintColor = .specialGray
    tabBar.layer.borderWidth = 1
    tabBar.layer.borderColor = UIColor.specialLightBrown.cgColor
    
    let main = MainViewController()
    let statistic = StatisticViewController()
    let profile = ProfileViewController()
    
    setViewControllers([main, statistic, profile], animated: true)
    
    guard let items = tabBar.items else { return }
    
    items[0].image = UIImage(systemName: "doc.plaintext")
    items[1].image = UIImage(systemName: "slider.horizontal.3")
    items[2].image = UIImage(systemName: "person")
    
    items[0].title = "Main"
    items[1].title = "Statistic"
    items[2].title = "Profile"
    
    UITabBarItem.appearance().setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 14)], for: .normal)
  }
}

struct SwiftUIController: UIViewControllerRepresentable {
  typealias UIViewControllerType = ViewController
  
  func makeUIViewController(context: Context) -> UIViewControllerType {
    let viewController = UIViewControllerType()
    return viewController
  }
  
  func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    
  }
}

struct SwiftUIController_Previews: PreviewProvider {
  static var previews: some View {
    SwiftUIController()
      .edgesIgnoringSafeArea(.all)
  }
}

