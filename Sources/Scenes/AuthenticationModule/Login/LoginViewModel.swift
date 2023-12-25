//
//  LoginViewModel.swift
//  my-project-ios
//
//  Created by Thân Văn Thanh on 25/12/2023.
//

import Combine
import FirebaseAuth
import GoogleSignIn

class LoginViewModel: BaseViewModel {
    let loginUseCases: LoginUseCases
    
    init(loginUseCases: LoginUseCases) {
        self.loginUseCases = loginUseCases
    }
}

extension LoginViewModel: ViewModelType {
    
    struct Input {
        let loginTrigger: AnyPublisher<(String, String), Never>
        let loginGoogleTrigger: AnyPublisher<AuthCredential, Never>
    }
    
    final class Output: ObservableObject {
        @Published var response: AuthDataResult?
        @Published var isLoading = false
        @Published var error: Error?
    }
    
    func transform(_ input: Input, _ disposeBag: DisposeBag) -> Output {
        let output = Output()
        
        input.loginTrigger
            .flatMap {
                self.loginUseCases
                    .signIn(withEmail: $0, password: $1)
                    .trackError(self.errorIndicator)
                    .trackActivity(self.activityIndicator)
                    .eraseToAnyPublisher()
            }
            .assign(to: \.response, on: output)
            .store(in: disposeBag)
        
        input.loginGoogleTrigger
            .flatMap {
                self.loginUseCases
                    .signInGoogle(with: $0)
                    .trackError(self.errorIndicator)
                    .trackActivity(self.activityIndicator)
                    .eraseToAnyPublisher()
            }
            .assign(to: \.response, on: output)
            .store(in: disposeBag)
        
        return output
    }
}
