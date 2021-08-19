//
//  PokemonModel.swift
//  PokeApp
//
//  Created by Alvira Nurhaliza on 18/08/21.
//

import Foundation

struct PokemonModel {
  
  var count: Int?
  var results: [DAOPokemonListResults]?
  var next: String?
  
  func convertFromDAO(_ dao: DAOPokemonListBaseClass) {
//    self.count = dao.count
//    self.next = dao.next
//    self.results = dao.
  }
  
}
