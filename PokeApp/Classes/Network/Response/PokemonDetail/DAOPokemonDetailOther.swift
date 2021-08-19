//
//  DAOPokemonDetailOther.swift
//
//  Created by Alvira Nurhaliza on 18/08/21
//  Copyright (c) . All rights reserved.
//

import Foundation

struct DAOPokemonDetailOther: Codable {

  enum CodingKeys: String, CodingKey {
    case dreamWorld = "dream_world"
    case officialArtwork = "official-artwork"
  }

  var dreamWorld: DAOPokemonDetailDreamWorld?
  var officialArtwork: DAOPokemonDetailOfficialArtwork?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    dreamWorld = try container.decodeIfPresent(DAOPokemonDetailDreamWorld.self, forKey: .dreamWorld)
    officialArtwork = try container.decodeIfPresent(DAOPokemonDetailOfficialArtwork.self, forKey: .officialArtwork)
  }

}
