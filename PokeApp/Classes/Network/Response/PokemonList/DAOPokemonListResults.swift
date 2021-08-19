//
//  DAOPokemonListResults.swift
//
//  Created by Alvira Nurhaliza on 18/08/21
//  Copyright (c) . All rights reserved.
//

import Foundation

struct DAOPokemonListResults: Codable {

  enum CodingKeys: String, CodingKey {
    case url
    case name
    case pokemonDetail
  }

  var url: String?
  var name: String?
  var pokemonDetail: DAOPokemonDetailBaseClass?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    url = try container.decodeIfPresent(String.self, forKey: .url)
    name = try container.decodeIfPresent(String.self, forKey: .name)
    pokemonDetail = try container.decodeIfPresent(DAOPokemonDetailBaseClass.self, forKey: .pokemonDetail)
  }

}
