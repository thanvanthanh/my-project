//
//  LibsManager.swift
//  my-project-ios
//
//  Created by Thân Văn Thanh on 24/12/2023.
//

import Foundation
import Combine
import FirebaseCore

final class LibsManager {
    
    static let shared = LibsManager()
    
    private var bag = DisposeBag()
    
    private init() {}
    
    func setupLibs() {
        let libsManager = LibsManager.shared
        
        libsManager.setupFirebase()
        libsManager.configLeakDetector()
    }
    
    private func setupFirebase() {
        FirebaseApp.configure()
    }
    
    private func configLeakDetector() {
        LeakDetector.instance.isEnabled = false
        
        LeakDetector.instance.status
            .sink(
                receiveValue: { status in
                    print("LeakDetector \(status)")
                }
            )
            .store(in: bag)
        
        LeakDetector.instance.isLeaked
            .sink { message in
                if let message = message {
                    print("LEAK \(message)")
                }
            }
            .store(in: bag)
        
    }
}
