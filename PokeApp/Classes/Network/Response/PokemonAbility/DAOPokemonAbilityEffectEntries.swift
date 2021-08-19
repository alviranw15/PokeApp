//
//  DAOPokemonAbilityEffectEntries.swift
//
//  Created by Alvira Nurhaliza on 18/08/21
//  Copyright (c) . All rights reserved.
//

import Foundation

struct DAOPokemonAbilityEffectEntries: Codable {

  enum CodingKeys: String, CodingKey {
    case shortEffect = "short_effect"
    case effect
    case language
  }

  var shortEffect: String?
  var effect: String?
  var language: DAOPokemonAbilityLanguage?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    shortEffect = try container.decodeIfPresent(String.self, forKey: .shortEffect)
    effect = try container.decodeIfPresent(String.self, forKey: .effect)
    language = try container.decodeIfPresent(DAOPokemonAbilityLanguage.self, forKey: .language)
  }

}
