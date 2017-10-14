from PyPDF2 import PdfFileWriter, PdfFileReader
import sys
from collections import Counter


pdfFile = sys.argv[1]
input = PdfFileReader(open(pdfFile, "rb"))
numOfPages = input.getNumPages()

for i in range(numOfPages):
    page = input.getPage(i)
    data = page.extractText()
    data = data.split()
    
data = Counter(data)
print (data)

