//
//  LoginViewModel.swift
//  MvvmWithRxSwift
//
//  Created by Ahmed Nasr on 10/20/20.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel{
    
    var emailBehavior = BehaviorRelay<String>(value: "")
    var passwordBehavior = BehaviorRelay<String>(value: "")
    var loadingBehavior = BehaviorRelay<Bool>(value: false)
    
    private var responseSubject = PublishSubject<LoginModel>()
    var responseObservable: Observable<LoginModel>{
        return responseSubject
    }
  
    var emailValid: Observable<Bool>{
         emailBehavior.asObservable().map({ (email) -> Bool in
            if email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
                return false
            }else{
                return true
            }
        })
    }
    var passwordValid: Observable<Bool>{
         passwordBehavior.asObservable().map({ (password) -> Bool in
            if password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
                return false
            }else{
                return true
            }
        })
    }
    var loginButtonVaild: Observable<Bool>{
        Observable.combineLatest(emailValid, passwordValid) {(email , password) in
            if email && password{
                return true
            }else{
                return false
            }
        }
    }
    func login(){
        loadingBehavior.accept(true)
        let url = Urls.login
        let parameter = ["email": emailBehavior.value , "password": passwordBehavior.value]
        
        ApiService.getData(url: url, method: .post, parameters: parameter, headers: nil) { (loginModel: LoginModel?, error: Error?) in
            self.loadingBehavior.accept(false)
            if let error = error{
                print("error when connection with server: \(error)")
            }else{
                guard let loginModel = loginModel else {return}
                self.responseSubject.onNext(loginModel)
                print(loginModel.msg ?? "")
            }
        }
    }
}
