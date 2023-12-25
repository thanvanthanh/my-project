//
//  LoginViewController.swift
//  my-project-ios
//
//  Created by Thân Văn Thanh on 22/12/2023.
//

import UIKit
import Combine
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

final class LoginViewController: BaseViewController {
    
    private enum Wrapper: Hashable {
        case title
        case input
        case social
    }
    
    private enum Section: CaseIterable {
        case main
    }

    @IBOutlet private var tableView: UITableView!
    private var dataSource: UITableViewDiffableDataSource<Section, Wrapper>? = nil
    
    private let loginTrigger = PassthroughSubject<(String, String),Never>()
    private let loginGoogleTrigger = PassthroughSubject<AuthCredential, Never>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func setupUI() {
        super.setupUI()
        hideKeyboardWhenTappedAround()
        tableView.register(cell: TitleLoginTableViewCell.self)
        tableView.register(cell: InputLoginTableViewCell.self)
        tableView.register(cell: SocialLoginTableViewCell.self)
        configDataSource()
    }
    
    private func configDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, Wrapper>(tableView: tableView,
                                                                     cellProvider: { tableView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .title:
                let cell = tableView.dequeueReusableCell(cell: TitleLoginTableViewCell.self, indexPath: indexPath)
                cell.set(self)
                return cell
            case .input:
                let cell = tableView.dequeueReusableCell(cell: InputLoginTableViewCell.self, indexPath: indexPath)
                cell.set(self)
                return cell
            case .social:
                let cell = tableView.dequeueReusableCell(cell: SocialLoginTableViewCell.self, indexPath: indexPath)
                cell.set(self)
                return cell
            }
        })
        dataSource?.defaultRowAnimation = .fade
        configSnapshot()
    }
    
    private func configSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Wrapper>()
        snapshot.appendSections([.main])
        snapshot.appendItems([.title, .input, .social])
        dataSource?.apply(snapshot)
        tableView.dataSource = dataSource
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        guard let viewModel = viewModel as? LoginViewModel else { return }
        
        let input = LoginViewModel.Input(
            loginTrigger: loginTrigger.eraseToAnyPublisher(),
            loginGoogleTrigger: loginGoogleTrigger.eraseToAnyPublisher()
        )
        
        let output = viewModel.transform(input, disposeBag)
        output.$response
            .subscribe(repoSubscriber)
        
    }
}

extension LoginViewController {
    private var repoSubscriber: Binder<AuthDataResult?> {
        Binder(self) { vc, repos in
            print(repos?.user.email)
        }
        
    }
}

//MARK: - TitleLoginTableViewCellProtocol
extension LoginViewController: TitleLoginTableViewCellProtocol {
    func backAction() {
        self.pop()
    }
}

// MARK: - InputLoginTableViewCellProtocol
extension LoginViewController: InputLoginTableViewCellProtocol {
    func forgotPassword() {
    }
    
    func login(email: String, password: String) {
        loginTrigger.send((email, password))
    }
}

// MARK: - SocialLoginTableViewCellProtocol
extension LoginViewController: SocialLoginTableViewCellProtocol {
    func facebookLogin() {
    }
    
    func googleLogin() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [weak self] result, error in
            guard let self else { return }
          guard error == nil else {
              Alert.showConfirm(on: self, message: error?.localizedDescription)
              return
          }

          guard let user = result?.user,
            let idToken = user.idToken?.tokenString else { return }

          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: user.accessToken.tokenString)

            loginGoogleTrigger.send(credential)
        }
    }
    
    func appleLogin() {
    }
    
}
