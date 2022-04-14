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
  func alertPhoto(completion: @escaping (UIImagePickerController.SourceType) -> Void) {
    let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    let camera = UIAlertAction(title: "Camera", style: .default) { _ in
      completion(.camera)
    }
    let photo = UIAlertAction(title: "PhotoLibrary", style: .default) { _ in
      completion(.photoLibrary)
    }
    let cancel = UIAlertAction(title: "Cancel", style: .cancel)
    
    alertController.addAction(camera)
    alertController.addAction(photo)
    alertController.addAction(cancel)
    present(alertController, animated: true)
  }
}
