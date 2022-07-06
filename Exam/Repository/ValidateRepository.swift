//
//  ValidateRepository.swift
//  Exam
//
//  Created by cmc on 05/07/2022.
//

import Foundation
import Alamofire

class ValidateRepository: ValidateService {
    
    func validate(email: String, password: String, completion: @escaping (Result<ValidateResult, Error>) -> Void) {
        guard let url = URL(string: Constants.baseURL) else {
            completion(.failure(NetworkError.wrongURL))
            return
        }
        AF.request(url, method: .post, parameters: ["email" : email, "password": password], encoding: URLEncoding.default, headers: nil).responseData { response in
            switch response.result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode(ValidateResult.self, from: data)
                    completion(.success(result))
                }
                catch let error {
                    completion(.failure(NetworkError.parser(error: error)))
                }
            }
        }
    }
}

enum NetworkError: Error {
    case wrongURL
    case parser(error: Error)
}
