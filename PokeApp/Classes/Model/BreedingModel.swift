//
//  BreedingModel.swift
//  PokeApp
//
//  Created by Alvira Nurhaliza on 19/08/21.
//

import Foundation

struct BreedingModel {
  
  var eggGroup: String
  var hatchTime: String
  var gender: String
  
  init(eggGroup: String, hatchTime: String, gender: String) {
    self.eggGroup = eggGroup
    self.hatchTime = hatchTime
    self.gender = gender
  }
  
}
