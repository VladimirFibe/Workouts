//
//  WeatherView.swift
//  Workouts
//
//  Created by Vladimir Fibe on 08.04.2022.
//
import SwiftUI
import UIKit

class WeatherView: UIView {

  private let pictureView = UIImageView(image: UIImage(named: "Sun"))
  private let titleLabel = UILabel().then {
    $0.text = "Солнечно"
    $0.font = .robotoMedium18()
    $0.textColor = .specialGray
  }
  private let subtitleLabel = UILabel().then {
    $0.text = "Хорошая погода, чтобы позаниматься на улице"
    $0.font = .robotoMedium18()
    $0.textColor = .specialGray
    $0.adjustsFontSizeToFitWidth = true
    $0.numberOfLines = 2
  }
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureUI() {
    backgroundColor = .white
    layer.cornerRadius = 10
    addShadowOnView()
    let titleStack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel], axis: .vertical, spacing: 1)
    
    let stack = UIStackView(arrangedSubviews: [titleStack, pictureView], axis: .horizontal, spacing: 5)
    addSubview(stack)
    stack.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 5)
  }

}

struct WeatherView_Previews: PreviewProvider {
  static var previews: some View {
    SwiftUIMainViewController()
      .edgesIgnoringSafeArea(.all)
  }
}
