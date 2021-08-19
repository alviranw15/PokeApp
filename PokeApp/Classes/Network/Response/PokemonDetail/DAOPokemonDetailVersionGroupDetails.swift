//
//  DAOPokemonDetailVersionGroupDetails.swift
//
//  Created by Alvira Nurhaliza on 18/08/21
//  Copyright (c) . All rights reserved.
//

import Foundation

struct DAOPokemonDetailVersionGroupDetails: Codable {

  enum CodingKeys: String, CodingKey {
    case levelLearnedAt = "level_learned_at"
    case moveLearnMethod = "move_learn_method"
    case versionGroup = "version_group"
  }

  var levelLearnedAt: Int?
  var moveLearnMethod: DAOPokemonDetailMoveLearnMethod?
  var versionGroup: DAOPokemonDetailVersionGroup?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    levelLearnedAt = try container.decodeIfPresent(Int.self, forKey: .levelLearnedAt)
    moveLearnMethod = try container.decodeIfPresent(DAOPokemonDetailMoveLearnMethod.self, forKey: .moveLearnMethod)
    versionGroup = try container.decodeIfPresent(DAOPokemonDetailVersionGroup.self, forKey: .versionGroup)
  }

}
