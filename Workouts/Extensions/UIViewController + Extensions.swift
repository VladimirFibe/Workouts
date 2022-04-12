//
//  UIViewController + Extensions.swift
//  Workouts
//
//  Created by Vladimir Fibe on 11.04.2022.
//

import UIKit

extension UIViewController {
  func alertOK(title: String, message: String?) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let ok = UIAlertAction(title: "OK", style: .default)
    alertController.addAction(ok)
    present(alertController, animated: true, completion: nil)
  }
  func alertOKCancel(title: String, message: String?, completion: @escaping () -> Void) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let ok = UIAlertAction(title: "OK", style: .default) { _ in
      completion()
    }
    let cancel = UIAlertAction(title: "Cancel", style: .cancel)
    alertController.addAction(ok)
    alertController.addAction(cancel)
    present(alertController, animated: true, completion: nil)
  }
}
