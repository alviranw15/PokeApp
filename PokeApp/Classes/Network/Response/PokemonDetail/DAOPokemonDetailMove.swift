//
//  DAOPokemonDetailMove.swift
//
//  Created by Alvira Nurhaliza on 18/08/21
//  Copyright (c) . All rights reserved.
//

import Foundation

struct DAOPokemonDetailMove: Codable {

  enum CodingKeys: String, CodingKey {
    case url
    case name
  }

  var url: String?
  var name: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    url = try container.decodeIfPresent(String.self, forKey: .url)
    name = try container.decodeIfPresent(String.self, forKey: .name)
  }

}
