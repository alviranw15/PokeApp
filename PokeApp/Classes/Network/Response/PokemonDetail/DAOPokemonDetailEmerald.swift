//
//  DAOPokemonDetailEmerald.swift
//
//  Created by Alvira Nurhaliza on 18/08/21
//  Copyright (c) . All rights reserved.
//

import Foundation

struct DAOPokemonDetailEmerald: Codable {

  enum CodingKeys: String, CodingKey {
    case frontDefault = "front_default"
    case frontShiny = "front_shiny"
  }

  var frontDefault: String?
  var frontShiny: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    frontDefault = try container.decodeIfPresent(String.self, forKey: .frontDefault)
    frontShiny = try container.decodeIfPresent(String.self, forKey: .frontShiny)
  }

}
