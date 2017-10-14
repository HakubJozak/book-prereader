import re

with open('teststring2', 'rt') as f:
	string = f.read()

print (string)

string = string.split("2:")[0]
dictionary = ''

lines = re.split("\n", string)
name = lines[2].strip()

string = string.split("1:")[1]
string = string.replace("\n", "")
string = string.replace("  ", "")
print (name + ':' + string)


 

