//
//  WorkerPokemon.swift
//  PokeApp
//
//  Created by Alvira Nurhaliza on 18/08/21.
//

import Alamofire
import Foundation
import PromiseKit

struct WorkerPokemon {
  
  static func getPokemonAPI(url: String) -> Promise<DAOPokemonListBaseClass> {
    return firstly {
      URLSession.shared.dataTask(.promise, with: URL(string: url)!)
    }.compactMap {
      return try JSONDecoder().decode(DAOPokemonListBaseClass.self, from: $0.data)
    }
  }
  
  static func getPokemonDetailAPIs(url: String) -> Promise<DAOPokemonDetailBaseClass> {
    return firstly {
      URLSession.shared.dataTask(.promise, with: URL(string: url)!)
    }.compactMap {
      return try JSONDecoder().decode(DAOPokemonDetailBaseClass.self, from: $0.data)
    }
  }
  
  static func brokenPromise<T>(method: String = #function) -> Promise<T> {
    return Promise<T>() { seal in
      let err = NSError(domain: "WeatherOrNot", code: 0, userInfo: [NSLocalizedDescriptionKey: "'\(method)' not yet implemented."])
      seal.reject(err)
    }
  }
  
}

extension Encodable {
  var dictionary: [String: Any]? {
    guard let data = try? JSONEncoder().encode(self) else { return nil }
    return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
  }
}
