//
//  DAOPokemonDetailGenerationVii.swift
//
//  Created by Alvira Nurhaliza on 18/08/21
//  Copyright (c) . All rights reserved.
//

import Foundation

struct DAOPokemonDetailGenerationVii: Codable {

  enum CodingKeys: String, CodingKey {
    case ultraSunUltraMoon = "ultra-sun-ultra-moon"
    case icons
  }

  var ultraSunUltraMoon: DAOPokemonDetailUltraSunUltraMoon?
  var icons: DAOPokemonDetailIcons?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    ultraSunUltraMoon = try container.decodeIfPresent(DAOPokemonDetailUltraSunUltraMoon.self, forKey: .ultraSunUltraMoon)
    icons = try container.decodeIfPresent(DAOPokemonDetailIcons.self, forKey: .icons)
  }

}
