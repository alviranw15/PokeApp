//
//  DAOPokemonDetailAbilities.swift
//
//  Created by Alvira Nurhaliza on 18/08/21
//  Copyright (c) . All rights reserved.
//

import Foundation

struct DAOPokemonDetailAbilities: Codable {

  enum CodingKeys: String, CodingKey {
    case isHidden = "is_hidden"
    case slot
    case ability
  }

  var isHidden: Bool?
  var slot: Int?
  var ability: DAOPokemonDetailAbility?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    isHidden = try container.decodeIfPresent(Bool.self, forKey: .isHidden)
    slot = try container.decodeIfPresent(Int.self, forKey: .slot)
    ability = try container.decodeIfPresent(DAOPokemonDetailAbility.self, forKey: .ability)
  }

}
