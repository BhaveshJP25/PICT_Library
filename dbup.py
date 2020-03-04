from firebase import firebase
import csv
import requests
import os
# os.delete("sdb")
# csv_url = ""
# r = requests.get(csv_url)
# os.rename("download", "sdb")

#fields: name of the book, author, due-date -> colour change

fb = firebase.FirebaseApplication("https://pict-library.firebaseio.com/", None)

#result = fb.delete("/pict-lib/Students", "")

with open("sdb.csv", "r") as f:
    fh = csv.DictReader(f)
    for record in fh:
    	result = fb.post("/pict-lib/Students", record)

result = fb.get("/pict-lib/Students", "")
print(result)


# #CREATE
# data = {
# "Name": "John Manglani",
# "Email": "john.gm.api@gmail.com",
# "Phone": 100000000
# }
#
# #result = fb.post("/pict-lib/Customer", data)
# #print(result)
#
#
# #READ
# result = fb.get("/pict-lib/Customer", "")
# print(result)
#
# #UPDATE
# #result = fb.put("/pict-lib/Customer/-M1QgljyjZ17YOaSPLUm", "Name", "Bobby Singer")
# result = fb.get("/pict-lib/Customer", "")
# print(result)
#
# #DELETE
# result = fb.delete("/pict-lib/Customer", "")
