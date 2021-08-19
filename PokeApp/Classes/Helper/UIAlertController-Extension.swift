//
//  UIAlertController-Extension.swift
//  PokeApp
//
//  Created by Alvira Nurhaliza on 19/08/21.
//

import UIKit

public typealias alertAction = (UIAlertAction) -> Void

extension UIAlertController {
  public static func dialog(style: UIAlertController.Style, title: String?, message: String?, titleBtn1: String, titleBtn2: String?, styleBtn1: UIAlertAction.Style, styleBtn2: UIAlertAction.Style, handlerBtn1: alertAction?, handlerBtn2: alertAction?)-> UIAlertController {
    let alert = UIAlertController(title: title, message: message, preferredStyle: style)
    alert.addAction(UIAlertAction(title: titleBtn1, style: styleBtn1, handler: handlerBtn1))
    if let btn2 = titleBtn2, btn2 != "" {
      alert.addAction(UIAlertAction(title: btn2, style: styleBtn2, handler: handlerBtn2))
    }
    alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.destructive, handler: nil))
    return alert
  }
}
