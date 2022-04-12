//
//  TitleView.swift
//  Workouts
//
//  Created by Vladimir Fibe on 10.04.2022.
//
import SwiftUI
import UIKit

class TitleView: UIView {
  let titleLabel = UILabel("Title")
  let roundRect = UIView(frame: .zero).then {
    $0.backgroundColor = .specialBrown
    $0.layer.cornerRadius = 10
  }
  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubview(titleLabel)
    addSubview(roundRect)
    titleLabel.anchor(top: topAnchor, left: leftAnchor, paddingLeft: 5)
    roundRect.anchor(top: titleLabel.bottomAnchor,
                     left: leftAnchor,
                     bottom: bottomAnchor,
                     right: rightAnchor,
                     paddingTop: 5)
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

struct TitleView_Previews: PreviewProvider {
  static var previews: some View {
    SwiftUIStartViewController()
      .edgesIgnoringSafeArea(.all)
  }
}
