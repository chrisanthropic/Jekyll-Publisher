## What is Open-Publisher
Open publisher is really just a couple of bash scripts that wrap around Jekyll, Pandoc, KindleGen, and LaTeX, along with some custom Pandoc templates created with a focus on fiction.

Write your manuscript in markdown, run a script, and receive some beautifully formatted ePub, Mobi, and print-ready PDF books.

Full documentation on the [wiki](https://github.com/chrisanthropic/Open-Publisher/wiki)

## Why is Open-Publisher
My wife is [an author](https://www.backthatelfup.com) and I handle all of the digital/print book creation. After 4+ years of using various tools I decided to streamline my process.

It can be a pain to manually update a Bio page with new information or new books for example. Doing a simple thing like that for 3 formats of a dozen books can take time and introduces the possibility of new typos with every change.

Pandoc is a great tool to convert markdown files to html/epub/pdf/etc., but its epub templating is still very minimalistic. It requires multiple stages to create a template that allows me to reuse common pages such as biography, licensing, etc.

I love Jekyll and use it whenever I can for web design. One of my favorite aspects is the ability to define 'code chunks' in the _includes folder and then use references to it wherever I want. Change that include file, rebuild, and every reference to it on your website is updated. It's that kind of logic that I need for creating my books.

By using Jekyll's templating I'm able to create files that slightly differ based on need. The mandatory Smashwords title page for example, or a custom Title page with Amazon URLs to other books.

Jekyll allows me to create custom templates, multiple 'includes', and then output them into a perfectly formatted Markdown file.

This markdown file can then be passed along to Pandoc and converted to epub/mobi/pdf.
