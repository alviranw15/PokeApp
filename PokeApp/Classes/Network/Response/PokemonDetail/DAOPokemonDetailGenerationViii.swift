//
//  DAOPokemonDetailGenerationViii.swift
//
//  Created by Alvira Nurhaliza on 18/08/21
//  Copyright (c) . All rights reserved.
//

import Foundation

struct DAOPokemonDetailGenerationViii: Codable {

  enum CodingKeys: String, CodingKey {
    case icons
  }

  var icons: DAOPokemonDetailIcons?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    icons = try container.decodeIfPresent(DAOPokemonDetailIcons.self, forKey: .icons)
  }

}
