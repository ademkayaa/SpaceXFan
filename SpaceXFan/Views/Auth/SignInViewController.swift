//
//  SignInViewController.swift
//  SpaceXFan
//
//  Created by Adem Kaya
//

import UIKit

class SignInViewController: UIViewController {

    lazy var emailTextField: UITextField = {
        let view = UITextField()
        view.font = .systemFont(ofSize: 20, weight: .medium)
        view.placeholder = "Enter Email"
        view.textColor = .systemTeal
        view.layer.cornerRadius = 6
        view.layer.borderColor = UIColor.systemBlue.cgColor
        view.layer.borderWidth = 1
        view.text = "ademkaya@ios.com"
        return view
    }()

    lazy var passwordTextField: UITextField = {
        let view = UITextField()
        view.font = .systemFont(ofSize: 20, weight: .medium)
        view.placeholder = "Enter Password"
        view.textColor = .systemTeal
        view.layer.cornerRadius = 6
        view.layer.borderColor = UIColor.systemBlue.cgColor
        view.layer.borderWidth = 1
        view.isSecureTextEntry = true
        view.text = "123456"
        return view
    }()

    lazy var signInButton: UIButton = {
        let view = UIButton(type: .custom)

        view.setTitle("Sign In", for: .normal)
        view.addTarget(self, action: #selector(tapSignIn), for: .touchUpInside)
        view.backgroundColor = .systemBlue
        view.tintColor = .white
        view.layer.cornerRadius = 5
        return view
    }()

    lazy var signUpButton: UIButton = {
        let view = UIButton(type: .custom)

        view.setTitle("Sign Up", for: .normal)
        view.addTarget(self, action: #selector(tapSignUp), for: .touchUpInside)
        view.backgroundColor = .systemBrown
        view.tintColor = .white
        view.layer.cornerRadius = 5
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        applyConstraints()
    }

    private func applyConstraints() {
        view.addSubview(emailTextField)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 60).isActive = true

        view.addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.topAnchor, constant: 80).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 60).isActive = true

        view.addSubview(signInButton)
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.topAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: 80).isActive = true
        signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        signInButton.heightAnchor.constraint(equalToConstant: 60).isActive = true

        view.addSubview(signUpButton)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.topAnchor.constraint(equalTo: signInButton.topAnchor, constant: 80).isActive = true
        signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        signUpButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }

    func showPopUp(title: String, message: String, completion: @escaping () -> Void){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) {(action)  in
            completion()
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }

    @objc func tapSignIn(_ sender: UIButton) {
        print("tapSignIn")

        FBAuth.shared.signIn(email: emailTextField.text!, password: passwordTextField.text!) { [weak self] result in
            switch(result) {
            case.success(_):
                print("signIn success")
                self?.showPopUp(title: "Sign In", message: "Success") {
                    self?.navigationController?.popViewController(animated: true)
                }
            case.failure(_):
                self?.showPopUp(title: "Sign In", message: "fail") {
                    print("signIn fail")
                }
            }
        }
    }

    @objc func tapSignUp(_ sender: UIButton) {
        print("tapSignUp")

        FBAuth.shared.signUp(email: emailTextField.text!, password: passwordTextField.text!) { [weak self] result in
            switch(result) {
            case.success(_):
                print("signUp success")
                self?.showPopUp(title: "Sign Up", message: "Success") {
                    self?.navigationController?.popViewController(animated: true)
                }
            case.failure(_):
                self?.showPopUp(title: "Sign Up", message: "fail") {
                    print("signUp fail")
                }
            }
        }
    }
}
