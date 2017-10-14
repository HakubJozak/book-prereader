from gensim import corpora, models

dictionary = corpora.Dictionary.load('dict10k.dict')
corpus = corpora.MmCorpus('corpus10k.mm')
tfidf = models.TfidfModel.load('tfidf_10k')
# print(corpus)
# print(dictionary.token2id)

new_doc = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
# new_doc = "Katrina Rose Dideriksen is an actress originally from North Carolina. She lived in Durham, North Carolina, as a child and attended Durham School of the Arts in high school. She later studied at New York University Steinhardt School of Education before attending an open call for the musical Hairspray. "
vector_never_seen = dictionary.doc2bow(new_doc.lower().split())
# print(vector_never_seen)

tf_vec = tfidf[vector_never_seen]
for i in tf_vec:
    print(dictionary[i[0]] + " " + str(i[1]))
