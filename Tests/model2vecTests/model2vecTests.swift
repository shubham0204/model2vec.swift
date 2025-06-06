import Testing
@testable import model2vec

@Test func example() async throws {
    let model2vec = Model2Vec(
        modelPath: "/Users/shubhampanchal/RustProjects/model2vec/embeddings.safetensors",
        tokenizerPath: "/Users/shubhampanchal/RustProjects/model2vec/tokenizer.json"
    )
    let embeddingDims = model2vec.getEmbeddingDims()
    let embeddings = model2vec.getEmbeddings(texts: ["Hello World"])
    #expect(embeddings.count == 1)
    #expect(embeddings[0].count == embeddingDims)
}
