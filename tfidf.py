
from gensim import corpora, models, similarities
from nltk.tokenize import word_tokenize



# model = Word2Vec(sentences, size=100, window=5, min_count=5, workers=4)
# model.save(fname)
# model = Word2Vec.load(fname)  # you can continue training with the loaded model!
#


documents = ['Once upon a time, there was a girl named Cinderella. All Cinderella did all day, every day, was scrub the floor, do the laundry, cook the meals, and wash the dishes.',
'Cinderella lived with her stepmother and stepsisters, Ivy and Esmerelda. They made her do all the work around the house while they did nothing at all!',
'One day, an invitation arrived for a ball at the castle hosted by the prince. Every maiden in the kingdom was invited. The stepsisters couldn’t wait! They went through their closets to find their fanciest gowns to wear to the ball.',
'Cinderella dreamed of going to a ball at the castle.',
'“May I borrow a dress to wear to the ball?” she asked her stepsisters hopefully.',
'“You?!” Esmerelda jeered. “You’re not invited.”',
'“But I thought everyone was invited!” protested Cinderella.',
'“Cinderella,” Ivy continued, “you have too much work to do. No ball at the castle for you!”',
'On the day of the ball, Cinderella desperately wanted to see the castle and get a peek at the ball, so she followed her stepmother and stepsisters. As the stepsisters entered, Cinderella admired the castle from afar, wishing she could go inside. She looked down at her old dress, wishing she had a fancy dress too.',
'“Oh, how I wish I had something to wear so that I could go to the ball too!” Cinderella cried.',
'Then, out of nowhere, a magical little woman appeared.',
'“Did I hear someone say wish?” she asked, smiling.',
'“Who are you?” Cinderella asked.'
]
stoplist = set("for . , ? ' ! t there here who what which have get got may but a are as an all of the and to in all at they i he she we you could can was every each is has had did do their his her your our my".split())
texts = [[word.lower() for word in word_tokenize(document) if word.lower() not in stoplist] for document in documents]

# remove words that appear only once
# from collections import defaultdict
# frequency = defaultdict(int)
# for text in texts:
#     for token in text:
#         frequency[token] += 1

# texts = [[token for token in text if frequency[token] > 1] for text in texts]

from pprint import pprint  # pretty-printer
# pprint(texts)

dictionary = corpora.Dictionary(texts)
# print(dictionary.token2id)

new_doc ='Cinderella lived with her stepmother and stepsisters, Ivy and Esmerelda. They made her do all the work around the house while they did nothing at all!'
new_vec = dictionary.doc2bow(new_doc.lower().split())
# print(new_vec)  # the word "interaction" does not appear in the dictionary and is ignored

corpus = [dictionary.doc2bow(text) for text in texts]
# print(corpus)
tfidf = models.TfidfModel(corpus)
corpus_tfidf = tfidf[corpus]
d = {}
for doc in corpus_tfidf:
    for id, value in doc:
        word = dictionary.get(id)
        d[word] = value
pprint(d)



index = similarities.SparseMatrixSimilarity(tfidf[corpus], num_features=120)
sims = index[tfidf[new_vec]]
# print(list(enumerate(sims)))
