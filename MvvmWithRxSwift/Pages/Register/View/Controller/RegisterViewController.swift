//
//  RegisterViewController.swift
//  MvvmWithRxSwift
//
//  Created by Ahmed Nasr on 10/20/20.
//

import UIKit
import RxSwift
import RxCocoa

class RegisterViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField:UITextField!
    @IBOutlet weak var rePasswordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    let registerViewModel = RegisterViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bindTextField()
        subscribeToValid()
        subscribeToIsLoading()
        subscribeToResponse()
        subscribeToRegisterPress()
    }
    
    func bindTextField(){
        nameTextField.rx.text.orEmpty.bind(to: registerViewModel.nameBehavior).disposed(by: disposeBag)
        emailTextField.rx.text.orEmpty.bind(to: registerViewModel.emailBehavior).disposed(by: disposeBag)
        passwordTextField.rx.text.orEmpty.bind(to: registerViewModel.passwordBehavior).disposed(by: disposeBag)
        rePasswordTextField.rx.text.orEmpty.bind(to: registerViewModel.rePasswordBehavior).disposed(by: disposeBag)
    }
    func subscribeToValid(){
        registerViewModel.registerButtonValid.bind(to: registerButton.rx.isEnabled).disposed(by: disposeBag)
    }
    func subscribeToIsLoading(){
        registerViewModel.isLoading.subscribe { (isLoading: Bool) in
            if isLoading{
                self.showIndicator(withTitle: "", and: "")
            }else{
                self.hideIndicator()
            }
        }.disposed(by: disposeBag)
    }
    func subscribeToResponse(){
        registerViewModel.responseObservable.subscribe { (registerModel: RegisterModel) in
            if let api_token = registerModel.user?.api_token {
                Helper.setApiToken(api_token: api_token)
                self.goToHomePage()
            }else{
                let ms = registerModel.msg
                self.showAlert(title: "Register Faild", messege: ms)
            }
        }.disposed(by: disposeBag)
    }
    func subscribeToRegisterPress(){
        registerButton.rx.tap.subscribe { (_) in
            self.registerViewModel.register()
        }.disposed(by: disposeBag)
    }
    func goToHomePage(){
        let homeVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController")
        self.present(homeVC, animated: true, completion: nil)
    }
}
