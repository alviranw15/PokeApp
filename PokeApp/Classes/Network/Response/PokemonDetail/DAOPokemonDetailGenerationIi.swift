//
//  DAOPokemonDetailGenerationIi.swift
//
//  Created by Alvira Nurhaliza on 18/08/21
//  Copyright (c) . All rights reserved.
//

import Foundation

struct DAOPokemonDetailGenerationIi: Codable {

  enum CodingKeys: String, CodingKey {
    case silver
    case gold
    case crystal
  }

  var silver: DAOPokemonDetailSilver?
  var gold: DAOPokemonDetailGold?
  var crystal: DAOPokemonDetailCrystal?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    silver = try container.decodeIfPresent(DAOPokemonDetailSilver.self, forKey: .silver)
    gold = try container.decodeIfPresent(DAOPokemonDetailGold.self, forKey: .gold)
    crystal = try container.decodeIfPresent(DAOPokemonDetailCrystal.self, forKey: .crystal)
  }

}
