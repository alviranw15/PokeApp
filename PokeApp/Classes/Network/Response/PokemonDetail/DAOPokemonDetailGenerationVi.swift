//
//  DAOPokemonDetailGenerationVi.swift
//
//  Created by Alvira Nurhaliza on 18/08/21
//  Copyright (c) . All rights reserved.
//

import Foundation

struct DAOPokemonDetailGenerationVi: Codable {

  enum CodingKeys: String, CodingKey {
    case omegarubyAlphasapphire = "omegaruby-alphasapphire"
    case xY = "x-y"
  }

  var omegarubyAlphasapphire: DAOPokemonDetailOmegarubyAlphasapphire?
  var xY: DAOPokemonDetailXY?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    omegarubyAlphasapphire = try container.decodeIfPresent(DAOPokemonDetailOmegarubyAlphasapphire.self, forKey: .omegarubyAlphasapphire)
    xY = try container.decodeIfPresent(DAOPokemonDetailXY.self, forKey: .xY)
  }

}
