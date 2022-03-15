# kojima_undergraduate_lab


## My name is Kyle Batty, I am an undergraduate research assistant for Dr. Kojima's lab.  I wrote the code in this repository in an effort to stream line the RNA-seq data processing system currently in place.  A couple notes to make this a better experience for all of us:
###   1) I have about ~30 hours of experience with RStudio so in no way is this code written in an effecient manner but it works.
###   2) I ran all my commands through the cascades virtual terminal via https://ondemand.arc.vt.edu > Clusters > Cascades Shell Access.
###   3) I have an elementary understanding of the ARC.  I have written down techniques I used to download/install certain packages and softwares but there is most likely an easier/correct way to do those.
###   4) Lastly, I'm OCD when it comes to organizing files so every step is accompanied with its own directory for each file type.

## With that being said, I'll jump right in on how to get started!

### The very first step is to choose your data set, analyze it using https://www.ncbi.nlm.nih.gov, and organize its information into an excel spreadsheet.  The formatting of the spreadsheet is VERY important.  VERY, VERY, VERY important.  I attatched a .xlsx file to this repository with a few examples of the formatting.  A couple things to keep in mind when writing this spreadsheet.
###   1) Don't forget to label each column in 'row 1'
###   2) Although not necessary, it makes tracking progress easier if you sort the data using the 'SRX' from 'A -> Z' so the lowest 'SRX' is at the top of the spreadsheet.  Remember to 'expand selection' when using excels sorting function.
###   3) Take note of which folder you save the spreadsheet to.  A following step involves finding and copying the 'local path' to the spreadsheet.  This is the specific location where the spreadsheet is located locally on your computer. 

### Once the spreadsheet is written and formatted correctly, a couple pieces of the code must be edited to reflect the specific data set being analyzed.  The lines that need to be edited are as follows:
###   Line 5 - replace 'LASTNAME' with the last name of the primary author of the dataset.
###   Line 6 - replace 'YEAR' with the four digit year when the dataset was published.
###   Line 7 - replace 'local/.xlsx/path' with the local path to the .xlsx file.  This part can be a little confusing.  Typically, on a mac, the easiest way to copy the local path to a file is to find the file in 'finder'.  Then go to the 'view' tab and select 'show path bar'.  This will show the file path on the bottom of the 'finder' window.  You can than right click on the file path and "copy file.xlsx as Pathname".  This can then be pasted to the code.

### After editing the above code, the data from the spreadsheet must be imported into the R environment. To do this, follow these steps:
###   1) In R Studio, open the file tab.  Find and hover over the 'Import Dataset' tab and select 'From Excel...'.
###   2) An 'Import Excel Data' window will open.  In the 'file/URL:' text box, paste the pathname that was used in line 7 of the code.
###   3) Select 'Import'.  This will open your dataset in a R Studio tab.  You can use this as an opportunity to double check the data for errors.

### Thats it!  Now just run the code by selecting the 'Source' tab and it will output a .txt file named 'LASTNAME_YEAR_commands.txt'.  Open this file in any text editor, delete the first 3 lines (they contain only '-' and '/' and I dont know why), then copy and paste the contents of the file and run it through the ARC.
