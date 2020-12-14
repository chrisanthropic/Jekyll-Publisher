require 'fileutils'
require 'rake'

################
#     SKEL     #
################
task :skel do
desc "Populate Source with Example"
  FileUtils.cp_r "./Skel/.", "./Source"
end

################
#    Create    #
################ 
task :create do
desc "Building our scaffolding; putting expected files in their place."    
  def prompt(*args)
    print(*args)
    STDIN.gets.chomp
  end
    
  title = prompt "What is the title of your book? "
  FileUtils.mkdir_p "Source/#{title}/"

  filename = "Source/#{title}/#{title}-Amazon.md"
    open(filename, 'w') do |create|
      create.puts "---"
      create.puts "layout: #{title}/amazon"
      create.puts "---"
    end
    
  filename = "Source/#{title}/#{title}-epub.md"
    open(filename, 'w') do |create|
      create.puts "---"
      create.puts "layout: #{title}/epub"
      create.puts "---"
    end
    
  filename = "Source/#{title}/#{title}-pdf.md"
    open(filename, 'w') do |create|
      create.puts "---"
      create.puts "layout: #{title}/pdf"
      create.puts "---"
    end
    
  filename = "Source/#{title}/#{title}-Smashwords.md"
    open(filename, 'w') do |create|
      create.puts "---"
      create.puts "layout: #{title}/epub"
      create.puts "---"
    end


  FileUtils.mkdir_p "Source/_layouts/#{title}/"
  
  filename = "Source/_layouts/#{title}/amazon.md"
    open(filename, 'w') do |create|
      create.puts "{% include #{title}/amazon.md %}"
      create.puts "{% include magnet_tah.md %}"
      create.puts "{% include bio.md %}"
      create.puts "{% include bibliography.md %}"
      create.puts "{% include license.md %}"
    end
    
  filename = "Source/_layouts/#{title}/epub.md"
    open(filename, 'w') do |create|
      create.puts "{% include #{title}/chapters.md %}"
      create.puts "{% include magnet_tah.md %}"
      create.puts "{% include bio.md %}"
      create.puts "{% include bibliography.md %}"
      create.puts "{% include license.md %}"
    end

  filename = "Source/_layouts/#{title}/pdf.md"
    open(filename, 'w') do |create|
      create.puts "{% include #{title}/chapters.md %}"
    end
    

  FileUtils.mkdir_p "Source/_includes/#{title}/"

  filename = "Source/_includes/#{title}/chapters.md"
    open(filename, 'w') do |create|
      create.puts "---"
      create.puts "title: #{title}"
      create.puts "subtitle:"
      create.puts "author:"
      create.puts "website:"
      create.puts ""
      create.puts "type: [GENRE]"
      create.puts "lang: en-US"
      create.puts "date: YYYY-MM-DD"
      create.puts "year: YYYY"
      create.puts ""
      create.puts "cover-image: Source/images/XXXXX.jpg"
      create.puts ""
      create.puts "publisher:" 
      create.puts "rights: This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 4.0 Unported License."
      create.puts ""
      create.puts "paperback-isbn:"
      create.puts "hardcover-isbn:"
      create.puts "epub-isbn:"
      create.puts ""
      create.puts "dedication: Dedicated to my readers."
      create.puts ""
      create.puts "identifier:"
      create.puts "    - scheme: UUID"
      create.puts "      text: [Grab a free Version4 UUID from here: https://www.uuidgenerator.net/version4]"
      create.puts ""      
      create.puts "contributors:"
      create.puts "    - designer:"
      create.puts "      artist:" 
      create.puts "      editor:" 
      create.puts ""
      create.puts "book1:" 
      create.puts "    - title: Any book you've written"
      create.puts "      link: http://www.amazon.com/dp/XXXXXXXX"
      create.puts "book2:"
      create.puts "    - title: These books get added to the title page"
      create.puts "      link: and for Amazon, they use the links you provide here"
      create.puts "book3:"
      create.puts "    - title: You can add up to 5 books"
      create.puts "      link:"
      create.puts ""    
      create.puts "review:"
      create.puts "    - amazon: https://www.amazon.com/review/create-review?asin=XXXXXXX"
      create.puts ""    
      create.puts "---"
      create.puts "# Chapter Title"
      create.puts "Paste your manuscript here."
    end
    
  filename = "Source/_includes/#{title}/amazon.md"
    open(filename, 'w') do |create|
      create.puts "{% include #{title}/chapters.md %}"
      create.puts "{% include #{title}/amazon_review.md %}"
    end
    
  filename = "Source/_includes/#{title}/amazon_review.md"
    open(filename, 'w') do |create|
      create.puts "\\"
      create.puts "\\"
      create.puts "##### If you enjoyed this book please consider leaving a [review](https://www.amazon.com/review/create-review?asin=XXXXXXXXXX) on Amazon."
    end
  
  puts ""  
  puts "Paste your manuscript into Source/_includes/#{title}/chapters.md"
  puts ""  
end

##################
#     Destroy    #
################## 
task :destroy do
desc "Removing scaffoling of specified book."
  def prompt(*args)
    print(*args)
    STDIN.gets.chomp
  end
    
  title = prompt "What is the title of your book? "
  
  FileUtils.rm_r "Source/#{title}"
  FileUtils.rm_r "Source/_layouts/#{title}"
  FileUtils.rm_r "Source/_includes/#{title}"
  FileUtils.rm_r "Books/#{title}"
  FileUtils.rm_r "_site/#{title}"
end

###############
#     Bind    #
###############

#### JEKYLL
task :jekyll do
desc "Jekyll is muxing our markdown."
  system "bundle exec jekyll build"
end

#### RENAME
task :rename do
desc "Rename all .html files in _site to .md instead."
  Dir.glob('_site/*/*.html').each do |f|
    FileUtils.mv f, "#{File.dirname(f)}/#{File.basename(f,'.*')}.md"
  end
end

#### EPUB
task :epub, [:book] do |task, args|

Rake::Task[:jekyll].invoke
Rake::Task[:rename].invoke
    
desc "Create epub versions of our book(s)."
  if "#{args.book}" == "all"
    filelist = Rake::FileList["_site/*/*-epub*"]
    fullfiles = filelist.pathmap("%n")
    files = fullfiles.gsub!(/\b-epub\b/, "")
    files.each do |file|
      FileUtils.mkdir_p "Books/#{file}"
      system "pandoc --top-level-division=chapter --toc-depth=1 --template=Pandoc/templates/custom-epub.html --css=Pandoc/css/style.css -f markdown+smart -o Books/#{file}/#{file}.epub _site/*/#{file}-epub.md"
    end            
  else 
      FileUtils.mkdir_p "Books/#{args.book}"
      system "pandoc --top-level-divison=chapter --toc-depth=1 --template=Pandoc/templates/custom-epub.html --css=Pandoc/css/style.css -f markdown+smart -o Books/#{args.book}/#{args.book}.epub _site/*/#{args.book}-epub.md"
  end
end

#### SMASHWORDS
task :smashwords, [:book] do |task, args|
    
Rake::Task[:jekyll].invoke
Rake::Task[:rename].invoke
    
desc "Create Smashwords epub versions of our book(s)."
  if "#{args.book}" == "all"
    filelist = Rake::FileList["_site/*/*-Smashwords*"]
    fullfiles = filelist.pathmap("%n")
    files = fullfiles.gsub!(/\b-Smashwords\b/, "")
    files.each do |file|
      FileUtils.mkdir_p "Books/#{file}"
      system "pandoc --top-level-divison=chapter --toc-depth=1 --template=Pandoc/templates/smashwords-epub.html --css=Pandoc/css/style.css -f markdown+smart -o Books/#{file}/#{file}-Smashwords.epub _site/*/#{file}-epub.md"
    end            
  else 
      FileUtils.mkdir_p "Books/#{args.book}"
      system "pandoc --top-level-divison=chapter --toc-depth=1 --template=Pandoc/templates/custom-epub.html --css=Pandoc/css/style.css -f markdown+smart -o Books/#{args.book}/#{args.book}-Smashwords.epub _site/*/#{args.book}-Smashwords.md"
  end
end

#### AMAZON
task :amazon, [:book] do |task, args|
    
Rake::Task[:jekyll].invoke
Rake::Task[:rename].invoke
    
desc "Create Amazon mobi versions of our book(s)."
  if "#{args.book}" == "all"
    filelist = Rake::FileList["_site/*/*-Amazon*"]
    fullfiles = filelist.pathmap("%n")
    files = fullfiles.gsub!(/\b-Amazon\b/, "")
    files.each do |file|
      FileUtils.mkdir_p "Books/#{file}"
      system "pandoc --top-level-divison=chapter --toc-depth=1 --template=Pandoc/templates/amazon-epub.html --css=Pandoc/css/style.css -f markdown+smart -o Books/#{file}/#{file}-Amazon.epub _site/*/#{file}-Amazon.md"
      
    system "kindlegen -c2 Books/#{file}/#{file}-Amazon.epub"
    FileUtils.rm_r "Books/#{file}/#{file}-Amazon.epub"
    end            
  else 
    FileUtils.mkdir_p "Books/#{args.book}"
    system "pandoc --top-level-divison=chapter --toc-depth=1 --template=Pandoc/templates/amazon-epub.html --css=Pandoc/css/style.css -f markdown+smart -o Books/#{args.book}/#{args.book}-Amazon.epub _site/*/#{args.book}-Amazon.md"
    system "kindlegen -c2 Books/#{args.book}/#{args.book}-Amazon.epub"
    FileUtils.rm_r "Books/#{args.book}/#{args.book}-Amazon.epub"
  end
end

#### PRINT 5x8
task :print, [:book] do |task, args|
desc "Create Smashwords epub versions of our book(s)."

Rake::Task[:jekyll].invoke
Rake::Task[:rename].invoke

system "pandoc --pdf-engine=xelatex -o Books/bio.tex Source/_includes/bio.md"

  if "#{args.book}" == "all"
    filelist = Rake::FileList["_site/*/*-pdf*"]
    fullfiles = filelist.pathmap("%n")
    files = fullfiles.gsub!(/\b-pdf\b/, "")
    files.each do |file|
      FileUtils.mkdir_p "Books/#{file}"
      system "pandoc --top-level-divison=chapter --template=Pandoc/templates/cs-5x8-pdf.latex --pdf-engine=xelatex --pdf-engine-opt=-output-driver='xdvipdfmx -V 3 -z 0' -f markdown+backtick_code_blocks -o Books/#{file}/#{file}-5x8-print.pdf -A Books/bio.tex _site/*/#{file}-pdf.md"
    end            
  else 
      FileUtils.mkdir_p "Books/#{args.book}"
      system "pandoc --top-level-divison=chapter --template=Pandoc/templates/cs-5x8-pdf.latex --pdf-engine=xelatex --pdf-engine-opt=-output-driver='xdvipdfmx -V 3 -z 0' -f markdown+backtick_code_blocks -o Books/#{args.book}/#{args.book}-5x8-print.pdf -A Books/bio.tex _site/*/#{args.book}-pdf.md"
  end
end

#### PRINT 6x9
task :print, [:book] do |task, args|
desc "Create Smashwords epub versions of our book(s)."

Rake::Task[:jekyll].invoke
Rake::Task[:rename].invoke

system "pandoc --pdf-engine=xelatex -o Books/bio.tex Source/_includes/bio.md"

  if "#{args.book}" == "all"
    filelist = Rake::FileList["_site/*/*-pdf*"]
    fullfiles = filelist.pathmap("%n")
    files = fullfiles.gsub!(/\b-pdf\b/, "")
    files.each do |file|
      FileUtils.mkdir_p "Books/#{file}"
      system "pandoc --top-level-divison=chapter --template=Pandoc/templates/cs-6x9-pdf.latex --pdf-engine=xelatex --pdf-engine-opt=-output-driver='xdvipdfmx -V 3 -z 0' -f markdown+backtick_code_blocks -o Books/#{file}/#{file}-6x9-print.pdf -A Books/bio.tex _site/*/#{file}-pdf.md"
    end            
  else 
      FileUtils.mkdir_p "Books/#{args.book}"
      system "pandoc --top-level-divison=chapter --template=Pandoc/templates/cs-6x9-pdf.latex --pdf-engine=xelatex --pdf-engine-opt=-output-driver='xdvipdfmx -V 3 -z 0' -f markdown+backtick_code_blocks -o Books/#{args.book}/#{args.book}-6x9-print.pdf -A Books/bio.tex _site/*/#{args.book}-pdf.md"
  end
end

#### PDF
task :pdf, [:book] do |task, args|
desc "Create Smashwords epub versions of our book(s)."

Rake::Task[:jekyll].invoke
Rake::Task[:rename].invoke

system "pandoc --pdf-engine=xelatex -o Books/bio.tex Source/_includes/bio.md"

  if "#{args.book}" == "all"
    filelist = Rake::FileList["_site/*/*-pdf*"]
    fullfiles = filelist.pathmap("%n")
    files = fullfiles.gsub!(/\b-pdf\b/, "")
    files.each do |file|
      FileUtils.mkdir_p "Books/#{file}"
      system "pandoc --top-level-divison=chapter --template=Pandoc/templates/pdf.latex --pdf-engine=xelatex -f markdown+backtick_code_blocks -o Books/#{file}/#{file}-ebook.pdf -A Books/bio.tex _site/*/#{file}-pdf.md"
    end            
  else 
      FileUtils.mkdir_p "Books/#{args.book}"
      system "pandoc --top-level-divison=chapter --template=Pandoc/templates/pdf.latex --pdf-engine=xelatex -f markdown+backtick_code_blocks -o Books/#{args.book}/#{args.book}-ebook.pdf -A Books/bio.tex _site/*/#{args.book}-pdf.md"
  end
end

#### ALL
task :all, [:book] do |task, args|
desc "Create all versions of our book(s)."

  if "#{args.book}" == "all"
    Rake::Task[:jekyll].invoke
    Rake::Task[:rename].invoke
    Rake::Task[:epub].invoke("all")
    Rake::Task[:smashwords].invoke("all")
    Rake::Task[:amazon].invoke("all")
    Rake::Task[:print].invoke("all")
    Rake::Task[:pdf].invoke("all")
  else
    Rake::Task[:jekyll].invoke
    Rake::Task[:rename].invoke
    Rake::Task[:epub].invoke("#{args.book}")
    Rake::Task[:smashwords].invoke("#{args.book}")
    Rake::Task[:amazon].invoke("#{args.book}")
    Rake::Task[:print].invoke("#{args.book}")
    Rake::Task[:pdf].invoke("#{args.book}")
  end

end

#### USAGE
task :default => [:usage]

task :usage do
desc "WTF? How does this mess work?"
  puts ""
  puts "####################"
  puts "# START a new book #"
  puts "####################"
  puts "bundle exec rake build"
  puts ""
  puts "#################################"
  puts "# DELETE all evidence of a book #"
  puts "#################################"
  puts "bundle exec rake destroy"
  puts ""
  puts "#############################################"
  puts "# Create an epub version of a specific book #"
  puts "#  (replace $TITLE with the actual title)   #"
  puts "#############################################"
  puts "bundle exec rake epub[$TITLE]"
  puts ""
  puts "#######################################"
  puts "# Create an epub version of ALL books #"
  puts "#######################################"
  puts "bundle exec rake epub[all]"
  puts ""
  puts "##################################################"
  puts "# Create a Smashwords version of a specific book #"
  puts "#     (replace $TITLE with the actual title)     #"
  puts "##################################################"
  puts "bundle exec rake smashwords[$TITLE]"
  puts ""
  puts "############################################"
  puts "# Create a Smashwords version of ALL books #"
  puts "############################################"
  puts "bundle exec rake smashwords[all]"
  puts ""
  puts "###############################################"
  puts "# Create an Amazon version of a specific book #"
  puts "#    (replace $TITLE with the actual title)   #"
  puts "###############################################"
  puts "bundle exec rake amazon[$TITLE]"
  puts ""
  puts "#########################################"
  puts "# Create an Amazon version of ALL books #"
  puts "#########################################"
  puts "bundle exec rake amazon[all]"
  puts ""
  puts "#######################################################"
  puts "# Create a Print-Ready PDF version of a specific book #"
  puts "#        (replace $TITLE with the actual title)       #"
  puts "#######################################################"
  puts "bundle exec rake print[$TITLE]"
  puts ""
  puts "#################################################"
  puts "# Create a Print-Ready PDF version of ALL books #"
  puts "#################################################"
  puts "bundle exec rake print[all]"
  puts ""
  puts "####################################################"
  puts "# Create a standard PDF version of a specific book #"
  puts "#      (replace $TITLE with the actual title)      #"
  puts "####################################################"
  puts "bundle exec rake pdf[$TITLE]"
  puts ""
  puts "##############################################"
  puts "# Create a standard PDF version of ALL books #"
  puts "##############################################"
  puts "bundle exec rake pdf[all]"
  puts ""
  puts "##########################################"
  puts "# Create ALL versions of a specific book #"
  puts "# (replace $TITLE with the actual title) #"
  puts "##########################################"
  puts "bundle exec rake all[$TITLE]"
  puts ""
  puts "####################################"
  puts "# Create ALL versions of ALL books #"
  puts "####################################"
  puts "bundle exec rake all[all]"
  puts ""
end
