//
//  WorkerPokemon.swift
//  PokeApp
//
//  Created by Alvira Nurhaliza on 18/08/21.
//

import Alamofire
import Foundation

struct WorkerPokemon {
  
  static func doGetPokemonList(url: String, onRequest: @escaping onRequest, onSuccess: @escaping (_ result: DAOPokemonListBaseClass) -> Void, onFailed: @escaping onError) {
    Network.request(request: NetworkPokemon.doGetPokemonList(url: url), onRequest: { (request) in
      onRequest(request)
    }, onSuccess: { (json) in
      let jsonData = (json.rawString() ?? "").data(using: .utf8)
      if let jsonData = jsonData, let obj = try? JSONDecoder().decode(DAOPokemonListBaseClass.self, from: jsonData) {
        onSuccess(obj)
      } else {
        let errMessage = json["message"].string
        onFailed(errMessage ?? "", 0)
      }
    }) { (error, code) in
      onFailed(error, code)
    }
  }
  
  static func doGetPokemonDetail(url: String, group: DispatchGroup, onRequest: @escaping onRequest, onSuccess: @escaping (_ result: DAOPokemonDetailBaseClass) -> Void, onFailed: @escaping onError) {
    Network.request(request: NetworkPokemon.doGetPokemonList(url: url), onRequest: { (request) in
      onRequest(request)
    }, onSuccess: { (json) in
      let jsonData = (json.rawString() ?? "").data(using: .utf8)
      if let jsonData = jsonData, let obj = try? JSONDecoder().decode(DAOPokemonDetailBaseClass.self, from: jsonData) {
        onSuccess(obj)
        group.leave()
      } else {
        let errMessage = json["message"].string
        onFailed(errMessage ?? "", 0)
      }
    }) { (error, code) in
      onFailed(error, code)
    }
  }
  
}

extension Encodable {
  var dictionary: [String: Any]? {
    guard let data = try? JSONEncoder().encode(self) else { return nil }
    return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
  }
}
