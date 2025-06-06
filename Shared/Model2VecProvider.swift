import Foundation
import model2vecLib

class Model2VecProvider {
    
    private let model2vec: Model2Vec = Model2Vec(
        modelPath: "/Users/shubhampanchal/RustProjects/model2vec/embeddings.safetensors",
        tokenizerPath: "/Users/shubhampanchal/RustProjects/model2vec/tokenizer.json"
    )
    
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
