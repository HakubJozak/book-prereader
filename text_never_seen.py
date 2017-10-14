from gensim import corpora, models
import nltk
from nltk.corpus import stopwords
from nltk.tokenize import word_tokenize
from nltk.stem import WordNetLemmatizer
from gensim import corpora, models, similarities

dictionary = corpora.Dictionary.load('data/dict10k.dict')
corpus = corpora.MmCorpus('data/corpus10k.mm')
tfidf = models.TfidfModel.load('data/tfidf_10k')
# print(corpus)
# print(dictionary.token2id)
wordnet_lemmatizer = WordNetLemmatizer()

def is_noun(tag):
    return tag in ['NN', 'NNS', 'NNP', 'NNPS']
def is_verb(tag):
    return tag in ['VB', 'VBD', 'VBG', 'VBN', 'VBP', 'VBZ']
def is_adverb(tag):
    return tag in ['RB', 'RBR', 'RBS']
def is_adjective(tag):
    return tag in ['JJ', 'JJR', 'JJS']
def is_to_removed(tag):
    return tag[1] in ['CD', '.', ','] or (len(tag[0]) < 3)
def is_a_verb(tag):
    if is_verb(tag=tag):
        return 'v'
    else:
        return 'n'

def preprocess_input_text(input_text):
    read_data = input_text.lower()
    sentences = [s.strip() for s in read_data.splitlines()]
    words = []
    for sen in sentences:
        tokens = nltk.word_tokenize(sen)
        filtered_words = [word for word in tokens if word not in stopwords.words('english')]
        pos_tag = nltk.pos_tag(filtered_words)
        # print(pos_tag)
        for i in pos_tag:
            if not is_to_removed(i):
                words.append(wordnet_lemmatizer.lemmatize(i[0], pos=is_a_verb(i[1])))
        # texts.append(words)
    retText = ""
    for i in words:
        retText+= i + " "

    return retText



# new_doc = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
new_doc = "All elephants have several distinctive features, the most notable of which is a long trunk or proboscis, used for many purposes, particularly breathing, lifting water, and grasping objects. Their incisors grow into tusks, which can serve as weapons and as tools for moving objects and digging. Elephants' large ear flaps help to control their body temperature. Their pillar-like legs can carry their great weight. African elephants have larger ears and concave backs while Asian elephants have smaller ears and convex or level backs."
new_doc = preprocess_input_text(new_doc)

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
df = df[df[2] != 1.0]
# df.to_csv('data/word_freq.csv', sep=',', header=None, encoding='utf-8')
