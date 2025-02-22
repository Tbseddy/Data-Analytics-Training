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

The three main components of Power BI are:
1. Power BI Desktop
2. Power BI Service
3. Power BI Report Builder

Power BI Desktop has 3 views: 
* Report view: This is wher you load your data in. In the middle of your screen where it says build visuals with your data is known as the canvas
* Data view: 
* Modeling view:

**Heirarchy:** This is the container of sorts that you would like to group together. For instance a Date Hierarchy can be broken dowun into: Year, month, day & Quarter

Databases usually have four different objects in them. The tables are the only object that holds data, there could also be queries, forms and reports. There could be macros and modules as database objects.

Icons for queries looks like a double table icon

File - Options & Settings - Options - Current - Data load - Relationships - Checkmark all three boxes under it. 

To import a data from the Internet: Copy the URL click on Get data - other - web - paste the url - 

#### Optimizing Performance
If you connect to data source, it's only going to bring in the from an excel file that resides in the excel application. If you want to bring in the other data you are going to have to import the file into Power BI. For instance the **customer data** 

If you inherit a file with a power pivot model in it and you don't have power pivot, Power BI can access the data model.

Open the Customer Data file in Excel. Click on Power Pivot - Manage. This will take us into the Power data pivot model, this is the underlying data that is providing subsets of itself for the pivot table in the Excel application. i.e feeding the pivot tables in the Excel application. If we want to look at the relationships here, Up on the ribbon we go to **diagram view** 

the diagram view is similar to model view in Power BI

File - Import - Power Query, Power pivot, Power view - Select Customer Data

Knowing when to import data versus when to connect data will optimize your performance in Power BI 















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


### How to use Power Querry in Power BI
* Pull both the **purchase overview** and the **pivot table** sheet
* Click in Transform (on the left hand side under the **Querry** you can toggle between the two sheets) On the far right side you have the **Querry settings**
* Click on Transform from the Menu bar and select use first row as Header after deleting the first two empty rows
* Filter the first column and remove empty rows
* Filter the second column and use **Text filters** to remove the Total in the column using **Does not contain** you will then type in the text you don't want
* Remove the last column which is the GrandTotal 
* Select the last four columns(dates column) and click on **Transform tab** and click on **Unpivot columns** 
* After that change the datatype to date
* Change the value to Product cost and the location to Store
* Select the pivot table
* Change the first row to column
* select Jan to April column and unpivot it
* Click on close and apply

### How to Create and Manage Relationships in Power BI
* After the data has been loaded
* select the three sheets
* Click on Model

Note: Change the cross filter direction to both, under the edit relationship

After creating the relationships between the three tables, we want to know how many product ids are being in the different states. 

* We will create a new measure (click on new measure from Table tools), type count(select apocalypse store product ID)
* you will then click on the checkmark to create it.
* **Measure** is then added under the apocalypse store.

### How to use DAX (Data Analysis Expressions)
DAX is a library of functions and operators that help you build formulas. You can use it to create measures and calculated columns within Power BI.

We will be using New measure and New column under the Table tools to create our DAX function

* Go report
* Right click on Apocalypse sales and select new measure. we can rename the measure to **count of sales** 
* Next, we want to know our big product that is selling
* select product name
* Right click on Apocalypse sales and select new measure. we can rename the measure to **Sum of product sold** 
* Input =sum(unit prize)

Adding **x** to a sum, average e.t.c can make them an iterator function

### How to use Drill Down in Power BI



### Join Types in Power BI
1. Left Outer: All the records from first the table and only the matching records from the second table.
2. Right Outer: All the records from second the table and only the matching records from the first table.
3. Full Outer: All rows from both tables.
4. Inner: Only matching rows
5. Left Anti: Rows only in first table
6. Right Anti: Rows only from second table.