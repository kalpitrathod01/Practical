//
//  SignupManager.swift
//  Mensa
//
//  Created by social in on 18/10/16.
//  Copyright © 2016 Dataready. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import ObjectMapper
import SwiftyJSON
import KRProgressHUD

let IS_LOG_ENABLE = true

class APIClient<M: Mappable,E: Mappable> {
    
    typealias apiResponseSuccess = (_ success: M) -> Void
    typealias apiDeleteResponseSuccess = (_ success: M?) -> Void
    typealias apiResponsesSuccess = (_ success: [M]) -> Void
    typealias apiResponseError = (_ error: E,_ message:String) -> Void
    typealias apiResponseUploading = (_ success: Double) -> Void
    typealias apiResponseSuccessJSON = (_ success: Any) -> Void
    typealias apiResponseFailed = (_ failed: Error) -> Void
    typealias apiResponseStatus = (_ Status: Bool) -> Void
    
    
    func json(from object:Any) -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }

    // MARK:- GET
    func API_GET(Url:String,Params:[String : AnyObject],Authentication:Bool,Progress:Bool,Alert:Bool,Offline:Bool,SuperVC:UIViewController,completionSuccess: @escaping apiResponseSuccess,completionError: @escaping apiResponseError,completionFailed: @escaping apiResponseFailed) {
        
        if ApiUtillity.sharedInstance.isReachable() {
            
            if Progress {
                ApiUtillity.sharedInstance.showhud()
            }
            
            let authHeader = [String: String]()
            
            Alamofire.request(Url, method: .get, parameters: Params, encoding: URLEncoding.queryString, headers: authHeader).responseJSON { response in
                
                if Progress {
                    ApiUtillity.sharedInstance.hidehud()
                }
                
                guard let responseJSON = response.result.value else {
                    completionFailed(response.error!)
                    return
                }
                
                print("------------response start ------")
                print(responseJSON)
                print("------------response end ------")
                
                if let statusCode = response.response?.getStatusCode() {
                    switch statusCode {
                    case 200 ... 299:
                        if let resultModel = Mapper<M>().map(JSONObject: responseJSON) {
                            completionSuccess(resultModel)
                            return
                        }
                    default:
                        if let resultModel = Mapper<E>().map(JSONObject: responseJSON) {
                            completionError(resultModel, "")
                            return
                        }
                    }
                }
            } .responseString { response in
                if Progress{
                    ApiUtillity.sharedInstance.hidehud()
                }
                debugPrint(response)
                
                if let data = response.data, data.count > 0 {
                    do{
                        _ = try JSON(data: data)
                        print("Valid Json")
                    }catch{
                        print("JSON Error")
                        print("response = \(response.description)")
                    }
                }
            }
        } else {
            let errorTemp = NSError(domain:"Please check Internet Connection", code:403, userInfo:nil)
            completionFailed(errorTemp)
            return
        }
    }
}

private let _sharedInstance = ApiUtillity()

class ApiUtillity: NSObject {
    
    class var sharedInstance: ApiUtillity {
        return _sharedInstance
    }
    
    func showhud() {
        KRProgressHUD.show(withMessage: "Loading...")
    }
    
    func hidehud() {
        KRProgressHUD.dismiss {
            print("hide indecatort")
        }
    }
    
    func isReachable() -> Bool
    {
        let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.google.com")
        return (reachabilityManager?.isReachable)!
    }
    
    
    // MARK: set base Model
    func setBaseModel(modelResponse: [ModelData]) {
        let obj = modelResponse.map{$0.toJSONString() ?? ""}
        Defaults[.LoginResult] = obj
    }
    
    // MARK: Get base Model
    func getBaseModel() -> [ModelData]? {
        
        if let data = Defaults[.LoginResult] {
            let obj = data.map{Mapper<ModelData>().map(JSONString: $0)!}
            return obj
        }
        return nil
    }
    
}
