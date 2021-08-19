//
//  Rest.swift
//  PokeApp
//
//  Created by Alvira Nurhaliza on 18/08/21.
//

import Alamofire
import Foundation
import SwiftyJSON

public class Rest {
  
  private static var Manager: Alamofire.SessionManager = {
    // Create the server trust policies
    let serverTrustPolicies: [String: ServerTrustPolicy] = [
      "103.99.84.22": .disableEvaluation
    ]
    
    // Create custom manager
    let configuration = URLSessionConfiguration.default
    configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
    let manager = Alamofire.SessionManager(
      configuration: URLSessionConfiguration.default,
      serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
    )
    
    return manager
  }()
  
  public static func runRequest(urlRequest: URLRequest, jsonValidation : ((JSON) -> (NetworkError?))? = nil, callback : @escaping (NetworkError?, JSON?, Int?) -> ()) -> DataRequest {
    let delegate: Alamofire.SessionDelegate = Rest.Manager.delegate
    delegate.sessionDidReceiveChallenge = { session, challenge in
      var disposition: URLSession.AuthChallengeDisposition = .performDefaultHandling
      var credential: URLCredential?
      if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
        disposition = URLSession.AuthChallengeDisposition.useCredential
        credential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
      } else {
        if challenge.previousFailureCount > 0 {
          disposition = .cancelAuthenticationChallenge
        } else {
          credential = Rest.Manager.session.configuration.urlCredentialStorage?.defaultCredential(for: challenge.protectionSpace)
          if credential != nil {
            disposition = .useCredential
          }
        }
      }
      return (disposition, credential)
    }
    
    let req_ = Rest.Manager.request(urlRequest).responseJSON { (response) in
      var json: JSON?
      var err: NetworkError?
      var code: Int?
      switch response.result {
      case .success(let value) :
        json = JSON(value)
      case .failure(let error) :
        let error = error as NSError
        code = error.code
        if error.code == -1001 {
          err = .timeout
        } else if error.code == 401 {
          err = .unauthorized
        } else {
          err = .serverFailure(code: error.code, message: error.localizedDescription)
        }
        
      }
      
      if let validator = jsonValidation, let jsonData = json, err == nil
      {
        if let error = validator(jsonData)
        {
          code = nil
          err = error
        }
      }
      
      callback(err, json, code)
    }
    return req_
  }
}
