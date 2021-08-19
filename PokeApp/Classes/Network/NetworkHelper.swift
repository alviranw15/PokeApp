//
//  NetworkHelper.swift
//  PokeApp
//
//  Created by Alvira Nurhaliza on 18/08/21.
//

import Alamofire
import Foundation
import SwiftyJSON

let SUCCESS = "success"
let NETWORK_ERROR = "Tidak ada koneksi"
let SYSTEM_ERROR = "Terjadi kesalahan sistem"

public typealias onRequest = (_ onRequest: DataRequest) -> Void
public typealias onError = (_ message: String, _ code: Int?) -> Void

extension NetworkError {
    var message : String {
        switch self {
        case .serverFailure( _, let message):
            return message
        case .timeout:
            return "Request timeout"
        case .unauthorized:
            return "Unauthorized"
        case .unknown:
            return "Oops! Something went wrong..."
        }
    }
}

public struct Network {
    
    public static func isLogin() -> Bool {
//        return Preference.getBool(key: Preference.KEY_LOGIN)
      return true
    }
    
//    public static func getToken() -> String {
//        if GITSNet.isLogin() {
//            let token = Preference.getString(key: Preference.KEY_APP_TOKEN)
//            if token != "" {
//                return token
//            } else {
//                return ""
//            }
//        }
//        return ""
//    }
    
    public static func request(
        request:URLRequestConvertible,
        onRequest: @escaping (_ request: DataRequest) -> Void,
        onSuccess: @escaping (_ response: JSON) -> Void,
        onFailure: @escaping (_ response: String, _ code: Int?) -> Void) {
        
        let req: URLRequest?
        do {
            req = try request.asURLRequest()
        } catch  {
            req = nil
        }
        
        let runRequest = Rest.runRequest(urlRequest: req!, jsonValidation: { json in
            return nil
        }) { error, json, code in
            if error == nil {
                print("JSON Result => \(String(describing: json!))" )
                onSuccess(json!)
            }else if let err = error {
                print("JSON Error => \(err.message) \(code)" )
                if err.message.lowercased() != "cancelled" {
                    onFailure(err.message, code)
                }
            }
        }
        onRequest(runRequest)
    }
    
    public static func uploadRequest(
        request: URLRequestConvertible,
        multipartFormData: @escaping (MultipartFormData) -> Void,
        onRequest: @escaping onRequest,
        onSuccess: @escaping (_ response: JSON) -> Void,
        onFailure: @escaping (_ response: String, _ code: Int?) -> Void) {
        let req: URLRequest?
        do {
            req = try request.asURLRequest()
        } catch  {
            req = nil
        }
        
        Alamofire.upload(multipartFormData: multipartFormData, with: req!) { (encodingResult) in
            switch encodingResult {
            case .success(let upload, _, _ ):
                let runRequest = upload.responseJSON { response in
                    var json : JSON?
                    var err : NetworkError?
                    var code: Int?
                    switch response.result {
                    case .success(let value) :
                        json = JSON(value)
                    case .failure(let error) :
                        let nserror = error as NSError
                        code = nserror.code
                        if nserror.code == -1001 {
                            err = .timeout
                        } else if nserror.code == 401 {
                            err = .unauthorized
                        } else {
                            err = .serverFailure(code: nserror.code, message: nserror.localizedDescription)
                        }
                    }
                    if err == nil {
                        print("JSON Result => \(String(describing: json!))" )
                        onSuccess(json!)
                    } else if let err = err {
                        print("JSON Error => \(err.message) \(code)" )
                        if err.message.lowercased() != "cancelled" {
                            onFailure(err.message, code)
                        }
                    }
                }
                onRequest(runRequest)
            case .failure(let encodingError):
                print("===Failure Encoding===")
                print(encodingError)
                onFailure(encodingError.localizedDescription, nil)
            }
        }
    }
    
    public static func cancelRequest() {
        Alamofire.SessionManager.default.session.getTasksWithCompletionHandler { (sessionDataTask, uploadData, downloadData) in
            sessionDataTask.forEach {
                $0.cancel()
            }
            uploadData.forEach {
                $0.cancel()
            }
            downloadData.forEach {
                $0.cancel()
            }
        }
    }
}
