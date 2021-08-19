//
//  DAOPokemonDetailAnimated.swift
//
//  Created by Alvira Nurhaliza on 18/08/21
//  Copyright (c) . All rights reserved.
//

import Foundation

struct DAOPokemonDetailAnimated: Codable {

  enum CodingKeys: String, CodingKey {
    case backDefault = "back_default"
    case backShiny = "back_shiny"
    case frontShiny = "front_shiny"
    case frontDefault = "front_default"
  }

  var backDefault: String?
  var backShiny: String?
  var frontShiny: String?
  var frontDefault: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    backDefault = try container.decodeIfPresent(String.self, forKey: .backDefault)
    backShiny = try container.decodeIfPresent(String.self, forKey: .backShiny)
    frontShiny = try container.decodeIfPresent(String.self, forKey: .frontShiny)
    frontDefault = try container.decodeIfPresent(String.self, forKey: .frontDefault)
  }

}
