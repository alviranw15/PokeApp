//
//  NetworkOperation.swift
//  PokeApp
//
//  Created by Alvira Nurhaliza on 18/08/21.
//

import Alamofire
import Foundation
import SwiftyJSON

class NetworkOperation: AsynchronousOperation {
  
  // define properties to hold everything that you'll supply when you instantiate
  // this object and will be used when the request finally starts
  //
  // in this example, I'll keep track of (a) URL; and (b) closure to call when request is done
  
  private let urlString: String
  private var networkOperationCompletionHandler: ((_ url: String, _ responseObject: JSON?, _ error: Error?) -> Void)?
  
  // we'll also keep track of the resulting request operation in case we need to cancel it later
  
  weak var request: Alamofire.Request?
  
  // define init method that captures all of the properties to be used when issuing the request
  
  init(urlString: String, networkOperationCompletionHandler: ((_ url: String, _ responseObject: JSON?, _ error: Error?) -> Void)? = nil) {
    self.urlString = urlString
    self.networkOperationCompletionHandler = networkOperationCompletionHandler
    super.init()
  }
  
  // when the operation actually starts, this is the method that will be called
  
  override func main() {
    request = Alamofire.request(urlString, method: .get, parameters: ["foo" : "bar"])
      .responseJSON { response in
        // do whatever you want here; personally, I'll just all the completion handler that was passed to me in `init`
        
        self.networkOperationCompletionHandler?(self.urlString, JSON(response.result.value), response.result.error)
        self.networkOperationCompletionHandler = nil
        
        // now that I'm done, complete this operation
        
        self.completeOperation()
      }
  }
  
  // we'll also support canceling the request, in case we need it
  
  override func cancel() {
    request?.cancel()
    super.cancel()
  }
}
