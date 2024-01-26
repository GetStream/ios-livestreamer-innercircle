//
//  SignUpView.swift
//  ios-livestreamer-innercircle
//
//  Created by Mikaela Caron on 1/25/24.
//

import SwiftUI

private enum FocusableField: Hashable {
    case username
    case email
    case password
    case confirmPassword
}

struct SignUpView: View {
    @Environment(AuthenticationViewModel.self) var authenticationViewModel
    
    @FocusState private var focus: FocusableField?
    
    var body: some View {
        @Bindable var authenticationViewModel = authenticationViewModel
        
        NavigationStack {
            Form {
                Section {
                    TextField("Username", text: $authenticationViewModel.username)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .focused($focus, equals: .username)
                        .submitLabel(.next)
                        .onSubmit {
                            focus = .email
                        }
                } header: {
                    Text("Username")
                }
                
                Section {
                    TextField("Email", text: $authenticationViewModel.email)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .focused($focus, equals: .email)
                        .submitLabel(.next)
                        .keyboardType(.emailAddress)
                        .onSubmit {
                            self.focus = .password
                        }
                } header: {
                    Text("Email")
                }
                
                Section {
                    SecureField("Password", text: $authenticationViewModel.password)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .focused($focus, equals: .password)
                        .submitLabel(.next)
                    
                    SecureField("Confirm Password", text: $authenticationViewModel.confirmPassword)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .focused($focus, equals: .confirmPassword)
                        .submitLabel(.go)
                        .onSubmit {
                            signUpWithEmailPassword()
                        }
                } header: {
                    Text("Password")
                } footer: {
                    VStack {
                        Button {
                            signUpWithEmailPassword()
                        } label: {
                            if authenticationViewModel.authenticationState != .authenticating {
                                Text("Create Account")
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 16)
                                    .foregroundStyle(.white)
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity, minHeight: 44)
                            } else {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                    .padding(.vertical, 8)
                                    .frame(maxWidth: .infinity, minHeight: 44)
                            }
                        }
                        .background {
                            Color.blue
                        }
                        .clipShape(Capsule())
                        .disabled(!authenticationViewModel.isButtonValid)
                        .opacity(authenticationViewModel.isButtonValid ? 1.0 : 0.7)
                        .padding(.top, 16)
                        
                        HStack(spacing: 4) {
                            Text("Already have an account?")
                            Button {
                                authenticationViewModel.switchFlow()
                            } label: {
                                Text("Log In")
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle(Text("Sign Up for Inner Circle"))
    }
    
    private func signUpWithEmailPassword() {
        Task {
            await authenticationViewModel.signUpWithEmailPassword()
        }
    }
}

#Preview {
    SignUpView()
}
