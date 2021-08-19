//
//  DAOPokemonDetailBlackWhite.swift
//
//  Created by Alvira Nurhaliza on 18/08/21
//  Copyright (c) . All rights reserved.
//

import Foundation

struct DAOPokemonDetailBlackWhite: Codable {

  enum CodingKeys: String, CodingKey {
    case backShiny = "back_shiny"
    case backDefault = "back_default"
    case animated
    case frontShiny = "front_shiny"
    case frontDefault = "front_default"
  }

  var backShiny: String?
  var backDefault: String?
  var animated: DAOPokemonDetailAnimated?
  var frontShiny: String?
  var frontDefault: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    backShiny = try container.decodeIfPresent(String.self, forKey: .backShiny)
    backDefault = try container.decodeIfPresent(String.self, forKey: .backDefault)
    animated = try container.decodeIfPresent(DAOPokemonDetailAnimated.self, forKey: .animated)
    frontShiny = try container.decodeIfPresent(String.self, forKey: .frontShiny)
    frontDefault = try container.decodeIfPresent(String.self, forKey: .frontDefault)
  }

}
