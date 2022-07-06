//
//  LoginViewController.swift
//  Exam
//
//  Created by cmc on 05/07/2022.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBAction func loginPress(_ sender: Any) {
        loginViewModel.validate(email: emailTxtField.text ?? "", password: passwordTxtField.text ?? "")
    }
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!

    let loginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonSetUp()
    }
    
    func commonSetUp() {
        passwordTxtField.delegate = self
        emailTxtField.delegate = self
        loginBtn.isEnabled = false
        loginBtn.backgroundColor = .gray
        loginViewModel.delegate = self
    }
 
    func updateStateLoginBtn(isEnable: Bool) {
        loginBtn.isEnabled = isEnable
        if isEnable {
            loginBtn.backgroundColor = .blue
        } else {
            loginBtn.backgroundColor = .gray
        }
    }

}
extension LoginViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text, let textRange = Range(range, in: text) else { return true }
        let updatedText = text.replacingCharacters(in: textRange, with: string)
        if textField == emailTxtField {
            if updatedText.isValidEmail, passwordTxtField.text?.isEmpty == false {
                updateStateLoginBtn(isEnable: true)
            } else {
                updateStateLoginBtn(isEnable: false)
            }
        } else {
            if let email = emailTxtField.text, email.isValidEmail, !updatedText.isEmpty {
                updateStateLoginBtn(isEnable: true)
            } else {
                updateStateLoginBtn(isEnable: false)
            }
        }
        return true
    }
}

extension LoginViewController: LoginDelegate {
    
    func validateSuccess() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: MainViewController.self)) as! MainViewController
        SceneDelegate.setRootVC(vc: UINavigationController(rootViewController: vc))
    }
    
    func validateError() {
        let dialogVC = UIAlertController(title: "Notice", message: "Have Error", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            print("Ok button tapped")
        })
        dialogVC.addAction(ok)
        present(dialogVC, animated: true, completion: nil)
        
    }
    
    func showLoading() {
        loadingView.isHidden = false
    }
    
    func hideLoading() {
        loadingView.isHidden = true
    }
}
extension String {
    var isValidEmail: Bool {
        let regex = "^(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])$"
        return range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
}
