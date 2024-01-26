//
//  HomeView.swift
//  ios-livestreamer-innercircle
//
//  Created by Jeroen Leenarts on 11/12/2023.
//

import SwiftUI

struct HomeView: View {
    
    @Environment(AuthenticationViewModel.self) var authenticationViewModel
    
    @State private var isPresentingProfileView = false
    
    private let livestreams = ["video 1", "video 2", "video 3"]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(livestreams, id: \.self) { video in
                    NavigationLink(value: video) {
                        VStack(alignment: .leading) {
                            Text(video)
                                .font(.title)
                        }
                    }
                }
            }
            .navigationDestination(for: String.self) { video in
                LivestreamView()
            }
            .listStyle(.plain)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isPresentingProfileView = true
                    } label: {
                        Label("Profile", systemImage: "person.circle")
                    }
                }
            }
            .sheet(isPresented: $isPresentingProfileView) {
                ProfileView()
                    .environment(authenticationViewModel)
            }
        }
    }
}

#Preview {
    HomeView()
}
