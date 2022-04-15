//
//  OnboardingCollectionViewCell.swift
//  Workouts
//
//  Created by Vladimir Fibe on 14.04.2022.
//

import UIKit
import SwiftUI
class OnboardingCollectionViewCell: UICollectionViewCell {
  private let backgroundImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFill
  }
  private let topLabel = UILabel().then {
    $0.textColor = .specialGreen
    $0.font = .robotoBold24()
    $0.textAlignment = .center
  }
  private let bottomLabel = UILabel().then {
    $0.textColor = .white
    $0.font = .robotoMedium16()
    $0.numberOfLines = 4
    $0.adjustsFontSizeToFitWidth = true
  }
  override init(frame: CGRect) {
      super.init(frame: frame)
      configureUI()
  }
  
  required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  func configureUI() {
    backgroundColor = .specialGreen
    addSubview(backgroundImageView)
    addSubview(topLabel)
    addSubview(bottomLabel)
    backgroundImageView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor)
    backgroundImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7).isActive = true
    topLabel.anchor(top: topAnchor,
                    left: leftAnchor,
                    right: rightAnchor,
                    paddingTop: 60, paddingLeft: 20, paddingRight: 20)
    bottomLabel.anchor(left: leftAnchor,
                       bottom: bottomAnchor,
                       right: rightAnchor,
                       paddingLeft: 20, paddingBottom: 20, paddingRight: 20,
                       height: 85)
  }
  func configure(with onboarding: Onboarding) {
    backgroundImageView.image = UIImage(named: onboarding.image)
    topLabel.text = onboarding.top
    bottomLabel.text = onboarding.bottom
  }
}

struct OnboardingCollectionViewCell_Previews: PreviewProvider {
  static var previews: some View {
    SwiftUIOnboardingViewController()
      .edgesIgnoringSafeArea(.all)
  }
}
