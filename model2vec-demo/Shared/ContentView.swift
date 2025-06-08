//
// Copyright 2025 Shubham Panchal
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import SwiftUI

struct ContentView: View {
    
    private let model2vecProvider = Model2VecProvider()
    @State private var executionTimeMillis: Float? = nil
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
                    .font(.title3)
            }
            TextField(text: $sent2) {
                Text("Enter second sentence...")
                    .font(.title3)
            }
            Button(action: {
                let start = DispatchTime.now()
                similarityScore = model2vecProvider.getSimilarityScore(sent1: sent1, sent2: sent2)
                let end = DispatchTime.now()
                executionTimeMillis = (Float(end.uptimeNanoseconds - start.uptimeNanoseconds)) / 1_000_000 as Float
            }) {
                Text("Get score")
            }
            if let similarityScore = similarityScore {
                Text("Similarity score is \(similarityScore)")
                    .padding(16)
            }
            if let executionTimeMillis = executionTimeMillis {
                Text("Inference time (ms) is \(executionTimeMillis) ms")
                    .padding(16)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
