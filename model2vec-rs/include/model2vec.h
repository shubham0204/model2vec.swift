#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>

typedef struct StaticModel StaticModel;

typedef struct Embedding {
  int32_t len;
  float *data;
} Embedding;

typedef struct EmbeddingsArray {
  int32_t len;
  struct Embedding *data;
} EmbeddingsArray;

struct StaticModel *model2vec_create(const char *embeddings_path_cstr,
                                     const char *tokenizer_path_cstr,
                                     uintptr_t num_threads);

void model2vec_add_seq_buffer(struct StaticModel *model, const char *sequence_cstr);

void model2vec_clear_seq_buffer(struct StaticModel *model);

struct EmbeddingsArray model2vec_encode_seq_buffer(struct StaticModel *model);

void model2vec_release(struct StaticModel *model);

uintptr_t model2vec_embedding_dims(const struct StaticModel *model);

void model2vec_free_embeddings(struct EmbeddingsArray embeddings);
