//
//  ContentView.swift
//  ios-livestreamer-innercircle
//
//  Created by Mikaela Caron on 1/25/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var authenticationViewModel = AuthenticationViewModel()
    
    var body: some View {
        
        switch authenticationViewModel.authenticationState {
        case .unauthenticated, .authenticating:
            AuthenticationView()
                .environment(authenticationViewModel)
        case .authenticated:
            HomeView()
                .environment(authenticationViewModel)
        }
    }
}

#Preview {
    ContentView()
}
