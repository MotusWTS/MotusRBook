# Instructions to Prepare a Book Release
if(!file.exists("WORDLIST")) file.create("WORDLIST")

# 1. Install required packages
pkgs <- c("knitr", "pander", "remotes", "maps", "tidyverse", "rworldmap", "ggmap", 
       "plyr", "circular", "jpeg", "DBI", "RSQLite")
pkgs_new <- pkgs[!(pkgs %in% installed.packages()[,"Package"])] # Which are we missing?
if(length(pkgs_new)) install.packages(pkgs_new) # Install missing

# 2. Install the version of motus the book should be compiled with (ie. which ref?)
remotes::install_github("MotusWTS/motus", ref = "beta3")
if(!"motusData" %in% installed.packages()[, "Package"]) remotes::install_github("MotusWTS/motusData")

# 2. Check spelling
# List dubious words (fix them in the .Rmd files if they are typos)
spelling::spell_check_files(list.files(pattern = ".Rmd"), 
                            lang = "en_CA",
                            ignore = readLines("WORDLIST"))

# Add remaining words to ignore list
s <- spelling::spell_check_files(list.files(pattern = ".Rmd"), 
                                 lang = "en_CA",
                                 ignore = readLines("WORDLIST"))
write(s$word, "WORDLIST", append = TRUE)

# 3. Compile Chapters in html and in pdf
# To compile a single chapter
bookdown::preview_chapter("03-AccessingData.Rmd")
bookdown::preview_chapter("05-DataCleaning.Rmd")

# To compile the entire book
file.remove("./data/project-176.motus") # Start clean (not necessary if fiddling)
bookdown::render_book("index.Rmd", output_format = "all")

# 4. Post
# The compiled html version of the book is now in "./_book"
# The compiled pdf version of the book is now in "./_book/MotusRBook.pdf"

