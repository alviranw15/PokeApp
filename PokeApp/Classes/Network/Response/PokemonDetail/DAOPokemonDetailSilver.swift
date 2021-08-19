//
//  DAOPokemonDetailSilver.swift
//
//  Created by Alvira Nurhaliza on 18/08/21
//  Copyright (c) . All rights reserved.
//

import Foundation

struct DAOPokemonDetailSilver: Codable {

  enum CodingKeys: String, CodingKey {
    case frontDefault = "front_default"
    case frontShiny = "front_shiny"
    case backShiny = "back_shiny"
    case backDefault = "back_default"
  }

  var frontDefault: String?
  var frontShiny: String?
  var backShiny: String?
  var backDefault: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    frontDefault = try container.decodeIfPresent(String.self, forKey: .frontDefault)
    frontShiny = try container.decodeIfPresent(String.self, forKey: .frontShiny)
    backShiny = try container.decodeIfPresent(String.self, forKey: .backShiny)
    backDefault = try container.decodeIfPresent(String.self, forKey: .backDefault)
  }

}
