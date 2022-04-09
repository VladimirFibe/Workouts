//
//  WorkoutCell.swift
//  Workouts
//
//  Created by Vladimir Fibe on 10.04.2022.
//
import SwiftUI
import UIKit
protocol WorkoutCellDelegate: AnyObject {
  func startButtonTapped(_ model: Workout)
}
class WorkoutCell: UITableViewCell {
  var workout = Workout()
  weak var delegate: WorkoutCellDelegate?
  private let pictureView = UIImageView().then {
    $0.image = UIImage(named: "workout1")
    $0.contentMode = .scaleAspectFit
    $0.layer.cornerRadius = 20
  }
  
  private let backgroundPicture = UIView().then {
    $0.backgroundColor = .specialBackground
    $0.layer.cornerRadius = 20
  }
  
  private let backgroundCell = UIView().then {
    $0.backgroundColor = .specialBrown
    $0.layer.cornerRadius = 20
  }
  
  private let titleLabel = UILabel().then {
    $0.font = .robotoMedium22()
  }
  
  private let repsLabel = UILabel().then {
    $0.font = .robotoBold16()
  }
  
  private let setsLabel = UILabel().then {
    $0.font = .robotoMedium14()
  }
  
  private lazy var button = UIButton(type: .system).then {
    $0.titleLabel?.font = .robotoBold16()
    $0.layer.cornerRadius = 10
    $0.heightAnchor.constraint(equalToConstant: 30).isActive = true
    $0.addShadowOnView()
    $0.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  @objc func buttonTapped() {
    delegate?.startButtonTapped(workout)
  }
  
  func configure(with model: Workout) {
    workout = model
    titleLabel.text = model.name
    let timerString = "Timer \(model.timer.stringFromSeconds())"
    repsLabel.text = model.timer == 0 ? "Reps: \(model.reps)" : timerString
    setsLabel.text = "Sets: \(model.sets)"
    if model.status {
      button.setTitle("COMPLETE", for: .normal)
      button.backgroundColor = .specialGreen
      button.tintColor = .white
      button.isEnabled = false
    } else {
      button.setTitle("START", for: .normal)
      button.backgroundColor = .specialYellow
      button.tintColor = .specialDarkGreen
    }
    guard let data = model.image else { return }
    guard let image = UIImage(data: data) else { return }
    pictureView.image = image
  }
  
  func configureUI() {
    backgroundColor = .clear
    selectionStyle = .none
    let repsstack = UIStackView(arrangedSubviews: [repsLabel, setsLabel], axis: .horizontal)
    let titlestack = UIStackView(arrangedSubviews: [titleLabel, repsstack], axis: .vertical, spacing: 5)
    titlestack.alignment = .leading
    let buttonstack = UIStackView(arrangedSubviews: [titlestack, button], axis: .vertical, spacing: 5)
    let stack = UIStackView(arrangedSubviews: [backgroundPicture, buttonstack], axis: .horizontal)
    contentView.addSubview(backgroundCell)
    backgroundCell.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 0, paddingRight: 10)
    backgroundPicture.addSubview(pictureView)
    backgroundPicture.setDimensions(width: 70, height: 70)
    pictureView.center(inView: backgroundPicture)
    backgroundCell.addSubview(stack)
    stack.anchor(top: backgroundCell.topAnchor, left: backgroundCell.leftAnchor, bottom: backgroundCell.bottomAnchor, right: backgroundCell.rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 5)
    
  }
}

struct WorkoutCell_Previews: PreviewProvider {
  static var previews: some View {
    SwiftUIMainViewController()
      .edgesIgnoringSafeArea(.all)
  }
}
