//
//  ProfileView.swift
//  ios-livestreamer-innercircle
//
//  Created by Mikaela Caron on 12/21/23.
//

import SwiftUI

struct ProfileView: View {
    
    @State private var email = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                
                VStack(spacing: 16) {
                    Text("Email: \(email)")
                    
                    Button {
                        
                    } label: {
                        Text("Sign Out")
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .foregroundStyle(.white)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, minHeight: 44)
                    }
                    .background {
                        Color.blue
                    }
                    .clipShape(Capsule())
                    .padding(.horizontal, 16)
                }
            }
            .navigationTitle("Profile")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Label("close", systemImage: "xmark.circle")
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}
