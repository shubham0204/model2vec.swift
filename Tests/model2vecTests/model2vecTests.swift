import Testing
@testable import model2vecLib

@Test func example() async throws {
    print(#file)
    let model2vec = Model2Vec(
        modelPath: "model2vec-demo/embeddings.safetensors",
        tokenizerPath: "model2vec-demo/tokenizer.json"
    )
    let embeddingDims = model2vec.getEmbeddingDims()
    let embeddings = model2vec.getEmbeddings(texts: ["Hello World"])
    #expect(embeddings.count == 1)
    #expect(embeddings[0].count == embeddingDims)
}
