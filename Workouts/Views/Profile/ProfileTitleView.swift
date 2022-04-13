//
//  ProfileTitleView.swift
//  Workouts
//
//  Created by Vladimir Fibe on 13.04.2022.
//

import UIKit

class ProfileTitleView: UIView {
  let diameter = 100.0

  private lazy var userPhotoImageView = UIImageView(image: UIImage(named: "avatar")).then {
    $0.backgroundColor = .systemGray4
    $0.layer.borderColor = UIColor.white.cgColor
    $0.clipsToBounds = true
    $0.layer.borderWidth = 5
    $0.layer.cornerRadius = diameter / 2
  }
  
  private let greenView = UIView().then {
    $0.backgroundColor = .specialGreen
    $0.layer.cornerRadius = 10
  }
  
  private let userNameLabel = UILabel().then {
    $0.text = "Брюс Уиллис"
    $0.textColor = .white
    $0.textAlignment = .center
    $0.font = .robotoMedium24()
    $0.minimumScaleFactor = 0.5
    $0.adjustsFontSizeToFitWidth = true
  }
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
  }
  
  func configure(name: String, image: UIImage) {
    userNameLabel.text = name
    userPhotoImageView.image = image
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  private func configureUI() {
    heightAnchor.constraint(equalToConstant: 162).isActive = true
    addSubview(greenView)
    addSubview(userPhotoImageView)
    addSubview(userNameLabel)
    greenView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 50)
    userPhotoImageView.setDimensions(width: diameter, height: diameter)
    userPhotoImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    userNameLabel.anchor(top: userPhotoImageView.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 16, paddingLeft: 20, paddingRight: 20)
  }
}
