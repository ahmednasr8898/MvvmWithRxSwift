//
//  Url.swift
//  MvvmWithRxSwift
//
//  Created by Ahmed Nasr on 10/20/20.
//

import Foundation

class Urls{
    
   static let base_Url = "https://elzohrytech.com/alamofire_demo/api/v1/"
    
    // MARK:- AUTH
    
    // POST {email , password}
    static let login = base_Url + "login"
    
    // POST {name , email , password , password_confirmation}
    static let register = base_Url + "register"
}
