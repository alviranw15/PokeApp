//
//  DAOPokemonDetailDiamondPearl.swift
//
//  Created by Alvira Nurhaliza on 18/08/21
//  Copyright (c) . All rights reserved.
//

import Foundation

struct DAOPokemonDetailDiamondPearl: Codable {

  enum CodingKeys: String, CodingKey {
    case backShiny = "back_shiny"
    case backDefault = "back_default"
    case frontDefault = "front_default"
    case frontShiny = "front_shiny"
  }

  var backShiny: String?
  var backDefault: String?
  var frontDefault: String?
  var frontShiny: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    backShiny = try container.decodeIfPresent(String.self, forKey: .backShiny)
    backDefault = try container.decodeIfPresent(String.self, forKey: .backDefault)
    frontDefault = try container.decodeIfPresent(String.self, forKey: .frontDefault)
    frontShiny = try container.decodeIfPresent(String.self, forKey: .frontShiny)
  }

}
