//
//  StartViewController.swift
//  Workouts
//
//  Created by Vladimir Fibe on 10.04.2022.
//
import SwiftUI
import UIKit

class StartViewController: WOViewController {
  var sets = 0 {
    didSet {
      detailView.configure(sets: "\(sets)/\(workout.sets)")
    }
  }
  var showTimer: Bool {
    workout.timer != 0
  }
  var workout = Workout()
  var workoutAlert = WorkoutAlert()
  private lazy var girlView = UIImageView().then {
    let name = workout.timer == 0 ? "startgirl" : "ellipse"
    $0.image = UIImage(named: name)
  }
  private let timerLabel = UILabel("01:35").then {
    $0.textColor = .specialGray
    $0.font = .robotoBold48()
  }
  let shapeLayer = CAShapeLayer()
  var durationTimer = 0 {
    didSet {
      if showTimer {
        timerLabel.text = durationTimer.labelFromSecond()
      }
    }
  }
  let detailView = DetailView(frame: .zero)
  private lazy var finishButton = UIButton().then {
    $0.backgroundColor = .specialGreen
    $0.setTitle("FINISH", for: .normal)
    $0.tintColor = .white
    $0.titleLabel?.font = .robotoBold16()
    $0.layer.cornerRadius = 10
    $0.heightAnchor.constraint(equalToConstant: 55).isActive = true
    $0.addTarget(self, action: #selector(finishButtonTapped), for: .touchUpInside)
  }
  
  override func viewDidLayoutSubviews() {
    if showTimer {
      animationCircular()
    }
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    if showTimer {
      addTaps()
      girlView.addSubview(timerLabel)
      timerLabel.center(inView: girlView)
      durationTimer = workout.timer
      timerLabel.text = durationTimer.labelFromSecond()
    }
  }
  
  @objc func finishButtonTapped() {
    finish()
  }
  
  @objc private func timerAction() {
    if durationTimer > 0  {
      durationTimer -= 1
    } else {
      timer.invalidate()
      durationTimer = workout.timer
      detailView.configureNextSet()
      nextSet()
    }
  }
  @objc private func startTimer() {
    if timer.isValid {
      print("остановить анимацию")
    } else {
      basicAnimation()
      detailView.configureNextSet()
      timer = Timer.scheduledTimer(timeInterval: 1,
                                   target: self,
                                   selector: #selector(timerAction),
                                   userInfo: nil,
                                   repeats: true)
    }
  }
  
  
  private func addTaps() {
    let tapLabel = UITapGestureRecognizer(target: self, action: #selector(startTimer))
    girlView.isUserInteractionEnabled = true
    girlView.addGestureRecognizer(tapLabel)
  }
  
  func configure(with model: Workout) {
    workout = model
    detailView.configure(model: model, sets: sets)
  }
  
  private func configureUI() {
    titleLabel.text = "START WORKOUT"
    detailView.delegate = self
    let girlStack = UIStackView(arrangedSubviews: [girlView], axis: .vertical, spacing: 0)
    girlStack.alignment = .center
    let stack = UIStackView(arrangedSubviews: [girlStack, detailView, finishButton], axis: .vertical, spacing: 20)
    stack.alignment = .fill
    view.addSubview(stack)
    stack.anchor(top: titleLabel.bottomAnchor,
                 left: view.leftAnchor,
                 right: view.rightAnchor,
                 paddingTop: 20, paddingLeft: 20, paddingRight: 20)
    NSLayoutConstraint.activate([
      girlView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
      girlView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7)
    ])
  }
  // MARK: - Animation
  private func animationCircular() {
    let center = CGPoint(x: girlView.frame.width / 2, y: girlView.frame.height / 2)
    let endAngle = -CGFloat.pi / 2
    let startAngle = 2 * CGFloat.pi + endAngle
    let lineWidth = 21.0
    let circularPath = UIBezierPath(arcCenter: center,
                                    radius: center.x - (lineWidth / 2),
                                    startAngle: startAngle,
                                    endAngle: endAngle,
                                    clockwise: false)
    shapeLayer.path = circularPath.cgPath
    shapeLayer.lineWidth = lineWidth
    shapeLayer.fillColor = UIColor.clear.cgColor
    shapeLayer.strokeEnd = 1
    shapeLayer.lineCap = .round
    shapeLayer.strokeColor = UIColor.specialGreen.cgColor
    girlView.layer.addSublayer(shapeLayer)
  }
  
  private func basicAnimation() {
    let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
    basicAnimation.toValue = 0
    basicAnimation.duration = CFTimeInterval(durationTimer)
    basicAnimation.fillMode = .forwards
    basicAnimation.isRemovedOnCompletion = true
    shapeLayer.add(basicAnimation, forKey: "basicAnimation")
  }
}
// MARK: - StartWorkoutDelegate
extension StartViewController: DetailViewDelegate {
  func editSet() {
    workoutAlert.customAlert(self) { sets, reps in
      guard let numberOfSets = Int(sets) else { return }
      guard let numberOfReps = Int(reps) else { return }
      if self.workout.timer == 0 {
        RealmManager.shared.update(self.workout, sets: numberOfSets, reps: numberOfReps, timer: 0)
      } else {
        RealmManager.shared.update(self.workout, sets: numberOfSets, reps: 0, timer: numberOfReps)
      }
      self.sets = 0
      self.detailView.configure(model: self.workout, sets: self.sets)
    }
  }
  func finish() {
    alertOKCancel(title: "Завершить?", message: nil) {
      RealmManager.shared.update(self.workout)
      self.timer.invalidate()
      self.dismiss(animated: true)
    }
  }
  func nextSet() {
    sets += 1
    if sets == workout.sets {
      self.girlView.isUserInteractionEnabled = false
      self.detailView.configureNextSet(true)
      self.finish()
    }
  }
}
struct SwiftUIStartViewController: UIViewControllerRepresentable {
  typealias UIViewControllerType = StartViewController
  
  func makeUIViewController(context: Context) -> UIViewControllerType {
    let viewController = UIViewControllerType()
    return viewController
  }
  
  func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    
  }
}

struct StartViewController_Previews: PreviewProvider {
  static var previews: some View {
    SwiftUIStartViewController()
      .edgesIgnoringSafeArea(.all)
  }
}

