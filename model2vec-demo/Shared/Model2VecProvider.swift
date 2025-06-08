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

import Foundation
import model2vecLib

class Model2VecProvider: ObservableObject {
    
    private let model2vec: Model2Vec = Model2Vec(
        modelPath: Bundle.main.path(forResource: "embeddings", ofType: "safetensors")!,
        tokenizerPath: Bundle.main.path(forResource: "tokenizer", ofType: "json")!
    )
    
    public func isModelDownloaded() -> Bool {
        let fileManager = FileManager()
        let documentsUrl = try! fileManager.url(
            for: .applicationSupportDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
        ).appendingPathComponent(Bundle.main.bundleIdentifier!)
        let embeddingsUrl = documentsUrl.appendingPathComponent("embeddings.safetensors")
        let tokenizerUrl = documentsUrl.appendingPathComponent("tokenizer.json")
        return fileManager.fileExists(atPath: embeddingsUrl.path()) && fileManager.fileExists(atPath: tokenizerUrl.path())
    }
    
    public func getSimilarityScore(sent1: String, sent2: String) -> Float {
        let embeddings = model2vec.getEmbeddings(texts: [sent1, sent2])
        return cosineSimilarity(vec1: embeddings[0], vec2: embeddings[1], dims: model2vec.getEmbeddingDims())
    }
    
    private func cosineSimilarity(vec1: [Float], vec2: [Float], dims: UInt) -> Float {
        var dotProd: Float = 0.0
        var mag1: Float = 0.0
        var mag2: Float = 0.0
        for i in (0..<Int(dims)) {
            dotProd += (vec1[i] * vec2[i])
            mag1 += pow(vec1[i], 2)
            mag2 += pow(vec2[i], 2)
        }
        return dotProd / (sqrt(mag1) * sqrt(mag2))
    }
    
}
