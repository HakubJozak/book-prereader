import json
import sys
from operator import itemgetter
from gensim import corpora, models

dictionary = corpora.Dictionary.load('data/dict100k.dict')
corpus = corpora.MmCorpus('data/corpus100k.mm')
tfidf = models.TfidfModel.load('data/tfidf_100k')


def tfi(new_doc):
    vector_never_seen = dictionary.doc2bow(new_doc.lower().split())
    tf_vec = tfidf[vector_never_seen]
    array = []
    for i in tf_vec:
        # print(dictionary[i[0]] + " " + str(i[1]))
        word = dictionary[i[0]]
        rank = i[1] * len(word) * len(word)
        if len(word) > 4:
            array.append({ word: rank})
    return array


filename = sys.argv[1]
flatten = lambda l: [item for sublist in l for item in sublist]

with open(filename, 'rt') as f:
    text = f.read()
    strings = (tfi(text))
    print(json.dumps(strings))
