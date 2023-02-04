//
//  File.swift
//  NewsApp
//
//  Created by Muhammad Bassiouny on 1/3/23.
//

import Foundation
import Reachability
import Combine

class ViewModel {
    
     var networkStatusDidChangeSubject = PassthroughSubject<Bool, Never>()

    
    init() {
      /// Listen to netowrk status
       ReachabilityManager.shared.addListener(listener: self)
    }
    
}

//MARK: - Reachability Manager
extension ViewModel: NetworkStatusListener {
    func networkStatusDidChange(status: Reachability.Connection) {
        switch status {
        case .none:
            networkStatusDidChangeSubject.send(false)
        case .wifi:
            networkStatusDidChangeSubject.send(true)
        case .cellular:
            networkStatusDidChangeSubject.send(true)
        }
   }
}
