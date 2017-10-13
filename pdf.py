from PyPDF2 import PdfFileWriter, PdfFileReader

input = PdfFileReader(open("test.pdf", "rb"))
page = input.getPage(0)
print (page.extractText())
