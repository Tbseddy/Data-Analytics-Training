# Data-Analytics-Training

### Excel

MAX: =max(H2:H10)

MIN: =min(H2:H10)

#### IF
=IF(logical test,[value_if_true],[value_if_false])

=IF(D2:D10>30,"Old","Young")

#### IFS

You can use this when you have multiple condition

=IFS(F2:F10="Salesman","Sales",F2:F10="HR","Fire Immediately",F2:F10="Regional Manager","Give Christmas Bonus")

#### LEN
This can be used to see the difference between 100s and thousands. It can be used to find bad social security numbers if they are 10 digits instead of 9

=LEN(C2:C10)

#### LEFT & RIGHT

=LEFT(B2:B10,3)
This will take the first 3 characters

=RIGHT(A2:A10,1)

=RIGHT(H2:H10,4)

#### DateToText

=TEXT(H2:H10,"dd/mm/yyy")

#### TRIM
This removes all spaces from the text string except for single space between words

=TRIM(C2:C10)

#### Concatenate
This is used to join two or more text strings into one string

=CONCATENATE(B2,"",C2) 
This is used to combine FirstName and Lastname

=CONCATENATE(B2,"_",C2,"@gmail.com")
This is used to generate email

#### Substitute
It replaces existing text with a new text in a text string

=SUBSTITUTE(H2:H10,"-","/")

=SUBSTITUTE(H2:H10,"/","-",1)

#### SUM

=SUM(G2:G10)

=SUMIF(G2:G10,">50000")
This will only add up if salary is greater than 50,000

=SUMIFS(G2:G10,E2:E10,"Female",D2:D10,">30")
This will only add up the salary if the gender is female and the age is greater than 30

#### COUNT

=COUNT(G2:G10)
This is to count the number of cells

=COUNTIF(G2:G10,">45000)
This is to count how many people has the salary of over 45,000

=COUNTIFS(A2:A10,">1005",E2:E10,"Male")
This is to count numbers of male employees whose employee_id is greater than 1005

#### DAYS

=DAYS(end_date,start_date)

=DAYS(I2,H2)

#### NETWORKDAYS

=NETWORKDAYS(start_date,end_date,[holidays])

#### XLOOKUP
This searches a range or array for a match and returns the corresponding item from a second range or array. By default, an exact match is used.

=XLOOKUP(lookup_value,lookup_array,return_array)

=XLOOKUP(A3,H2:H10,P2:P10)

> Note: Old fashion versions of MS-Office does not support XLOOKUP, you can then use the INDEX and MATCH in this case

=INDEX(P2:P10, MATCH(A3,H2:H10,0))


## Power BI
Once you open Power Bi click on Get data or Blank report 
* Click on get data from another source
* Click on e.g. Excel workbook and then click on connect
* select your file
* Under the Navigator, select the sheet you want to use
* Click load or transform
* After loading your file, click on report tab from the left hand side. This is where we will build our visualization. 
* Go to the visualization section on the right hand side
* select the columns you want to visualize under the field and then select the visualization type you want
* To add Legend, drag and drop the store column in side the legend under the visualization section.

We are trying to find out which store we are spending the most amount of money 

For the second 
* we will select product. price, and store
* select the clustered column charts

This will show show us how much we are paying per store for each product

* To change the title of the charts, click on the each chart and then click on format your visual in the visualization section
* Click on General
* Click Title and then give the desired name you want 

* Click on Visuals
* toggle on **Data labels** it actual rounding the numbers but to change this to an actual number
* Click on Data labels,  Click on **Values**, **Display Unit**
* change the Auto to none

