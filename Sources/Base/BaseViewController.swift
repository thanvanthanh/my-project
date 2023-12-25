//
//  BaseViewController.swift
//  base-combine
//
//  Created by Thân Văn Thanh on 30/08/2023.
//

import UIKit
import Lottie
import Combine

protocol BaseViewControllerProtocol {
    var viewModel: BaseViewModel { get set }
    var disposeBag: DisposeBag { get set }
    
    func setupUI()
    func bindViewModel()
    func handleActivityIndicator(state: Bool)
}

class BaseViewController: UIViewController, BaseViewControllerProtocol {
    
    var viewModel: BaseViewModel
    var disposeBag = DisposeBag()
        
    private let loadingView = UIView()
    private let animationView = LottieAnimationView(name: "animation")
    
    init(viewModel: BaseViewModel? = nil) {
        self.viewModel = viewModel ?? BaseViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    func setupUI() {}
    
    func bindViewModel() {
        viewModel.loadingPublisher
            .sink { isLoading in
                self.handleActivityIndicator(state: isLoading)
            }
            .store(in: disposeBag)
        
        viewModel.errorPublisher
            .sink { error in
                if let error = error as? APIError {
                    Alert(message: error.desc)
                        .action(.ok)
                        .show(on: self)
                } else {
                    Alert(message: error.localizedDescription)
                        .action(.ok)
                        .show(on: self)
                }
            }
            .store(in: disposeBag)
    }
    
    func handleActivityIndicator(state: Bool) {
        state ? showActivityIndicator() : hideActivityIndicator()
    }
    
    func hideKeyboardWhenTappedAround(isCancelTouchInView: Bool = false) {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = isCancelTouchInView
    }
    
}

private extension BaseViewController {
    
    func showActivityIndicator() {
        guard let window = UIApplication.shared.mainKeyWindow else { return }
        animationView.loopMode = .loop
        animationView.play()
        
        loadingView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        animationView.translatesAutoresizingMaskIntoConstraints = false
        
        window.addSubview(loadingView)
        loadingView.addSubview(animationView)
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: window.topAnchor),
            loadingView.bottomAnchor.constraint(equalTo: window.bottomAnchor),
            loadingView.rightAnchor.constraint(equalTo: window.rightAnchor),
            loadingView.leftAnchor.constraint(equalTo: window.leftAnchor),
            
            animationView.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor),
            animationView.widthAnchor.constraint(equalToConstant: 100),
            animationView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.loadingView.removeFromSuperview()
            self.animationView.stop()
        }
    }
}
