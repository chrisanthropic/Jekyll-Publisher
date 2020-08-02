#!/bin/bash
skel(){
cp -R Skel Source/
}

create(){
echo "What is the title of your book?"
read TITLE

mkdir -p "Source/$TITLE/"

cat > "Source/$TITLE/$TITLE-Amazon.md" << EOF
---
layout: $TITLE/amazon
---
EOF

cat > "Source/$TITLE/$TITLE-epub.md" << EOF
---
layout: $TITLE/epub
---
EOF

cat > "Source/$TITLE/$TITLE-pdf.md" << EOF
---
layout: $TITLE/pdf
---
EOF

cat > "Source/$TITLE/$TITLE-Smashwords.md" << EOF
---
layout: $TITLE/epub
---
EOF

mkdir -p "Source/_layouts/$TITLE"

cat > "Source/_layouts/$TITLE/amazon.md" << EOF
{% include $TITLE/amazon.md %}
{% include magnet_tah.md %}
{% include bio.md %}
{% include bibliography.md %}
{% include license.md %}
EOF

cat > "Source/_layouts/$TITLE/epub.md" << EOF
{% include $TITLE/chapters.md %}
{% include magnet_tah.md %}
{% include bio.md %}
{% include bibliography.md %}
{% include license.md %}
EOF

cat > "Source/_layouts/$TITLE/pdf.md" << EOF
{% include $TITLE/chapters.md %}
EOF

mkdir -p "Source/_includes/$TITLE"

cat > "Source/_includes/$TITLE/chapters.md" << EOF
---
title: $TITLE
subtitle:
author:
website:

type: [GENRE]
lang: en-US
date: YYYY-MM-DD
year: YYYY

cover-image: Source/images/XXXXX.jpg

publisher: 
rights: This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 4.0 Unported License.

paperback-isbn:
hardcover-isbn:
epub-isbn:

dedication: Dedicated to my readers.

toc: false

top-margin:
bottom-margin:
inner-margin:
outer-margin:

identifier:
    - scheme: UUID
      text: [Grab a free Version4 UUID from here: https://www.uuidgenerator.net/version4]
      
contributors:
    - designer: 
      artist: 
      editor: 

book1: 
    - title: Any book you've written
      link: http://www.amazon.com/dp/XXXXXXXX
book2:
    - title: These books get added to the title page
      link: and for Amazon, they use the links you provide here
book3:
    - title: You can add up to 5 books
      link: 
    
review:
    - amazon: https://www.amazon.com/review/create-review?asin=XXXXXXX
    
---
# Chapter Title
Paste your manuscript here.
EOF

cat > "Source/_includes/$TITLE/amazon.md" << EOF
{% include $TITLE/chapters.md %}
{% include amazon_review.md %}
EOF

cat > "Source/_includes/$TITLE/amazon_review.md" << EOF
\\
\\



##### If you enjoyed this book please consider leaving a [review](https://www.amazon.com/review/create-review?asin=XXXXXXXXXX) on Amazon.
EOF

echo ""
echo "Paste your manuscript into Source/_includes/$TITLE/chapters.md and then run bind.sh all"
echo ""
}

destroy(){
echo "What is the title of your book?"
read TITLE

rm -rf "Source/$TITLE"
rm -rf "Source/_layouts/$TITLE"
rm -rf "Source/_includes/$TITLE"
}

usage(){
echo "run new.sh create or new.sh destroy"
}

if [[ -z "$1" ]]; then usage; fi

$1
