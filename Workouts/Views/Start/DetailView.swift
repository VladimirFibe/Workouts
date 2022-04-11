//
//  DetailView.swift
//  Workouts
//
//  Created by Vladimir Fibe on 11.04.2022.
//

import UIKit
import SwiftUI

protocol DetailViewDelegate: AnyObject {
  func nextSet()
  func editSet()
}
class DetailView: TitleView {
  weak var delegate: DetailViewDelegate?
  private let bicepsLabel = UILabel().then {
    $0.text = "Biceps"
    $0.font = .robotoMedium24()
    $0.textColor = .specialGray
    $0.textAlignment = .center
    $0.adjustsFontSizeToFitWidth = true
  }
  private let setsView = DetailRowView()
  
  private let repsView = DetailRowView()
  
  private lazy var editButton = UIButton(type: .system).then {
    $0.setImage(UIImage(systemName: "pencil"), for: .normal)
    $0.setTitle("Editing", for: .normal)
    $0.tintColor = .specialLightBrown
    $0.addTarget(self, action: #selector(showEdit), for: .touchUpInside)
  }
  
  private lazy var nextButton = UIButton(type: .system).then {
    $0.setTitle("NEXT SET", for: .normal)
    $0.backgroundColor = .specialYellow
    $0.tintColor = .specialGray
    $0.titleLabel?.font = .robotoBold16()
    $0.layer.cornerRadius = 10
    $0.heightAnchor.constraint(equalToConstant: 43).isActive = true
    $0.addTarget(self, action: #selector(nextSetButtonTapped), for: .touchUpInside)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  @objc func showEdit() {
    delegate?.editSet()
  }

  @objc func nextSetButtonTapped() {
    delegate?.nextSet()
  }
  
  func configureNextSet(_ gameOver: Bool = false) {
    if gameOver {
      nextButton.isEnabled = false
      editButton.isEnabled = false
    } else {
      nextButton.isEnabled.toggle()
      editButton.isEnabled.toggle()
    }
  }
  func configure(sets: String) {
    setsView.configureWith(name: "Sets", value: sets)
  }
  func configure(reps: String) {
    repsView.configureWith(name: "Reps", value: reps)
  }
  func configure(model: Workout, sets: Int) {
    bicepsLabel.text = model.name
    setsView.configureWith(name: "Sets", value: "\(sets)/\(model.sets)")
    if model.timer == 0 {
      repsView.configureWith(name: "Reps", value: "\(model.reps)")
    } else {
      let value = model.timer.stringFromSeconds()
      repsView.configureWith(name: "Time of Set", value: value)
    }
  }

  func configureUI() {
    titleLabel.text = "Details"
    heightAnchor.constraint(equalToConstant: 250).isActive = true

    let editStack = UIStackView(arrangedSubviews: [editButton], axis: .vertical, spacing: 0)
    editStack.alignment = .trailing
    let stack = UIStackView(arrangedSubviews: [bicepsLabel, setsView, repsView, editStack, nextButton], axis: .vertical)
    roundRect.addSubview(stack)
    stack.anchor(top: roundRect.topAnchor, left: roundRect.leftAnchor, right: roundRect.rightAnchor, paddingTop: 10, paddingLeft: 15, paddingRight: 15)
  }
}

struct DetailView_Previews: PreviewProvider {
  static var previews: some View {
    SwiftUIStartViewController()
      .edgesIgnoringSafeArea(.all)
  }
}
