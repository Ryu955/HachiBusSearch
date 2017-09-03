import csv
from urllib.request import urlopen
from bs4 import BeautifulSoup

#URLの指定
html = urlopen("http://www.teu.ac.jp/campus/access/2017_kihon-a_bus.html")
bsObj = BeautifulSoup(html, "html.parser")

#テーブルを指定
table = bsObj.findAll("table")[1]
rows = table.findAll("tr")

csvFile = open("BusTimeTable.csv", 'wt', newline = '', encoding = 'utf-8')
writer = csv.writer(csvFile,lineterminator=',')

try:
    for row in rows:
        csvRow = []
        for cell in row.findAll(['td', 'th']):
            text = cell.get_text()
            if(text == '～'):
                print('波線')
            elif(text == ''):
                print('空白')
            else:
                csvRow.append(text)
                print(text)
        writer.writerow(csvRow)
finally:
    csvFile.close()
