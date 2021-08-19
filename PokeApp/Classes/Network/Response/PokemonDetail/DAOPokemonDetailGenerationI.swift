//
//  DAOPokemonDetailGenerationI.swift
//
//  Created by Alvira Nurhaliza on 18/08/21
//  Copyright (c) . All rights reserved.
//

import Foundation

struct DAOPokemonDetailGenerationI: Codable {

  enum CodingKeys: String, CodingKey {
    case redBlue = "red-blue"
    case yellow
  }

  var redBlue: DAOPokemonDetailRedBlue?
  var yellow: DAOPokemonDetailYellow?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    redBlue = try container.decodeIfPresent(DAOPokemonDetailRedBlue.self, forKey: .redBlue)
    yellow = try container.decodeIfPresent(DAOPokemonDetailYellow.self, forKey: .yellow)
  }

}
