import nltk

modules = [ 'averaged_perceptron_tagger', 'stopwords', 'wordnet' ]

for m in modules:
    nltk.download(m)    
