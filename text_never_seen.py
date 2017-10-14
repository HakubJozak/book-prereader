from gensim import corpora, models

dictionary = corpora.Dictionary.load('dict10k.dict')
corpus = corpora.MmCorpus('corpus10k.mm')
tfidf = models.TfidfModel.load('tfidf_10k')
# print(corpus)
# print(dictionary.token2id)

# new_doc = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
new_doc = "All elephants have several distinctive features, the most notable of which is a long trunk or proboscis, used for many purposes, particularly breathing, lifting water, and grasping objects. Their incisors grow into tusks, which can serve as weapons and as tools for moving objects and digging. Elephants' large ear flaps help to control their body temperature. Their pillar-like legs can carry their great weight. African elephants have larger ears and concave backs while Asian elephants have smaller ears and convex or level backs."

vector_never_seen = dictionary.doc2bow(new_doc.lower().split())
# print(vector_never_seen)

tf_vec = tfidf[vector_never_seen]
for i in tf_vec:
    print(dictionary[i[0]] + " " + str(i[1]))

import gensim, csv
from operator import itemgetter

id2word = dictionary
mm = corpus
n = len(id2word)
freq = [0] * n
for vector in mm:
    for element in vector:
        freq[element[0]] += element[1]

# Sort the tokens alphabetically
freqlist = [None] * n
for i in range(n):
    freqlist[i] = (i, id2word[i], freq[i])
freqlist = sorted(freqlist, key=itemgetter(2))

print(freqlist)
import pandas as pd

df = pd.DataFrame(freqlist)
print("bla")
