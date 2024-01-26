//
//  HomeView.swift
//  ios-livestreamer-innercircle
//
//  Created by Jeroen Leenarts on 11/12/2023.
//

import SwiftUI
import StreamVideo

struct HomeView: View {
    
    @Environment(AuthenticationViewModel.self) var authenticationViewModel
    
    @State private var isPresentingProfileView = false
    
    @State private var streamVideoClient: StreamVideo
    
    @State private var calls = [Call]()
    
    init() {
//        let userToken = (try? await authenticationViewModel.user?.getIDToken()) ?? ""
        
        let streamVideo = StreamVideo(
            apiKey: "",
            user: .anonymous,
            token: .init(rawValue: "userToken")
        )
        
        self.streamVideoClient = streamVideo
    }
    
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
            .task {
                try? await queryLivestreams()
            }
            .sheet(isPresented: $isPresentingProfileView) {
                ProfileView()
                    .environment(authenticationViewModel)
            }
        }
    }
    
    private func queryLivestreams() async throws {
//        let filters: [String: RawJSON] = ["ended_at": .nil]
        let filters: [String: RawJSON] = ["type": .dictionary(["$eq": .string("livestream")])]
        let sort = [SortParamRequest.descending("created_at")]
        let limit = 10
        
        let (firstPageCalls, secondPageCursor) = try await streamVideoClient.queryCalls(filters: filters, sort: sort, limit: limit)
        
        self.calls = firstPageCalls
    }
}

#Preview {
    HomeView()
}
