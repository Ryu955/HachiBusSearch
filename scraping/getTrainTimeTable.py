import csv
from urllib.request import urlopen
from bs4 import BeautifulSoup

#URLの指定
html = urlopen("http://timetable.ekitan.com/train/TimeStation/25-0_D1.shtml")
bsObj = BeautifulSoup(html, "html.parser")

#テーブルを指定
table = bsObj.findAll("table")[0]
rows = table.findAll("tr")

csvFile = open("TrainTimeTable.csv", 'wt', newline = '', encoding = 'utf-8')
writer = csv.writer(csvFile)

try:
    for row in rows:
        csvRow = []
        for cell in row.findAll(['td', 'th']):
            csvRow.append(cell.get_text())
        writer.writerow(csvRow)
finally:
    csvFile.close()
