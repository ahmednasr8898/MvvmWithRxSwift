//
//  ViewController.swift
//  MvvmWithRxSwift
//
//  Created by Ahmed Nasr on 10/20/20.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    let loginViewModel = LoginViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bindTextField()
        subscribeToVaild()
        subscribeToLoadingData()
        subscribeToResponseData()
        subscribeToLoginPress()
        subscribeToRegister()
    }
    func bindTextField(){
        emailTextField.rx.text.orEmpty.bind(to: loginViewModel.emailBehavior).disposed(by: disposeBag)
        passwordTextField.rx.text.orEmpty.bind(to: loginViewModel.passwordBehavior).disposed(by: disposeBag)
    }
    func subscribeToVaild(){
        loginViewModel.loginButtonVaild.bind(to: LoginButton.rx.isEnabled).disposed(by: disposeBag)
    }
    func subscribeToLoadingData(){
        loginViewModel.loadingBehavior.subscribe { (isLoading: Bool) in
            if isLoading{
                self.showIndicator(withTitle: "", and: "")
            }else{
                self.hideIndicator()
            }
        }.disposed(by: disposeBag)
    }
    func subscribeToResponseData(){
        loginViewModel.responseObservable.subscribe { (loginModel: LoginModel) in
            if let api_token = loginModel.user?.api_token{
                Helper.setApiToken(api_token: api_token)
                self.goToHomePage()
            }else{
                //show alert error
                self.showAlert(title: "Login Faild", messege: "check your email and password")
            }
        }.disposed(by: disposeBag)
    }
    func subscribeToLoginPress(){
        LoginButton.rx.tap.subscribe { (_) in
            self.loginViewModel.login()
        }.disposed(by: disposeBag)
    }
    func subscribeToRegister(){
        registerButton.rx.tap.subscribe { (_) in
             let registerVC = UIStoryboard(name: "Register", bundle: nil).instantiateViewController(withIdentifier: "RegisterViewController")
             registerVC.modalPresentationStyle = .fullScreen
               // self.present(registerVC, animated: true, completion: nil)
            self.navigationController?.pushViewController(registerVC, animated: true)
        }.disposed(by: disposeBag)
    }
    
    func goToHomePage(){
        let homeVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController")
        self.present(homeVC, animated: true, completion: nil)
    }
}

