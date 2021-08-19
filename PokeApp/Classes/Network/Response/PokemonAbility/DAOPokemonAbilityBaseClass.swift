//
//  DAOPokemonAbilityBaseClass.swift
//
//  Created by Alvira Nurhaliza on 18/08/21
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

/*struct DAOPokemonAbilityBaseClass: Codable {

  enum CodingKeys: String, CodingKey {
    case name
    case pokemon
    case names
    case flavorTextEntries = "flavor_text_entries"
    case effectEntries = "effect_entries"
    case effectChanges = "effect_changes"
    case isMainSeries = "is_main_series"
    case id
    case generation
  }

  var name: String?
  var pokemon: [DAOPokemonAbilityPokemon]?
  var names: [DAOPokemonAbilityNames]?
  var flavorTextEntries: [DAOPokemonAbilityFlavorTextEntries]?
  var effectEntries: [DAOPokemonAbilityEffectEntries]?
  var effectChanges: Any?
  var isMainSeries: Bool?
  var id: Int?
  var generation: DAOPokemonAbilityGeneration?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    name = try container.decodeIfPresent(String.self, forKey: .name)
    pokemon = try container.decodeIfPresent([DAOPokemonAbilityPokemon].self, forKey: .pokemon)
    names = try container.decodeIfPresent([DAOPokemonAbilityNames].self, forKey: .names)
    flavorTextEntries = try container.decodeIfPresent([DAOPokemonAbilityFlavorTextEntries].self, forKey: .flavorTextEntries)
    effectEntries = try container.decodeIfPresent([DAOPokemonAbilityEffectEntries].self, forKey: .effectEntries)
    effectChanges = try container.decodeIfPresent([].self, forKey: .effectChanges)
    isMainSeries = try container.decodeIfPresent(Bool.self, forKey: .isMainSeries)
    id = try container.decodeIfPresent(Int.self, forKey: .id)
    generation = try container.decodeIfPresent(DAOPokemonAbilityGeneration.self, forKey: .generation)
  }

}
*/
