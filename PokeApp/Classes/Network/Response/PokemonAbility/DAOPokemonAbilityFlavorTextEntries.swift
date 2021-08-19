//
//  DAOPokemonAbilityFlavorTextEntries.swift
//
//  Created by Alvira Nurhaliza on 18/08/21
//  Copyright (c) . All rights reserved.
//

import Foundation

struct DAOPokemonAbilityFlavorTextEntries: Codable {

  enum CodingKeys: String, CodingKey {
    case versionGroup = "version_group"
    case flavorText = "flavor_text"
    case language
  }

  var versionGroup: DAOPokemonAbilityVersionGroup?
  var flavorText: String?
  var language: DAOPokemonAbilityLanguage?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    versionGroup = try container.decodeIfPresent(DAOPokemonAbilityVersionGroup.self, forKey: .versionGroup)
    flavorText = try container.decodeIfPresent(String.self, forKey: .flavorText)
    language = try container.decodeIfPresent(DAOPokemonAbilityLanguage.self, forKey: .language)
  }

}
