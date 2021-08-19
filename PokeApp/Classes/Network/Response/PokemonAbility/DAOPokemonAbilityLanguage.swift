//
//  DAOPokemonAbilityLanguage.swift
//
//  Created by Alvira Nurhaliza on 18/08/21
//  Copyright (c) . All rights reserved.
//

import Foundation

struct DAOPokemonAbilityLanguage: Codable {

  enum CodingKeys: String, CodingKey {
    case name
    case url
  }

  var name: String?
  var url: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    name = try container.decodeIfPresent(String.self, forKey: .name)
    url = try container.decodeIfPresent(String.self, forKey: .url)
  }

}
