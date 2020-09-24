if(!file.exists("~/data")){dir.create("~/data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip"
download.file(fileUrl,destfile="~/data/capstone.zip")
if(!file.exists("~/data/capstone.zip")){
  unzip("~/data/capstone.zip", exdir="~/data")
}

##read US English the text files 
blogs <- readLines("~/data/final/en_US/en_US.blogs.txt", encoding="UTF-8", warn=FALSE, skipNul=TRUE)
news <- readLines("~/data/final/en_US/en_US.news.txt", encoding="UTF-8", warn=FALSE, skipNul=TRUE)
twitter <- readLines("~/data/final/en_US/en_US.twitter.txt", encoding="UTF-8", warn=FALSE, skipNul=TRUE)

##blogs
blog_line<- length(blogs); blogs_size<- object.size(blogs); 
Blog_words<- sum(sapply(strsplit(blogs,"\\s+"),length))
Bl_words_per_line<- round(Blog_words/blog_line,2)

##news
news_line<- length(news); news_size<- object.size(news); 
News_words<- sum(sapply(strsplit(news,"\\s+"),length))
NWS_words_per_line<- round(News_words/news_line,2)

##twitter
twitter_line<- length(twitter); twitter_size<- object.size(twitter); 
twitter_words<- sum(sapply(strsplit(twitter,"\\s+"),length))
twt_words_per_line<- round(twitter_words/twitter_line,2)

Lines<- rbind(blog_line, news_line, twitter_line)
Size<- rbind(blogs_size,news_size, twitter_size)
Words<- rbind(Blog_words, News_words, twitter_words)
Word_per_line<- rbind(Bl_words_per_line, NWS_words_per_line, twt_words_per_line)

table1<- cbind(Lines, Size, Words, Word_per_line)
row.names(table1)<- c("Blogs", "News", "Twitter")
colnames(table1)<- c('number of lines', 'Size', 'total number of words', 'Words per line')
table1
