//
//  MainViewController.swift
//  Workouts
//
//  Created by Vladimir Fibe on 08.04.2022.
//

import UIKit
import SwiftUI
import RealmSwift

class MainViewController: UIViewController {
  let idCell = "MainCell"
  private let localRealm = try! Realm()
  private let workouts: Results<Workout>! = nil
  
  private let tableView = UITableView().then {
    $0.backgroundColor = .none
    $0.separatorStyle = .none
    $0.showsVerticalScrollIndicator = false
    $0.bounces = false
  }
  
  private let imageView = UIImageView(image: UIImage(named: "notraining")).then {
    $0.contentMode = .scaleAspectFit
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  func configureUI() {
    view.backgroundColor = .specialBackground
    let stack = UIStackView(arrangedSubviews: [imageView], axis: .vertical)
    
    stack.addConstraintsToFillView(view)
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

