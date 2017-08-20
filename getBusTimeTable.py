import csv
from urllib.request import urlopen
from bs4 import BeautifulSoup

#URLの指定
html = urlopen("http://www.teu.ac.jp/campus/access/2017_kihon-a_bus.html")
bsObj = BeautifulSoup(html, "html.parser")

#テーブルを指定
table = bsObj.findAll("table")[1]
rows = table.findAll("tr")

csvFile = open("timeTable.csv", 'wt', newline = '', encoding = 'utf-8')
writer = csv.writer(csvFile)

try:
    for row in rows:
        csvRow = []
        for cell in row.findAll(['td', 'th']):
            csvRow.append(cell.get_text())
        writer.writerow(csvRow)
finally:
    csvFile.close()
