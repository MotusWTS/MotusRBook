# Instructions to Prepare a Book Release
if(!file.exists("WORDLIST")) file.create("WORDLIST")

# 1. Check spelling
# List dubious words (fix them in the .Rmd files if they are typos)
spelling::spell_check_files(list.files(pattern = ".Rmd"), 
                            lang = "en_CA",
                            ignore = readLines("WORDLIST"))
# Add remaining words to ignore list
s <- spelling::spell_check_files(list.files(pattern = ".Rmd"), 
                                 lang = "en_CA",
                                 ignore = readLines("WORDLIST"))
write(s$word, "WORDLIST", append = TRUE)

# 2. Install the version of motus the book should be compiled with
remotes::install_github("MotusWTS/motus", ref = "staging")

# 3. Compile Chapters
# To compile a single chapter
bookdown::preview_chapter("05-DataCleaning.Rmd")

# To compile the entire book
bookdown::render_book("index.Rmd")

# 4. Post
# The compiled html version of the book is now in "./_book"

