//
//  File.swift
//  
//
//  Created by Vaughn on 2023-01-25.
//

import Foundation
import Combine
import FirebaseAuthWrapper_CombineiOS
import FirebaseAuth

class Auth: ObservableObject {
    @Published var user: FirebaseAuth.User?
    
    private let authService = FirebaseAuthWrapper.shared

    
    private var authListener: AnyCancellable?
    private var cancellables: [AnyCancellable] = []
    
    let email = "test@test.cc"
    let password = "Password123"
    
    init() {
        authListener = authService.listen()
            .sink { completion in
                switch completion {
                case .finished:
                    print("Logging in")
                case .failure(let e):
                    print("Failed: \(e)")
                }
            } receiveValue: { [weak self] auth in
                self?.user = auth.currentUser
            }
    }
    
    func logIn() {
        authService.signIn(email, password)
            .sink { completion in
                switch completion {
                case .finished:
                    print("logged in")
                case .failure(let e):
                    print("Failed login: \(e)")
                }
            } receiveValue: { [weak self] result in
                self?.user = result.user
            }.store(in: &cancellables)
    }
    
    func signUp() {
        authService.signUp(email, password)
            .sink { completion in
                switch completion {
                case .finished:
                    print("logged in")
                case .failure(let e):
                    print("Failed login: \(e)")
                }
            } receiveValue: { [weak self] result in
                self?.user = result.user
            }.store(in: &cancellables)
    }
    
    func signOut() {
        authService.signOut()
            .sink { completion in
                switch completion {
                case .finished:
                    print("logged out")
                case .failure(let e):
                    print("Failed log out: \(e)")
                }
            } receiveValue: { [weak self] _ in
                self?.user = nil
            }.store(in: &cancellables)
    }
}
