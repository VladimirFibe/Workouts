//
//  OnboardingViewController.swift
//  Workouts
//
//  Created by Vladimir Fibe on 14.04.2022.
//

import UIKit
import SwiftUI

class OnboardingViewController: UIViewController {
  private let idOnboardingCell = "idOnboardingCell"
  private var onboardings = Onboarding.all
  private var item = 0
  private lazy var nextButton = UIButton(type: .system).then {
    $0.backgroundColor = .specialBackground
    $0.setTitle("NEXT", for: .normal)
    $0.tintColor = .specialGreen
    $0.titleLabel?.font = .robotoBold20()
    $0.layer.cornerRadius = 25
    $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
    $0.addTarget(self, action: #selector(nextButtonAction), for: .touchUpInside)
  }
  
  private let pageControl = UIPageControl().then {
    $0.numberOfPages = 3
    $0.heightAnchor.constraint(equalToConstant: 30).isActive = true
  }
  
  private let layout = UICollectionViewFlowLayout().then {
    $0.minimumLineSpacing = 0
    $0.scrollDirection = .horizontal
  }
  
  private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
    $0.backgroundColor = .white
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  @objc func nextButtonAction() {
    if item == 1 {
      nextButton.setTitle("START", for: .normal)
    }
    
    if item == 2 {
      saveUserDefaults()
    } else {
      item += 1
      let index: IndexPath = [0, item]
      collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
    }
    pageControl.currentPage = item
  }
  
  private func saveUserDefaults() {
    let userDefaults = UserDefaults.standard
    userDefaults.set(true, forKey: "OnBoardingWasviewed")
    dismiss(animated: true)
  }
  
  func configureUI() {
    view.backgroundColor = .specialGreen
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: idOnboardingCell)
//    let spacer = UIView()
    view.addSubview(collectionView)
    let stack = UIStackView(arrangedSubviews: [pageControl, nextButton], axis: .vertical)
    stack.distribution = .equalSpacing
    view.addSubview(stack)
    collectionView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: stack.topAnchor, right: view.rightAnchor)
    stack.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 30, paddingBottom: 30, paddingRight: 30, height: 90)
  }
}
extension OnboardingViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idOnboardingCell, for: indexPath) as! OnboardingCollectionViewCell
    let onboarding = onboardings[indexPath.item]
    cell.configure(with: onboarding)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    onboardings.count
  }
}
extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    CGSize(width: view.frame.width, height: collectionView.frame.height)
  }
}
// MARK: - Preview
struct SwiftUIOnboardingViewController: UIViewControllerRepresentable {
  typealias UIViewControllerType = OnboardingViewController
  
  func makeUIViewController(context: Context) -> UIViewControllerType {
    let viewController = UIViewControllerType()
    return viewController
  }
  
  func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    
  }
}

struct OnboardingViewController_Previews: PreviewProvider {
  static var previews: some View {
    SwiftUIOnboardingViewController()
      .edgesIgnoringSafeArea(.all)
  }
}

