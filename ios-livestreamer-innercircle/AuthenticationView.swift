//
//  AuthenticationView.swift
//  ios-livestreamer-innercircle
//
//  Created by Mikaela Caron on 12/21/23.
//

import SwiftUI

struct AuthenticationView: View {
    
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Username", text: $username)
                } header: {
                    Text("Username")
                }
                
                Section {
                    TextField("Email", text: $email)
                } header: {
                    Text("Email")
                }
                
                Section {
                    SecureField("Password", text: $password)
                } header: {
                    Text("Password")
                } footer: {
                    HStack {
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Text("Create Account")
                                .frame(width: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        .padding(.top, 50)
                        
                        Spacer()
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Label("close", systemImage: "xmark.circle")
                }
            }
        }
    }
}

#Preview {
    AuthenticationView()
}
