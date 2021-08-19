//
//  DAOPokemonAbilityNames.swift
//
//  Created by Alvira Nurhaliza on 18/08/21
//  Copyright (c) . All rights reserved.
//

import Foundation

struct DAOPokemonAbilityNames: Codable {

  enum CodingKeys: String, CodingKey {
    case name
    case language
  }

  var name: String?
  var language: DAOPokemonAbilityLanguage?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    name = try container.decodeIfPresent(String.self, forKey: .name)
    language = try container.decodeIfPresent(DAOPokemonAbilityLanguage.self, forKey: .language)
  }

}
