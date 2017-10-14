import nltk
from nltk.corpus import stopwords
from nltk.tokenize import word_tokenize
from nltk.stem import WordNetLemmatizer
from gensim import corpora, models, similarities

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


file = 'data/eng_wikipedia_2016_100K-sentences.txt'
with open(file, encoding="utf8") as f:
    read_data = f.read()
f.close()
read_data = read_data.lower()
sentences = [s.strip() for s in read_data.splitlines()]
texts = []
for sen in sentences:
    tokens = nltk.word_tokenize(sen)
    filtered_words = [word for word in tokens if word not in stopwords.words('english')]
    pos_tag = nltk.pos_tag(filtered_words)
    # print(pos_tag)
    words = []
    for i in pos_tag:
        if not is_to_removed(i):
            words.append(wordnet_lemmatizer.lemmatize(i[0], pos=is_a_verb(i[1])))
    texts.append(words)
    # print(words)
dictionary = corpora.Dictionary(texts)

corpus = [dictionary.doc2bow(text) for text in texts]
# print(corpus)
tfidf = models.TfidfModel(corpus)
corpus_tfidf = tfidf[corpus]
tfidf.save('data/tfidf_100k')
corpora.MmCorpus.serialize('data/corpus100k.mm', corpus)
dictionary.save('data/dict100k.dict')

    # dictionary.token2id
