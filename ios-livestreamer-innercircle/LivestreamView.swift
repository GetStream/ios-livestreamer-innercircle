//
//  LivestreamView.swift
//  ios-livestreamer-innercircle
//
//  Created by Mikaela Caron on 12/21/23.
//

import SwiftUI

struct LivestreamView: View {
    
    let reactionButtonSize: CGFloat = 60
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                Rectangle()
                    .frame(width: .infinity, height: 320)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("Video title")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("creator name")
                        .font(.caption)
                }
                .padding(.horizontal, 8)
                
                HStack(spacing: 16) {
                    Spacer()
                    
                    Button {
                    } label: {
                        Image(systemName: "hand.thumbsup.circle")
                            .resizable()
                            .frame(width: reactionButtonSize, height: reactionButtonSize)
                    }
                    
                    Button {
                    } label: {
                        Image(systemName: "hand.thumbsdown.circle")
                            .resizable()
                            .frame(width: reactionButtonSize, height: reactionButtonSize)
                    }
                    
                    Button {
                    } label: {
                        Text("🔥")
                            .frame(width: reactionButtonSize, height: reactionButtonSize)
                            .overlay{
                                Circle()
                                    .stroke(.blue, lineWidth: 3)
                            }
                    }
                    
                    Spacer()
                }
                
                ScrollView {
                    ForEach(1...10, id: \.self) { index in
                        HStack(alignment: .top) {
                            Text("username")
                                .fontWeight(.bold)
                            Text("this is a comment right here that is a comment")
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .padding(.horizontal, 8)
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        
                    } label: {
                        Image(systemName: "xmark.circle")
                    }
                }
            }
        }
    }
}

#Preview {
    LivestreamView()
}
