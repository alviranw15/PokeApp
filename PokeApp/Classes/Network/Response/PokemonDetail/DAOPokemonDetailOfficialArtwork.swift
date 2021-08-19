//
//  DAOPokemonDetailOfficialArtwork.swift
//
//  Created by Alvira Nurhaliza on 18/08/21
//  Copyright (c) . All rights reserved.
//

import Foundation

struct DAOPokemonDetailOfficialArtwork: Codable {

  enum CodingKeys: String, CodingKey {
    case frontDefault = "front_default"
  }

  var frontDefault: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    frontDefault = try container.decodeIfPresent(String.self, forKey: .frontDefault)
  }

}
