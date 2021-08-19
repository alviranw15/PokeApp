//
//  DAOPokemonLanguageBaseClass.swift
//
//  Created by Alvira Nurhaliza on 18/08/21
//  Copyright (c) . All rights reserved.
//

import Foundation

struct DAOPokemonLanguageBaseClass: Codable {

  enum CodingKeys: String, CodingKey {
    case iso3166
    case id
    case names
    case iso639
    case official
    case name
  }

  var iso3166: String?
  var id: Int?
  var names: [DAOPokemonLanguageNames]?
  var iso639: String?
  var official: Bool?
  var name: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    iso3166 = try container.decodeIfPresent(String.self, forKey: .iso3166)
    id = try container.decodeIfPresent(Int.self, forKey: .id)
    names = try container.decodeIfPresent([DAOPokemonLanguageNames].self, forKey: .names)
    iso639 = try container.decodeIfPresent(String.self, forKey: .iso639)
    official = try container.decodeIfPresent(Bool.self, forKey: .official)
    name = try container.decodeIfPresent(String.self, forKey: .name)
  }

}
