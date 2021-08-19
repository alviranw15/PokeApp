//
//  CaptureModel.swift
//  PokeApp
//
//  Created by Alvira Nurhaliza on 19/08/21.
//

import Foundation

struct CaptureModel {
  
  var habitat: String
  var generation: String
  var captureRate: String
  
  init(habitat: String, generation: String, captureRate: String) {
    self.habitat = habitat
    self.generation = generation
    self.captureRate = captureRate
  }
  
}
