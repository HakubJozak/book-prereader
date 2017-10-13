from gensim import corpora, models, similarities
corpus = [
    [
        (0, 1.0), (1, 1.0), (2, 1.0)],
        [(2, 1.0), (3, 1.0), (4, 1.0), (5, 1.0), (6, 1.0), (8, 1.0)],
        [(1, 1.0), (3, 1.0), (4, 1.0), (7, 1.0)],
        [(3, 1.0), (5, 1.0), (6, 1.0)],
        [(9, 1.0)],
        [(9, 1.0), (10, 1.0)],
        [(9, 1.0), (10, 1.0), (11, 1.0)],
        [(8, 1.0), (10, 1.0), (11, 1.0)]
    ]

tfidf = models.TfidfModel(corpus)
vec = [(0, 1), (4, 1)]
index = similarities.SparseMatrixSimilarity(tfidf[corpus], num_features=12)
sims = index[tfidf[vec]]
print(list(enumerate(sims)))
# print(tfidf[vec])