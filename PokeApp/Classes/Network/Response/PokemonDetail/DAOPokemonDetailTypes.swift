//
//  DAOPokemonDetailTypes.swift
//
//  Created by Alvira Nurhaliza on 18/08/21
//  Copyright (c) . All rights reserved.
//

import Foundation

struct DAOPokemonDetailTypes: Codable {

  enum CodingKeys: String, CodingKey {
    case type
    case slot
  }

  var type: DAOPokemonDetailType?
  var slot: Int?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    type = try container.decodeIfPresent(DAOPokemonDetailType.self, forKey: .type)
    slot = try container.decodeIfPresent(Int.self, forKey: .slot)
  }

}
