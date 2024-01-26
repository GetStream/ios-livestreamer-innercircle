//
//  AuthenticationView.swift
//  ios-livestreamer-innercircle
//
//  Created by Mikaela Caron on 12/21/23.
//

import SwiftUI

private enum FocusableField: Hashable {
    case email
    case password
    case confirmPassword
}

struct AuthenticationView: View {
    
    @Environment(AuthenticationViewModel.self) var authenticationViewModel
    
    var body: some View {
        switch authenticationViewModel.flow {
        case .logIn:
            LogInView()
                .environment(authenticationViewModel)
        case .signUp:
            SignUpView()
                .environment(authenticationViewModel)
        }
    }
}

#Preview {
    AuthenticationView()
}
