

import Model2Vec

public class Model2Vec {
    
    private var modelPath: String
    private var tokenizerPath: String
    private var numThreads: UInt
    private var nativeInstance: OpaquePointer?
    
    init(modelPath: String, tokenizerPath: String, numThreads: UInt = 4) {
        self.modelPath = modelPath
        self.tokenizerPath = tokenizerPath
        self.numThreads = numThreads
        modelPath.withCString { modelPathCharPtr in
            tokenizerPath.withCString { tokenizerPathCharPtr in
                nativeInstance = model2vec_create(modelPathCharPtr, tokenizerPathCharPtr, numThreads)
            }
        }
    }
    
    func getEmbeddings(texts: [String]) -> [[Float32]] {
        texts.forEach { text in
            text.withCString { textCharPtr in
                model2vec_add_seq_buffer(nativeInstance, textCharPtr)
            }
        }
        let embeddingDims = model2vec_embedding_dims(nativeInstance)
        let nativeEmbeddingsArray = model2vec_encode_seq_buffer(nativeInstance)
        let nativeEmbeddingsBuffPointer = UnsafeBufferPointer(
            start: nativeEmbeddingsArray.data,
            count: Int(nativeEmbeddingsArray.len)
        )
        let embeddings = Array(nativeEmbeddingsBuffPointer).map { nativeEmbedding in
            Array(UnsafeBufferPointer(start: nativeEmbedding.data, count: Int(embeddingDims)))
        }
        model2vec_clear_seq_buffer(nativeInstance)
        return embeddings
    }
    
    func getEmbeddingDims() -> UInt {
        return model2vec_embedding_dims(nativeInstance)
    }
    
    deinit {
        model2vec_release(self.nativeInstance)
    }
}
