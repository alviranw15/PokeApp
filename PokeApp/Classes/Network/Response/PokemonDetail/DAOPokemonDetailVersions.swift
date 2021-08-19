//
//  DAOPokemonDetailVersions.swift
//
//  Created by Alvira Nurhaliza on 18/08/21
//  Copyright (c) . All rights reserved.
//

import Foundation

struct DAOPokemonDetailVersions: Codable {

  enum CodingKeys: String, CodingKey {
    case generationI = "generation-i"
    case generationViii = "generation-viii"
    case generationVi = "generation-vi"
    case generationIi = "generation-ii"
    case generationIv = "generation-iv"
    case generationV = "generation-v"
    case generationVii = "generation-vii"
    case generationIii = "generation-iii"
  }

  var generationI: DAOPokemonDetailGenerationI?
  var generationViii: DAOPokemonDetailGenerationViii?
  var generationVi: DAOPokemonDetailGenerationVi?
  var generationIi: DAOPokemonDetailGenerationIi?
  var generationIv: DAOPokemonDetailGenerationIv?
  var generationV: DAOPokemonDetailGenerationV?
  var generationVii: DAOPokemonDetailGenerationVii?
  var generationIii: DAOPokemonDetailGenerationIii?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    generationI = try container.decodeIfPresent(DAOPokemonDetailGenerationI.self, forKey: .generationI)
    generationViii = try container.decodeIfPresent(DAOPokemonDetailGenerationViii.self, forKey: .generationViii)
    generationVi = try container.decodeIfPresent(DAOPokemonDetailGenerationVi.self, forKey: .generationVi)
    generationIi = try container.decodeIfPresent(DAOPokemonDetailGenerationIi.self, forKey: .generationIi)
    generationIv = try container.decodeIfPresent(DAOPokemonDetailGenerationIv.self, forKey: .generationIv)
    generationV = try container.decodeIfPresent(DAOPokemonDetailGenerationV.self, forKey: .generationV)
    generationVii = try container.decodeIfPresent(DAOPokemonDetailGenerationVii.self, forKey: .generationVii)
    generationIii = try container.decodeIfPresent(DAOPokemonDetailGenerationIii.self, forKey: .generationIii)
  }

}
