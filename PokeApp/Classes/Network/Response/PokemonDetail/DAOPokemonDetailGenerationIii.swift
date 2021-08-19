//
//  DAOPokemonDetailGenerationIii.swift
//
//  Created by Alvira Nurhaliza on 18/08/21
//  Copyright (c) . All rights reserved.
//

import Foundation

struct DAOPokemonDetailGenerationIii: Codable {

  enum CodingKeys: String, CodingKey {
    case fireredLeafgreen = "firered-leafgreen"
    case emerald
    case rubySapphire = "ruby-sapphire"
  }

  var fireredLeafgreen: DAOPokemonDetailFireredLeafgreen?
  var emerald: DAOPokemonDetailEmerald?
  var rubySapphire: DAOPokemonDetailRubySapphire?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    fireredLeafgreen = try container.decodeIfPresent(DAOPokemonDetailFireredLeafgreen.self, forKey: .fireredLeafgreen)
    emerald = try container.decodeIfPresent(DAOPokemonDetailEmerald.self, forKey: .emerald)
    rubySapphire = try container.decodeIfPresent(DAOPokemonDetailRubySapphire.self, forKey: .rubySapphire)
  }

}
