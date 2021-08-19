//
//  DAOPokemonDetailStats.swift
//
//  Created by Alvira Nurhaliza on 18/08/21
//  Copyright (c) . All rights reserved.
//

import Foundation

struct DAOPokemonDetailStats: Codable {

  enum CodingKeys: String, CodingKey {
    case effort
    case baseStat = "base_stat"
    case stat
  }

  var effort: Int?
  var baseStat: Int?
  var stat: DAOPokemonDetailStat?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    effort = try container.decodeIfPresent(Int.self, forKey: .effort)
    baseStat = try container.decodeIfPresent(Int.self, forKey: .baseStat)
    stat = try container.decodeIfPresent(DAOPokemonDetailStat.self, forKey: .stat)
  }

}
