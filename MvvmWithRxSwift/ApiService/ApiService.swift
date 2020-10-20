//
//  ApiService.swift
//  MvvmWithRxSwift
//
//  Created by Ahmed Nasr on 10/20/20.
//

import Foundation
import Alamofire

class ApiService{
    
    
   class func getData<T: Decodable>(url: String , method: HTTPMethod , parameters: Parameters? , headers: HTTPHeaders? , complation: @escaping (T?, Error?)-> Void){
        
        AF.request(url , method: method , parameters: parameters, encoding: JSONEncoding.default , headers: headers).responseJSON { (response) in
            
            switch response.result{
            
            case .failure(let error):
                complation(nil, error)
            case .success(_):
                
                guard let data = response.data else {return}
                do{
                let json = try JSONDecoder().decode(T.self, from: data)
                complation(json , nil)
                }catch let jsonError{
                    print("error when get Data: \(jsonError)")
                    complation(nil , jsonError)
                }
            }
        }
    }
}
