//
//  DAOPokemonDetailRedBlue.swift
//
//  Created by Alvira Nurhaliza on 18/08/21
//  Copyright (c) . All rights reserved.
//

import Foundation

struct DAOPokemonDetailRedBlue: Codable {

  enum CodingKeys: String, CodingKey {
    case backDefault = "back_default"
    case frontDefault = "front_default"
    case frontGray = "front_gray"
    case backGray = "back_gray"
  }

  var backDefault: String?
  var frontDefault: String?
  var frontGray: String?
  var backGray: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    backDefault = try container.decodeIfPresent(String.self, forKey: .backDefault)
    frontDefault = try container.decodeIfPresent(String.self, forKey: .frontDefault)
    frontGray = try container.decodeIfPresent(String.self, forKey: .frontGray)
    backGray = try container.decodeIfPresent(String.self, forKey: .backGray)
  }

}
