//
//  NetworkError.swift
//  PokeApp
//
//  Created by Alvira Nurhaliza on 18/08/21.
//

import Foundation

public enum NetworkError: Equatable {
  case unknown
  case timeout
  case serverFailure(code: Int, message: String)
  case unauthorized
  
  func order() -> Int {
    switch self {
    case .unknown:
      return 1
    case .timeout:
      return 2
    case .serverFailure(let code, _):
      return code
    case .unauthorized:
      return 3
    }
  }
}

public func == (left: NetworkError, right: NetworkError) -> Bool {
  return left.order() == right.order()
}
