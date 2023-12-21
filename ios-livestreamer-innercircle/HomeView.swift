//
//  HomeView.swift
//  ios-livestreamer-innercircle
//
//  Created by Jeroen Leenarts on 11/12/2023.
//

import SwiftUI

struct HomeView: View {
    
    @State private var isPresentingProfileView = false
    
    private let livestreams = ["video 1", "video 2", "video 3"]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(livestreams, id: \.self) { video in
                    VStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 12)
                            .frame(width: .infinity, height: 300)
                        
                        Text(video)
                            .font(.title)
                    }
                    
                }
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
            }
        }
    }
}

#Preview {
    HomeView()
}
