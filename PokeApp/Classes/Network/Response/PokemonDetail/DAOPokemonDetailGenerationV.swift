//
//  DAOPokemonDetailGenerationV.swift
//
//  Created by Alvira Nurhaliza on 18/08/21
//  Copyright (c) . All rights reserved.
//

import Foundation

struct DAOPokemonDetailGenerationV: Codable {

  enum CodingKeys: String, CodingKey {
    case blackWhite = "black-white"
  }

  var blackWhite: DAOPokemonDetailBlackWhite?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    blackWhite = try container.decodeIfPresent(DAOPokemonDetailBlackWhite.self, forKey: .blackWhite)
  }

}
