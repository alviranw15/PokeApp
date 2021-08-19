//
//  NetworkPokemon.swift
//  PokeApp
//
//  Created by Alvira Nurhaliza on 18/08/21.
//

import Alamofire
import Foundation

public enum NetworkPokemon: URLRequestConvertible {
  
  static let baseURLString = ""
  
  case doGetPokemonList(url: String)
  
  var method: HTTPMethod {
    switch self {
    case .doGetPokemonList:
      return .get
    }
  }
  
  var res: (path: String, param: [String: Any], token: String) {
    switch self {
    case .doGetPokemonList(let url):
      return (path: url, param: [:], token: "")
    }
  }
  
  public func asURLRequest() throws -> URLRequest {
    var url: URL?
    var urlRequest: URLRequest?
//    url = try NetworkPokemon.baseURLString.asURL()
//    urlRequest = URLRequest(url: (url?.appendingPathComponent(res.path))!)
    url = try res.path.asURL()
    urlRequest = URLRequest(url: url!)
    urlRequest?.httpMethod = method.rawValue
    if !res.token.isEmpty {
      urlRequest?.setValue("Bearer \(res.token)", forHTTPHeaderField: "Authorization")
    }
    urlRequest = try URLEncoding(destination: .queryString).encode(urlRequest!, with: res.param)
    print("URL API => "+(urlRequest?.url?.absoluteString)!)
    print("Parameter => \(res.param)")
    print("Token: \(res.token)")
    return urlRequest!
  }
  
}
