//
//  SettingViewController.swift
//  Workouts
//
//  Created by Vladimir Fibe on 14.04.2022.
//

import UIKit
import SwiftUI
import RealmSwift

class SettingViewController: WOViewController {
  private var user = User()
  private let localRealm = try! Realm()
  private var users: Results<User>!
  private let titleView = ProfileTitleView().then {
    $0.configure(name: "", image: nil)
  }
  private let firstname = NameView().then {
    $0.configure(name: "First name", value: "")
  }
  private let lastname = NameView().then {
    $0.configure(name: "Last name", value: "")
  }
  private let height = NameView().then {
    $0.configure(name: "Height", value: "")
  }
  private let weight = NameView().then {
    $0.configure(name: "Weight", value: "")
  }
  private let target = NameView().then {
    $0.configure(name: "Target", value: "")
  }
  private lazy var saveButton = UIButton().then {
    $0.backgroundColor = .specialGreen
    $0.setTitle("SAVE", for: .normal)
    $0.tintColor = .white
    $0.titleLabel?.font = .robotoBold16()
    $0.layer.cornerRadius = 10
    $0.heightAnchor.constraint(equalToConstant: 55).isActive = true
    $0.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    users = localRealm.objects(User.self)
    configureUI()
    setupUser()
  }
  
  @objc func saveAction() {
    user.firstname = firstname.value
    user.lastname = lastname.value
    user.height = Int(height.value) ?? 0
    user.weight = Int(weight.value) ?? 0
    user.target = Int(target.value) ?? 0
    let data = titleView.userPhoto?.pngData()
    user.image = data
    RealmManager.shared.save(user)
    user = User()
    dismiss(animated: true)
  }
  
  @objc func setUserPhoto() {
    alertPhoto { [weak self] source in
      guard let self = self else { return }
      self.chooseImagePicker(source: source)
    }
  }
  
  private func setupUser() {
    if !users.isEmpty {
      let first = users[0]
      firstname.changeValue(first.firstname)
      lastname.changeValue(first.lastname)
      height.changeValue("\(first.height)")
      weight.changeValue("\(first.weight)")
      target.changeValue("\(first.target)")
      guard let data = first.image else { return }
      guard let image = UIImage(data: data) else { return }
      titleView.userPhoto = image
    }
  }
  private func addTaps() {
    let tapImage = UITapGestureRecognizer(target: self, action: #selector(setUserPhoto))
    titleView.userPhotoImageView.isUserInteractionEnabled = true
    titleView.userPhotoImageView.addGestureRecognizer(tapImage)
  }
  private func configureUI() {
    titleLabel.text = "EDITING PROFILE"
    addTaps()
    let stack = UIStackView(arrangedSubviews: [titleView, firstname, lastname, height, weight, target, saveButton], axis: .vertical, spacing: 20)
    view.addSubview(stack)
    stack.anchor(top: titleLabel.bottomAnchor,
                 left: view.leftAnchor,
                 right: view.rightAnchor,
                 paddingTop: 10, paddingLeft: 10, paddingRight: 10)
  }
}

// MARK: - UIImagePickerControllerDelegate
extension SettingViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  func chooseImagePicker(source: UIImagePickerController.SourceType) {
    if UIImagePickerController.isSourceTypeAvailable(source) {
      let imagePicker = UIImagePickerController()
      imagePicker.delegate = self
      imagePicker.allowsEditing = true
      imagePicker.sourceType = source
      present(imagePicker, animated: true)
    }
  }
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    let image = info[.editedImage] as? UIImage
    titleView.userPhoto = image
    dismiss(animated: true)
  }
}
// MARK: - Preview
struct SwiftUISettingViewController: UIViewControllerRepresentable {
  typealias UIViewControllerType = SettingViewController
  
  func makeUIViewController(context: Context) -> UIViewControllerType {
    let viewController = UIViewControllerType()
    return viewController
  }
  
  func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    
  }
}

struct SettingViewController_Previews: PreviewProvider {
  static var previews: some View {
    SwiftUISettingViewController()
      .edgesIgnoringSafeArea(.all)
  }
}

