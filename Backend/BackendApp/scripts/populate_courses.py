
from . import models
import openpyxl

import xlrd

loc = ("./staticfiles/S19_Course_List.xlsx")

wb = openpyxl.load_workbook(excel_file)
# getting a particular sheet by name out of many sheets
worksheet = wb["Sheet1"]
print(worksheet)

excel_data = list()
# iterating over the rows and
# getting value from each cell in row
for row in worksheet.iter_rows():
    row_data = list()
    for cell in row:
        row_data.append(str(cell.value))
    excel_data.append(row_data)
