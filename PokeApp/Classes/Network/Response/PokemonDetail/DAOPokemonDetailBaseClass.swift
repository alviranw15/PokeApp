//
//  DAOPokemonDetailBaseClass.swift
//
//  Created by Alvira Nurhaliza on 18/08/21
//  Copyright (c) . All rights reserved.
//

import Foundation

struct DAOPokemonDetailBaseClass: Codable {

  enum CodingKeys: String, CodingKey {
    case species
    case sprites
    case order
    case pastTypes = "past_types"
    case abilities
    case weight
    case gameIndices = "game_indices"
    case stats
    case name
    case moves
    case locationAreaEncounters = "location_area_encounters"
    case heldItems = "held_items"
    case types
    case forms
    case id
    case isDefault = "is_default"
    case height
    case baseExperience = "base_experience"
  }

  var species: DAOPokemonDetailSpecies?
  var sprites: DAOPokemonDetailSprites?
  var order: Int?
  var pastTypes: [String]?
  var abilities: [DAOPokemonDetailAbilities]?
  var weight: Int?
  var gameIndices: [DAOPokemonDetailGameIndices]?
  var stats: [DAOPokemonDetailStats]?
  var name: String?
  var moves: [DAOPokemonDetailMoves]?
  var locationAreaEncounters: String?
  var heldItems: [String]?
  var types: [DAOPokemonDetailTypes]?
  var forms: [DAOPokemonDetailForms]?
  var id: Int?
  var isDefault: Bool?
  var height: Int?
  var baseExperience: Int?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    species = try container.decodeIfPresent(DAOPokemonDetailSpecies.self, forKey: .species)
    sprites = try container.decodeIfPresent(DAOPokemonDetailSprites.self, forKey: .sprites)
    order = try container.decodeIfPresent(Int.self, forKey: .order)
//    pastTypes = try container.decodeIfPresent([String].self, forKey: .pastTypes) // temporary
    abilities = try container.decodeIfPresent([DAOPokemonDetailAbilities].self, forKey: .abilities)
    weight = try container.decodeIfPresent(Int.self, forKey: .weight)
    gameIndices = try container.decodeIfPresent([DAOPokemonDetailGameIndices].self, forKey: .gameIndices)
    stats = try container.decodeIfPresent([DAOPokemonDetailStats].self, forKey: .stats)
    name = try container.decodeIfPresent(String.self, forKey: .name)
    moves = try container.decodeIfPresent([DAOPokemonDetailMoves].self, forKey: .moves)
    locationAreaEncounters = try container.decodeIfPresent(String.self, forKey: .locationAreaEncounters)
//    heldItems = try container.decodeIfPresent([String].self, forKey: .heldItems) // temporary
    types = try container.decodeIfPresent([DAOPokemonDetailTypes].self, forKey: .types)
    forms = try container.decodeIfPresent([DAOPokemonDetailForms].self, forKey: .forms)
    id = try container.decodeIfPresent(Int.self, forKey: .id)
    isDefault = try container.decodeIfPresent(Bool.self, forKey: .isDefault)
    height = try container.decodeIfPresent(Int.self, forKey: .height)
    baseExperience = try container.decodeIfPresent(Int.self, forKey: .baseExperience)
  }

}

