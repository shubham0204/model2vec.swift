//
//  ContentView.swift
//  model2vec-macos
//
//  Created by Shubham Panchal on 06/06/25.
//

import SwiftUI

struct ContentView: View {
    
    private let model2vecProvider = Model2VecProvider()
    @State pri
    @State private var similarityScore: Float? = nil
    @State private var sent1: String = ""
    @State private var sent2: String = ""
    
    var body: some View {
        VStack {
            Text("model2vec demo")
                .font(.headline)
            Text("Generate static sentence embeddings on-device in Mac/iOS apps")
                .font(.subheadline)
            TextField(text: $sent1) {
                Text("Enter first sentence...")
            }
            TextField(text: $sent2) {
                Text("Enter second sentence...")
            }
            if let similarityScore = similarityScore {
                Text("Similarity score is \(similarityScore)")
            }
            Button(action: {
                similarityScore = model2vecProvider.getSimilarityScore(sent1: sent1, sent2: sent2)
            }) {
                Text("Get score")
            }
        }
        .padding()
        .alert(
            "",
            isPresented: model2vecProvider.isModelDownloaded()
        ) {
            
        }
        
    }
}

#Preview {
    ContentView()
}
