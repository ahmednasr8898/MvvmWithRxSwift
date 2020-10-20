//
//  RegisterViewModel.swift
//  MvvmWithRxSwift
//
//  Created by Ahmed Nasr on 10/20/20.
//

import Foundation
import RxSwift
import RxCocoa

class RegisterViewModel{
    
    var nameBehavior = BehaviorRelay<String>(value: "")
    var emailBehavior = BehaviorRelay<String>(value: "")
    var passwordBehavior = BehaviorRelay<String>(value: "")
    var rePasswordBehavior = BehaviorRelay<String>(value: "")
    var isLoading = BehaviorRelay<Bool>(value: false)
    
    private var responsSubject = PublishSubject<RegisterModel>()
    var responseObservable: Observable<RegisterModel>{
        return responsSubject
    }
    
    var nameValid: Observable<Bool>{
        nameBehavior.asObservable().map { (name) -> Bool in
            if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
                return false
            }else{
                return true
            }
        }
    }
    var emailValid: Observable<Bool>{
        emailBehavior.asObservable().map { (email) -> Bool in
            if email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
                return false
            }else{
                return true
            }
        }
    }
    var passwordValid: Observable<Bool>{
        passwordBehavior.asObservable().map { (password) -> Bool in
            if password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
                return false
            }else{
                return true
            }
        }
    }
    var rePasswordValid: Observable<Bool>{
        rePasswordBehavior.asObservable().map { (rePassword) -> Bool in
            if rePassword.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
                return false
            }else{
                return true
            }
        }
    }
    var registerButtonValid: Observable<Bool>{
        Observable.combineLatest(nameValid, emailValid, passwordValid, rePasswordValid){(name , email , password , repassword) in
            if name && email && password && repassword {
            return true
            }else{
                return false
            } 
        }
    }
    func register(){
        isLoading.accept(true)
        let url = Urls.register
        let parameter = [
            "name": nameBehavior.value,
            "email": emailBehavior.value,
            "password": passwordBehavior.value,
            "password_confirmation": rePasswordBehavior.value
        ]
        ApiService.getData(url: url, method: .post, parameters: parameter, headers: nil) { (registerModel: RegisterModel?, error: Error?) in
            self.isLoading.accept(false)
            if let error = error{
                print("error when connection with server: \(error)")
            }else{
                guard let registerModel = registerModel else { return}
                self.responsSubject.onNext(registerModel)
            }
        }
    }
}
