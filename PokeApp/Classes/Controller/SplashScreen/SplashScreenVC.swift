//
//  SplashScreenVC.swift
//  PokeApp
//
//  Created by Alvira Nurhaliza on 17/08/21.
//

import UIKit

class SplashScreenVC: UIViewController {
  
  // MARK: - PROPERTIES
  var timer: Timer?
  
  // MARK: - OVERRIDE FUNCTIONS
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.setSplashScreenDuration()
  }
  
}

extension SplashScreenVC {
  
  func setSplashScreenDuration() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
      self.timer?.invalidate()
      self.timer = nil
      Wireframe.performToMain(caller: self)
    }
  }
  
}
