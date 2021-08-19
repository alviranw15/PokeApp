//
//  DAOPokemonDetailGenerationIv.swift
//
//  Created by Alvira Nurhaliza on 18/08/21
//  Copyright (c) . All rights reserved.
//

import Foundation

struct DAOPokemonDetailGenerationIv: Codable {

  enum CodingKeys: String, CodingKey {
    case diamondPearl = "diamond-pearl"
    case heartgoldSoulsilver = "heartgold-soulsilver"
    case platinum
  }

  var diamondPearl: DAOPokemonDetailDiamondPearl?
  var heartgoldSoulsilver: DAOPokemonDetailHeartgoldSoulsilver?
  var platinum: DAOPokemonDetailPlatinum?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    diamondPearl = try container.decodeIfPresent(DAOPokemonDetailDiamondPearl.self, forKey: .diamondPearl)
    heartgoldSoulsilver = try container.decodeIfPresent(DAOPokemonDetailHeartgoldSoulsilver.self, forKey: .heartgoldSoulsilver)
    platinum = try container.decodeIfPresent(DAOPokemonDetailPlatinum.self, forKey: .platinum)
  }

}
