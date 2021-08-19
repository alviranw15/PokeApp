//
//  DAOPokemonDetailGameIndices.swift
//
//  Created by Alvira Nurhaliza on 18/08/21
//  Copyright (c) . All rights reserved.
//

import Foundation

struct DAOPokemonDetailGameIndices: Codable {

  enum CodingKeys: String, CodingKey {
    case version
    case gameIndex = "game_index"
  }

  var version: DAOPokemonDetailVersion?
  var gameIndex: Int?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    version = try container.decodeIfPresent(DAOPokemonDetailVersion.self, forKey: .version)
    gameIndex = try container.decodeIfPresent(Int.self, forKey: .gameIndex)
  }

}
