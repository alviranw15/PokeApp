//
//  DAOPokemonLanguageNames.swift
//
//  Created by Alvira Nurhaliza on 18/08/21
//  Copyright (c) . All rights reserved.
//

import Foundation

struct DAOPokemonLanguageNames: Codable {

  enum CodingKeys: String, CodingKey {
    case language
    case name
  }

  var language: DAOPokemonLanguageLanguage?
  var name: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    language = try container.decodeIfPresent(DAOPokemonLanguageLanguage.self, forKey: .language)
    name = try container.decodeIfPresent(String.self, forKey: .name)
  }

}
