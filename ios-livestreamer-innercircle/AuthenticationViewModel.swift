//
//  AuthenticationViewModel.swift
//  ios-livestreamer-innercircle
//
//  Created by Mikaela Caron on 1/24/24.
//

import SwiftUI
import FirebaseAuth


enum AuthenticationState {
    case unauthenticated
    case authenticating
    case authenticated
}

enum AuthenticationFlow {
    case logIn
    case signUp
}

@Observable class AuthenticationViewModel {
    var authenticationState = AuthenticationState.unauthenticated
    var username = ""
    var email = ""
    var password = ""
    var confirmPassword = ""
    var flow: AuthenticationFlow = .logIn
    
    var isButtonValid: Bool {
        switch flow {
        case .logIn:
            return !(email.isEmpty || password.isEmpty)
        case .signUp:
            return !(username.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty)
        }
    }
    
    private var authStateHandler: AuthStateDidChangeListenerHandle?
    
    var user: User?
    
    init() {
        registerAuthStateHandler()
    }
    
    func registerAuthStateHandler() {
        if authStateHandler == nil {
            authStateHandler = Auth.auth().addStateDidChangeListener { _, user in
                self.user = user
                self.authenticationState = user == nil ? .unauthenticated : .authenticated
            }
        }
    }
    
    func switchFlow() {
        flow = flow == .logIn ? .signUp : .logIn
        username = ""
        email = ""
        password = ""
        confirmPassword = ""
    }
    
    func signInWithEmailPassword() async {
        authenticationState = .authenticating
        do {
            try await Auth.auth().signIn(withEmail: email, password: password)
            authenticationState = .authenticated
        } catch  {
            print(error)
            authenticationState = .unauthenticated
        }
    }
    
    func signUpWithEmailPassword() async {
        authenticationState = .authenticating
        do {
            try await Auth.auth().createUser(withEmail: email, password: password)
            authenticationState = .authenticated
        } catch {
            print(error)
            authenticationState = .unauthenticated
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
    }
    
    func deleteAccount() async -> Bool {
        do {
            try await user?.delete()
            return true
        } catch {
            return false
        }
    }
}
