//
//  Helper.swift
//  MvvmWithRxSwift
//
//  Created by Ahmed Nasr on 10/20/20.
//

import Foundation

class Helper{
    
    class func setApiToken(api_token: String){
        let def = UserDefaults.standard
        def.setValue(api_token, forKey: "api_token")
    }
    class func getApiToken()->String?{
        let def = UserDefaults.standard
        return def.object(forKey: "api_token") as? String
    }
}
