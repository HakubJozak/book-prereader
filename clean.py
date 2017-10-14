import nltk
from nltk.corpus import stopwords
from nltk.tokenize import word_tokenize
from nltk.stem import WordNetLemmatizer


def pre_process_text(intput_text):
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

    wordnet_lemmatizer = WordNetLemmatizer()

    read_data = intput_text.lower()
    sentences = [s.strip() for s in read_data.splitlines()]
    texts = []

    for sen in sentences:
        tokens = nltk.word_tokenize(sen)
        filtered_words = [word for word in tokens if word not in stopwords.words('english')]
        pos_tag = nltk.pos_tag(filtered_words)
        words = []
        for i in pos_tag:
            if not is_to_removed(i):
                words.append(wordnet_lemmatizer.lemmatize(i[0], pos=is_a_verb(i[1])))
        texts.append(words)
    return texts


t = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
print(pre_process_text(t))