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

  let idProfileCell = "idProfileCell"
  private let localRealm = try! Realm()
  private var workouts: Results<Workout>!
  private var users: Results<User>!
  private var results = [ResultWorkout]()
  
  let titleView = ProfileTitleView().then {
    $0.configure(name: "Брюс Уиллис", image: UIImage(named: "avatar"))
  }

  let heightLabel = UILabel().then {
    $0.text = "Height: 183"
    $0.font = .robotoBold16()
    $0.textColor = .specialGray
  }
  
  let weightLabel = UILabel().then {
    $0.text = "Weight: 90"
    $0.font = .robotoBold16()
    $0.textColor = .specialGray
  }
  
  private lazy var editButton = UIButton(type: .system).then {
    $0.setTitle("Editing ", for: .normal)
    $0.setImage(UIImage(systemName: "ellipsis.circle.fill"), for: .normal)
    $0.titleLabel?.font = .robotoBold16()
    $0.tintColor = .specialGreen
    $0.semanticContentAttribute = .forceRightToLeft
    $0.addTarget(self, action: #selector(editingAction), for: .touchUpInside)
  }
  
  private let layout = UICollectionViewFlowLayout().then {
    $0.scrollDirection = .horizontal
  }
  private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
    $0.bounces = false
    $0.showsHorizontalScrollIndicator = false
    $0.backgroundColor = .none
    $0.heightAnchor.constraint(equalToConstant: 250).isActive = true
  }
  
  private let targetTitle = UILabel().then {
    $0.text = "Target: 0 workouts"
    $0.textColor = .specialGray
    $0.font = .robotoBold16()
  }
  
  private let nowLabel = UILabel().then {
    $0.text = "10"
    $0.font = .robotoBold20()
    $0.textColor = .specialGray
  }
  
  private let targetValue = UILabel().then {
    $0.text = "20"
    $0.font = .robotoBold20()
    $0.textColor = .specialGray
  }
  
  private let targetView = UIView().then {
    $0.layer.cornerRadius = 15
    $0.backgroundColor = .specialBrown
  }
  
  private let progressView = UIProgressView(progressViewStyle: .bar).then {
    $0.trackTintColor = .specialBrown
    $0.progressTintColor = .specialGreen
    $0.layer.cornerRadius = 14
    $0.clipsToBounds = true
    $0.setProgress(0.1, animated: false)
    $0.layer.sublayers?[1].cornerRadius = 14
    $0.subviews[1].clipsToBounds = true
    $0.heightAnchor.constraint(equalToConstant: 28).isActive = true
  }
  override func viewDidLayoutSubviews() {
    setupUser()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    users = localRealm.objects(User.self)
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: idProfileCell)
    getWorkoutResults()
    configureUI()
  }
  
  @objc private func editingAction() {
    let viewController = SettingViewController()
    viewController.modalPresentationStyle = .fullScreen
    present(viewController, animated: true)
  }
  private func configureUI() {
    titleLabel.text = "PROFILE"
    closeButton.isHidden = true
    let heightStack = UIStackView(arrangedSubviews: [heightLabel, weightLabel], axis: .horizontal, spacing: 20)
    let infoStack = UIStackView(arrangedSubviews: [heightStack, editButton], axis: .horizontal)
    infoStack.distribution = .equalSpacing
    let targetStack = UIStackView(arrangedSubviews: [nowLabel, targetValue], axis: .horizontal)
    targetStack.distribution = .equalSpacing
    let stack = UIStackView(arrangedSubviews: [titleView, infoStack, collectionView, targetTitle, targetStack, progressView], axis: .vertical, spacing: 10)
    view.addSubview(stack)
    stack.anchor(top: titleLabel.bottomAnchor,
                 left: view.leftAnchor,
                 right: view.rightAnchor,
                 paddingTop: 10, paddingLeft: 10, paddingRight: 10)
  }
  
  private func setupUser() {
    if !users.isEmpty {
      let user = users[0]
      let name = user.firstname + " " + user.lastname
      guard let data = user.image else { return }
      guard let image = UIImage(data: data) else { return }
      titleView.configure(name: name, image: image)
      heightLabel.text = "Height: \(user.height)"
      weightLabel.text = "Weight: \(user.weight)"
      targetTitle.text = "Target: \(user.target) workouts"
      targetValue.text = "\(user.target)"
    }
  }
  private func getWorkoutsName() -> [String] {
    var names = [String]()
    workouts = localRealm.objects(Workout.self)
    for workout in workouts {
      if !names.contains(workout.name) {
        names.append(workout.name)
      }
    }
    return names
  }
  
  private func getWorkoutResults() {
    let names = getWorkoutsName()
    for name in names {
      let predicate = NSPredicate(format: "name = '\(name)'")
      workouts = localRealm.objects(Workout.self).filter(predicate).sorted(byKeyPath: "name")
      var result = 0
      workouts.forEach {
        result += $0.reps
      }
      guard let workout = workouts.first else { return }
      let resultModel = ResultWorkout(name: name, result: result, imageData: workout.image)
      results.append(resultModel)
    }
  }
}
// MARK: - UICollectionViewDataSource
extension ProfileViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let
    cell = collectionView.dequeueReusableCell(withReuseIdentifier: idProfileCell, for: indexPath) as! ProfileCollectionViewCell
    let result = results[indexPath.item]
    cell.configure(with: result)
    let item = indexPath.item % 4
    cell.backgroundColor = item == 0 || item == 3 ? .specialGreen : .specialDarkYellow
    return cell
  }
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
   return results.count
  }
  
}
// MARK: - UICollectionViewDelegate
extension ProfileViewController: UICollectionViewDelegate {
  
}
//MARK: - UICollectionViewDelegateFlowLayout

extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width / 2.07,
               height: 120)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        progressView.setProgress(0.6, animated: true)
    }
}
// MARK: - Profile
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
