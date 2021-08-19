//
//  DAOPokemonDetailFireredLeafgreen.swift
//
//  Created by Alvira Nurhaliza on 18/08/21
//  Copyright (c) . All rights reserved.
//

import Foundation

struct DAOPokemonDetailFireredLeafgreen: Codable {

  enum CodingKeys: String, CodingKey {
    case frontShiny = "front_shiny"
    case backShiny = "back_shiny"
    case frontDefault = "front_default"
    case backDefault = "back_default"
  }

  var frontShiny: String?
  var backShiny: String?
  var frontDefault: String?
  var backDefault: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    frontShiny = try container.decodeIfPresent(String.self, forKey: .frontShiny)
    backShiny = try container.decodeIfPresent(String.self, forKey: .backShiny)
    frontDefault = try container.decodeIfPresent(String.self, forKey: .frontDefault)
    backDefault = try container.decodeIfPresent(String.self, forKey: .backDefault)
  }

}
