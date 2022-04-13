//
//  CalendarView.swift
//  Workouts
//
//  Created by Vladimir Fibe on 08.04.2022.
//

import UIKit
import SwiftUI
protocol CalenderViewDelegate: AnyObject {
  func selectDate(_ date: Date)
}
class CalendarView: UIView {
  var week = [Days]()
  private let idCell = "idCalendarCell"
  weak var delegate: CalenderViewDelegate?
  
  private let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = .clear
    return collectionView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  private func configureUI() {
    backgroundColor = .specialGreen
    layer.cornerRadius = 10
    addSubview(collectionView)
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(CalendarCell.self, forCellWithReuseIdentifier: idCell)
    collectionView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 105, paddingBottom: 5, paddingRight: 10)
  }
}
// MARK: - UICollectionViewDataSource
extension CalendarView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    7
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idCell, for: indexPath) as! CalendarCell
    if indexPath.item == 0 {
      week = Date().getWeekArray()
    }
    let day = indexPath.item < week.count ? week[indexPath.item] : Days()
    cell.configure(with: day)
    if indexPath.item == 6 {
      collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .right)
    }
    return cell
  }
}

// MARK: - UICollectionViewDelegate
extension CalendarView: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let dateTimeZone = Date().localDate()
    delegate?.selectDate(dateTimeZone.offsetDays(6 - indexPath.item))
  }
}
// MARK: - UICollectionViewDelegateFlowLayout
extension CalendarView: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = (collectionView.frame.width - 18) / 7
    return CGSize(width: width, height: collectionView.frame.height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    3
  }
}
struct CalendarView_Previews: PreviewProvider {
  static var previews: some View {
    SwiftUIMainViewController()
      .edgesIgnoringSafeArea(.all)
  }
}
