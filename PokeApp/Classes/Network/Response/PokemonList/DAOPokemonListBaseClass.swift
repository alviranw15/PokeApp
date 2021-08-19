//
//  DAOPokemonListBaseClass.swift
//
//  Created by Alvira Nurhaliza on 18/08/21
//  Copyright (c) . All rights reserved.
//

import Foundation

struct DAOPokemonListBaseClass: Codable {

  enum CodingKeys: String, CodingKey {
    case count
    case results
    case next
  }

  var count: Int?
  var results: [DAOPokemonListResults]?
  var next: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    count = try container.decodeIfPresent(Int.self, forKey: .count)
    results = try container.decodeIfPresent([DAOPokemonListResults].self, forKey: .results)
    next = try container.decodeIfPresent(String.self, forKey: .next)
  }

}
