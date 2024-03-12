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
    
    @State private var streamVideoClient: StreamVideo?
    
    @State private var calls = [Call]()
    
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
                await setUpStreamVideo()
                try? await queryLivestreams()
            }
            .sheet(isPresented: $isPresentingProfileView) {
                ProfileView()
                    .environment(authenticationViewModel)
            }
        }
    }
    
    private func setUpStreamVideo() async {
        guard let user = authenticationViewModel.user,
              let userToken = authenticationViewModel.user?.id else {
                  return
              }
        
        let streamVideo = StreamVideo(
            apiKey: Secret.streamKey,
            user: .init(id: user.id),
            token: .init(rawValue: userToken)
        )
        
        self.streamVideoClient = streamVideo
    }
    
    private func queryLivestreams() async throws {
//        let filters: [String: RawJSON] = ["ended_at": .nil]
        let filters: [String: RawJSON] = ["type": .dictionary(["$eq": .string("livestream")])]
        let sort = [SortParamRequest.descending("created_at")]
        let limit = 10
        
        if let streamVideoClient {
            do {
                let (firstPageCalls, secondPageCursor) = try await streamVideoClient.queryCalls(filters: nil, sort: sort, limit: limit)
                self.calls = firstPageCalls
            } catch {
                print("❌ Error \(error) DESCRIPTION: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    HomeView()
}
