# kojima_undergraduate_lab


## My name is Kyle Batty, I am an undergraduate research assistant for Dr. Kojima's lab.  I wrote the code in this repository in an effort to stream line the RNA-seq data processing system currently in place.  A couple notes to make this a better experience for all of us:
###   1) I have about 10-15 hours of experience with RStudio so in no way is this code written in an effecient manner but it works.
###   2) I ran all my commands through the cascades virtual terminal via https://ondemand.arc.vt.edu > Clusters > Cascades Shell Access.
###   3) I have an elementary understanding of the ARC.  I have written down techniques I used to download/install certain packages and softwares but there is most likely an easier/correct way to do those.
###   4) Lastly, I'm OCD when it comes to organizing files so every step is accompanied with its own directory for each file type.

## With that being said, I'll jump right in on how to get started!

### The very first step is to choose your data set, analyze it using https://www.ncbi.nlm.nih.gov, and organize its information into an excel spreadsheet.  The formatting of the spreadsheet is VERY important.  VERY, VERY, VERY important.  I attatched .xlsx file to this repository with a few examples of the formatting.  A couple things to keep in mind when writing this spreadsheet.
###   1) Don't forget to label each column in 'row 1'
###   2) Although not necessary, it makes tracking progress easier if you sort the data using the 'SRX' from 'A -> Z' so the lowest 'SRX' is at the top of the spreadsheet.  Remember to 'expand selection' when using excels sorting function.
###   3) Take note of which folder you save the spreadsheet to.  A following step involves finding and copying the 'local path' to the spreadsheet.  This is the specific location where the spreadsheet is located locally on your computer. 
