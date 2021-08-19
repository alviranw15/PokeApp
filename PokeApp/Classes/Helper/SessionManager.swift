//
//  SessionManager.swift
//  PokeApp
//
//  Created by Alvira Nurhaliza on 19/08/21.
//

import Foundation
import SwiftyJSON

class SessionManager {
  
  static let instance = SessionManager()
  private var KEY_POKEMON_LIST = "KEY_POKEMON_LIST"
  
  private var pokemonList: [DAOPokemonListBaseClass]? {
    get {
      if let jsonArray = UserDefaults.standard.object(forKey: KEY_POKEMON_LIST) as? [[String : Any]] {
        var pokeList: [DAOPokemonListBaseClass] = []
        jsonArray.forEach { json in
          let jsonCon = JSON(json)
          let jsonData = (jsonCon.rawString() ?? "").data(using: .utf8)
          if let jsonData = jsonData, let obj = try? JSONDecoder().decode(DAOPokemonListBaseClass.self, from: jsonData) {
            pokeList.append(obj)
          } else {
            // do nothing
          }
        }
        return pokeList
      }
      else {
        return nil
      }
    }
    set {
      var pokemonStringAny: [[String: Any]] = []
      newValue?.forEach({ dao in
        pokemonStringAny.append(dao.dictionary ?? [:])
      })
      UserDefaults.standard.set(pokemonStringAny, forKey: KEY_POKEMON_LIST)
      UserDefaults.standard.synchronize()
    }
  }
  
  func getPokemonList() -> [DAOPokemonListBaseClass]? {
    return self.pokemonList
  }
  
  func setPokemonList(pokemonList: [DAOPokemonListBaseClass]) {
    SessionManager.instance.pokemonList = pokemonList
  }
  
}
