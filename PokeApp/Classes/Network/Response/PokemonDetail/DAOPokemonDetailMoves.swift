//
//  DAOPokemonDetailMoves.swift
//
//  Created by Alvira Nurhaliza on 18/08/21
//  Copyright (c) . All rights reserved.
//

import Foundation

struct DAOPokemonDetailMoves: Codable {

  enum CodingKeys: String, CodingKey {
    case move
    case versionGroupDetails = "version_group_details"
  }

  var move: DAOPokemonDetailMove?
  var versionGroupDetails: [DAOPokemonDetailVersionGroupDetails]?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    move = try container.decodeIfPresent(DAOPokemonDetailMove.self, forKey: .move)
    versionGroupDetails = try container.decodeIfPresent([DAOPokemonDetailVersionGroupDetails].self, forKey: .versionGroupDetails)
  }

}
