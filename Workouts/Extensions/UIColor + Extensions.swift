//
//  UIColor + Extensions.swift
//  Workouts
//
//  Created by Vladimir Fibe on 08.04.2022.
//

import SwiftUI

//#colorLiteral()

extension UIColor {
  static let specialBackground = #colorLiteral(red: 0.9411764706, green: 0.9294117647, blue: 0.8862745098, alpha: 1)
  static let specialGray = #colorLiteral(red: 0.3176470588, green: 0.3176470588, blue: 0.3137254902, alpha: 1)
  static let specialGreen = #colorLiteral(red: 0.2, green: 0.5529411765, blue: 0.4901960784, alpha: 1)
  static let specialDarkGreen = #colorLiteral(red: 0.1411764706, green: 0.2941176471, blue: 0.262745098, alpha: 1)
  static let specialYellow = #colorLiteral(red: 0.9921568627, green: 0.8392156863, blue: 0.3568627451, alpha: 1)
  static let specialDarkYellow = #colorLiteral(red: 0.9215686275, green: 0.7058823529, blue: 0.02352941176, alpha: 1)
  static let specialLightBrown = #colorLiteral(red: 0.7098039216, green: 0.6901960784, blue: 0.6196078431, alpha: 1)
  static let specialBrown = #colorLiteral(red: 0.9019607843, green: 0.8823529412, blue: 0.8196078431, alpha: 1)
  static let specialBlack = #colorLiteral(red: 0.2156862745, green: 0.2156862745, blue: 0.2156862745, alpha: 1)
  static let specialTabBar = #colorLiteral(red: 0.8039215686, green: 0.7803921569, blue: 0.7019607843, alpha: 1)
  static let specialLine = #colorLiteral(red: 0.768627451, green: 0.768627451, blue: 0.768627451, alpha: 1)
  static let specialHex = UIColor(hex: "FD475B")
  
  public convenience init(hex: String) {
    let r, g, b, a: CGFloat
    var hexColor: String
    if hex.hasPrefix("#") {
      let start = hex.index(hex.startIndex, offsetBy: 1)
      hexColor = String(hex[start...])
    } else {
      hexColor = hex
    }
    if hexColor.count == 6 {
      hexColor += "FF"
    }
    if hexColor.count == 8 {
      let scanner = Scanner(string: hexColor)
      var hexNumber: UInt64 = 0
      if scanner.scanHexInt64(&hexNumber) {
        r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
        g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
        b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
        a = CGFloat(hexNumber & 0x000000ff) / 255
        self.init(red: r, green: g, blue: b, alpha: a)
        return
      }
    }
    self.init(red: 1, green: 1, blue: 1, alpha: 1)
  }
}

struct UIColorView: View {
  let color = Color(.specialHex)
  var body: some View {
    VStack {
      Circle()
        .foregroundColor(color)
        .padding(70)
    }
  }
}

struct UIColorView_Previews: PreviewProvider {
  static var previews: some View {
    UIColorView()
  }
}
