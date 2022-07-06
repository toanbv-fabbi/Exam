//
//  LoginViewModel.swift
//  Exam
//
//  Created by cmc on 05/07/2022.
//

import Foundation

protocol LoginDelegate: AnyObject {
    func validateSuccess()
    func validateError()
    func showLoading()
    func hideLoading()
}
protocol ValidateService {
    func validate(email: String, password: String, completion: @escaping (Result<ValidateResult, Error>) -> Void)
}

class LoginViewModel {
    let validateService: ValidateService
    weak var delegate: LoginDelegate?
    
    init(validateService: ValidateService = ValidateRepository()) {
        self.validateService = validateService
    }
    
    func validate(email: String, password: String) {
        delegate?.showLoading()
        validateService.validate(email: email, password: password) { dataResponse in
            self.delegate?.hideLoading()
            switch dataResponse {
            case .success(let result):
                UserDefault.saveToken(token: result.data.token)
                self.delegate?.validateSuccess()
            case .failure(let error):
                self.delegate?.validateError()
            }

        }
    }
}

