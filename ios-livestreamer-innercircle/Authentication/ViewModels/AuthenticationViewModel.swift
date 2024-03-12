//
//  AuthenticationViewModel.swift
//  ios-livestreamer-innercircle
//
//  Created by Mikaela Caron on 1/24/24.
//

import SwiftUI
import FirebaseAuth
import RevenueCat


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
    
    var user: UserCredentials?
    
    init() {
//        registerAuthStateHandler()
    }
    
//    func registerAuthStateHandler() {
//        if authStateHandler == nil {
//            authStateHandler = Auth.auth().addStateDidChangeListener { _, user in
//                self.user = user
//                self.authenticationState = user == nil ? .unauthenticated : .authenticated
//            }
//        }
//    }
    
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
            let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
            Purchases.shared.logIn(authResult.user.uid) { _, created, _ in
            }
            authenticationState = .authenticated
        } catch  {
            print(error)
            authenticationState = .unauthenticated
        }
    }
    
    func signUpWithEmailPassword() async {
        authenticationState = .authenticating
        do {
            let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
            Purchases.shared.logIn(authResult.user.uid) { _, created, _ in
            }
            authenticationState = .authenticated
        } catch {
            print(error)
            authenticationState = .unauthenticated
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            Task {
                try await Purchases.shared.logOut()
            }
        } catch {
            print(error)
        }
    }
    
    func deleteAccount() async {
//        do {
//            try await user?.delete()
//            _ = try await Purchases.shared.logOut()
//        } catch {
//            print(error)
//        }
    }
}
