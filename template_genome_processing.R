rm(list = ls())

#THE BLOCK OF CODE BELOW IS THE ONLY CODE THAT NEEDS TO BE EDITED
#----------------------------------------------------------------
primary_author_last_name <- "LASTNAME"
publish_year <- "YEAR"
local_xlsx_path <- "local/.xlsx/path"
#----------------------------------------------------------------
#THE BLOCK OF CODE ABOVE IS THE ONLY CODE THAT NEEDS TO BE EDITED


#creating mkdir commands for directories needed for orginanization of various files

make_project_folder <- sprintf("mkdir /groups/kojima/%s_%s", primary_author_last_name, publish_year)
make_fastq_folder <- sprintf("mkdir /groups/kojima/%s_%s/fastq_files", primary_author_last_name, publish_year)
make_STAR_folder <- sprintf("mkdir /groups/kojima/%s_%s/STAR_files", primary_author_last_name, publish_year)
make_bam_folder <- sprintf("mkdir /groups/kojima/%s_%s/bam_files", primary_author_last_name, publish_year)
make_bigwig_folder <- sprintf("mkdir /groups/kojima/%s_%s/bigwig_files", primary_author_last_name, publish_year)
make_HOMER_folder <- sprintf("mkdir /groups/kojima/%s_%s/HOMER", primary_author_last_name, publish_year)
make_HOMER_directories_folder <- sprintf("mkdir /groups/kojima/%s_%s/HOMER/HOMER_directories_files", primary_author_last_name, publish_year)
make_HOMER_output_folder <- sprintf("mkdir /groups/kojima/%s_%s/HOMER/HOMER_output_files", primary_author_last_name, publish_year)


#initializing and simplifying folder pathways for less clutter processing commands

project_folder <- sprintf("/groups/kojima/%s_%s", primary_author_last_name, publish_year)
fastq_folder <- sprintf("/groups/kojima/%s_%s/fastq_files", primary_author_last_name, publish_year)
STAR_folder <- sprintf("/groups/kojima/%s_%s/STAR_files", primary_author_last_name, publish_year)
bam_folder <- sprintf("/groups/kojima/%s_%s/bam_files", primary_author_last_name, publish_year)
bigwig_folder <- sprintf("/groups/kojima/%s_%s/bigwig_files", primary_author_last_name, publish_year)
HOMER_directories_folder <- sprintf("/groups/kojima/%s_%s/HOMER/HOMER_directories_files", primary_author_last_name, publish_year)
HOMER_output_folder <- sprintf("/groups/kojima/%s_%s/HOMER/HOMER_output_files", primary_author_last_name, publish_year)


#creating .txt file with finished data processing commands

txt_file <- sprintf("%s_%s_commands.txt", primary_author_last_name, publish_year)
sink(file = txt_file)


#initializing the properly formatted xlsx spreadsheet

xlsx_file <- read_excel(local_xlsx_path) #importing data from correctly formatted excel spreadsheet


#adding commands needed for proper paths and creation of directories

cat("#***ATTENTION: The lines below must be ran through the Cascades Server Terminal first.  They create the folders and paths needed for the following codes to run.***")
cat("\n\n")
cat("if [[ -f /etc/bashrc && ! $BASH_SOURCED ]]; then")
cat("\n")
cat("   . /etc/bashrc")
cat("\n")
cat("fi")
cat("\n\n")
cat("PATH=$PATH:/groups/kojima/Softwares/sratoolkit.2.9.2-centos_linux64/bin/")
cat("\n")
cat("PATH=$PATH:/groups/kojima/Softwares/samtools-1.11/")
cat("\n")
cat("PATH=$PATH:/groups/kojima/Softwares/STAR-2.7.7a/source/")
cat("\n")
cat("PATH=$PATH:/groups/kojima/Softwares/HOMER/bin/")
cat("\n")
cat("PATH=$PATH:/groups/kojima/Softwares/seqtk/")
cat("\n")
cat("PATH=$PATH:/groups/kojima/Softwares/fasta-to-gtf-master/src/")
cat("\n")
cat("PATH=$PATH:/groups/kojima/Softwares/bed2gtf-master/")
cat("\n")
cat("PATH=$PATH:/groups/kojima/Softwares/fastq-tools-master/src/")
cat("\n\n")
cat(make_project_folder)
cat("\n")
cat(make_fastq_folder)
cat("\n")
cat(make_STAR_folder)
cat("\n")
cat(make_bam_folder)
cat("\n")
cat(make_bigwig_folder)
cat("\n")
cat(make_HOMER_folder)
cat("\n")
cat(make_HOMER_directories_folder)
cat("\n")
cat(make_HOMER_output_folder)
cat("\n\n")
cat("#***ATTENTION: The lines above must be ran through the Cascades Server Terminal first.  They create the folders and paths needed for the following codes to run.***")
cat("\n\n\n\n")


#intitalizing count variables

i <- 1 #initializing count variable for commands while loop
count <- 1 #initializing count variable for fastq files while loop
end_of_data <- "no" #initializing exit variable for fastq files while loop


#fastq files while loop
#This while loop counts the amount of SRR files contained in the imported excel spreadsheet.
#This negates the need to adjust the exit i value in the commands while loop.
#None of this while loop needs to be adjusted as long as excel spreadsheet is in the correct format.

while(end_of_data == "no"){
  if(grepl("SRR", xlsx_file[count,3]) == TRUE){
    count <- count+1
    end_of_data <- "no"
  } else {
    end_of_data <- "yes"
    count <- count-1
  }
}



#commands while loop
#This while loop generates and adds all the commands necessary to go from a SRR number to bigwig and HOMER files ready for visualization and quantification to the command .txt files.
#None of this while loop needs to be adjusted as long as excel spreadsheet is in the correct format.

while (i <= count){
  srr <- xlsx_file[i,3]
  filename <- xlsx_file[i,1]
  fastq_file_command <- sprintf("/groups/kojima/Softwares/sratoolkit.2.9.2-centos_linux64/bin/fasterq-dump %s --outdir %s/%s", srr, fastq_folder, srr)
  STAR_command <- sprintf("/groups/kojima/Softwares/STAR-2.7.7a/bin/Linux_x86_64/STAR --runThreadN 16 --genomeDir /groups/kojima/Softwares/STAR-2.7.7a/mm10/ \\--sjdbGTFfile /groups/kojima/Softwares/STAR-2.7.7a/mm10/mm10.ncbiRefSeq.gtf --sjdbOverhang 100 \\--outFilterScoreMinOverLread 0.3 \\—outFilterMatchNminOverLread 0.3 \\--readFilesIn %s/%s/%s.fastq \\--outSAMtype BAM Unsorted \\--outFileNamePrefix %s/%s_%s", fastq_folder, srr, srr, STAR_folder, srr, filename)
  bam_sort_command <- sprintf("/groups/kojima/Softwares/samtools-1.11/samtools sort -o %s/%sSI.bam %s/%s_%s_STARgenome/%s_%sAligned.out.bam", bam_folder, filename, STAR_folder, srr, filename, srr, filename)
  bam_index_command <- sprintf("/groups/kojima/Softwares/samtools-1.11/samtools index %s/%sSI.bam", bam_folder, srr)
  forward_bigwig_command <- sprintf("/groups/kojima/Softwares/deepTools3.5.1/bin/bamCoverage -b %s/%sSI.bam -o %s/%sfwd.bw --filterRNAstrand forward", bam_folder, filename, bigwig_folder, filename)
  reverse_bigwig_command <- sprintf("/groups/kojima/Softwares/deepTools3.5.1/bin/bamCoverage -b %s/%sSI.bam -o %s/%srev.bw --filterRNAstrand reverse", bam_folder, filename, bigwig_folder, filename)
  HOMER_directories_command <- sprintf("/group/kojima/Softwares/HOMER/bin/makeTagDirectory %s/%s_tags %s/%s_%s_STARgenome/%s_%sAligned.out.bam", HOMER_directories_folder, srr, STAR_folder, srr, filename, srr, filename)
  HOMER_output_command <- sprintf("/group/kojima/Softwares/HOMER/bin/analyzeRepeats.pl /groups/kojima/Softwares/HOMER/gencode.vM25.annotation.gtf mm10 -count genes -tpm -d %s/%s_tags > %s/mm10.%s", HOMER_directories_folder, srr, HOMER_output_folder, srr)
  srr_start <- sprintf("#%s_%s START", srr, filename)
  srr_finish <- sprintf("#%s_%s FINISHED", srr, filename)
  
  cat(srr_start)
  cat("\n")
  cat(fastq_file_command)
  cat("\n\n")
  cat(STAR_command)
  cat("\n\n")
  cat(bam_sort_command)
  cat("\n\n")
  cat(bam_index_command)
  cat("\n\n")
  cat(forward_bigwig_command)
  cat("\n\n")
  cat(reverse_bigwig_command)
  cat("\n\n")
  cat(HOMER_directories_command)
  cat("\n\n")
  cat(HOMER_output_command)
  cat("\n")
  cat(srr_finish)
  cat("\n\n\n\n")
  
  i <- i+1
}

sink(file = NULL)

