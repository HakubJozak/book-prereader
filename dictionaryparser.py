import re
import os
import sys

query = sys.argv[1]
cmd = "dict -d wn %s" % query
string = os.popen(cmd).read()

string = string.split("2:")[0]
dictionary = ''

lines = re.split("\n", string)
name = lines[2].strip()

string = string.split("1:")[1]
string = string.replace("\n", "")
string = string.replace("  ", "")
print (name + ':' + string)
