//
//  DAOPokemonDetailSprites.swift
//
//  Created by Alvira Nurhaliza on 18/08/21
//  Copyright (c) . All rights reserved.
//

import Foundation

struct DAOPokemonDetailSprites: Codable {

  enum CodingKeys: String, CodingKey {
    case backDefault = "back_default"
    case frontDefault = "front_default"
    case other
    case frontShiny = "front_shiny"
    case versions
    case backShiny = "back_shiny"
  }

  var backDefault: String?
  var frontDefault: String?
  var other: DAOPokemonDetailOther?
  var frontShiny: String?
  var versions: DAOPokemonDetailVersions?
  var backShiny: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    backDefault = try container.decodeIfPresent(String.self, forKey: .backDefault)
    frontDefault = try container.decodeIfPresent(String.self, forKey: .frontDefault)
    other = try container.decodeIfPresent(DAOPokemonDetailOther.self, forKey: .other)
    frontShiny = try container.decodeIfPresent(String.self, forKey: .frontShiny)
    versions = try container.decodeIfPresent(DAOPokemonDetailVersions.self, forKey: .versions)
    backShiny = try container.decodeIfPresent(String.self, forKey: .backShiny)
  }

}
