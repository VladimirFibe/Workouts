//
//  ProfileCollectionViewCell.swift
//  Workouts
//
//  Created by Vladimir Fibe on 13.04.2022.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {
  private let nameLabel = UILabel().then {
    $0.textColor = .white
    $0.textAlignment = .center
    $0.font = .robotoBold24()
  }
  
  private let imageView = UIImageView().then {
    $0.tintColor = .white
    $0.contentMode = .scaleAspectFit
  }
  
  private let numberLabel = UILabel().then {
    $0.textColor = .white
    $0.textAlignment = .right
    $0.font = .robotoBold48()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configure(with result: ResultWorkout) {
    nameLabel.text = result.name
    imageView.image = UIImage(named: "workout1")?.withRenderingMode(.alwaysTemplate)
    numberLabel.text = "\(result.result)"
  }
  
  func configureUI() {
    layer.cornerRadius = 20
    backgroundColor = .specialDarkYellow
    addSubview(nameLabel)
    addSubview(imageView)
    addSubview(numberLabel)
    nameLabel.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingRight: 10)
    imageView.anchor(top: nameLabel.bottomAnchor, left: leftAnchor, paddingTop: 10, paddingLeft: 10, width: 57, height: 57)
    numberLabel.anchor(left: imageView.rightAnchor, right: rightAnchor, paddingLeft: 10, paddingRight: 10)
    numberLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
  }
  
}
