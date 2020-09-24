
library(tm); library(quanteda); library(dplyr); library(ggplot2); library(ngram);
library(wordcloud); library(tokenizers)

blogs <- readLines("~/data/final/en_US/en_US.blogs.txt", encoding="UTF-8", warn=FALSE, skipNul=TRUE)
news <- readLines("~/data/final/en_US/en_US.news.txt", encoding="UTF-8", warn=FALSE, skipNul=TRUE)
twitter <- readLines("~/data/final/en_US/en_US.twitter.txt", encoding="UTF-8", warn=FALSE, skipNul=TRUE)

set.seed(111)
sampleFactor<- 0.025

SampleB<- sample(blogs, size=length(blogs)*sampleFactor, replace=FALSE)
SampleN <- sample(news, size=length(news)*sampleFactor, replace=FALSE)
SampleT <- sample(twitter, size=length(twitter)*sampleFactor, replace=FALSE)
text_sample <- paste(SampleB,SampleN,SampleT)


sampleCorpus = VCorpus(VectorSource(text_sample))
sampleCorpus = tm_map(sampleCorpus, PlainTextDocument) 
sampleCorpus = tm_map(sampleCorpus, content_transformer(tolower))
sampleCorpus = tm_map(sampleCorpus, removeNumbers)
##sampleCorpus = tm_map(sampleCorpus, removeWords, stopwords("english")) 
sampleCorpus = tm_map(sampleCorpus, removePunctuation)
sampleCorpus = tm_map(sampleCorpus, stripWhitespace)

#N-Grams
sampledataFrame<-data.frame(text=unlist(sapply(sampleCorpus, `[`, "content")), stringsAsFactors=F) 
sample_ch = sampledataFrame[,1] 

unigram<- tokenize_ngrams(sample_ch, n=1, n_min =1)
unigram.df<- data.frame(V1= as.vector(names(table(unlist(unigram)))), V2= as.numeric(table(unlist(unigram))))
names(unigram.df)<-c("word", "frequency")  
unigramSort<- unigram.df[with(unigram.df, order(-unigram.df$frequency)),]

ngram1 <- data.frame(as.character(unigram.df$word))
names(ngram1) <- c("w1")
ngram1$freq <- unigram.df$frequency

bigram<-  tokenize_ngrams(sample_ch, n=2, n_min =2)
bigram.df<- data.frame(V1= as.vector(names(table(unlist(bigram)))), V2= as.numeric(table(unlist(bigram))))
names(bigram.df)<-c("word", "frequency")                                                      
bigramSort<- bigram.df[with(bigram.df, order(-bigram.df$frequency)),]

ngram2 <- data.frame(do.call('rbind', strsplit(as.character(bigramSort$word),' ',fixed=TRUE)))
names(ngram2) <- c("w1","w2")
ngram2$freq <- bigram.df$frequency

trigram<-  tokenize_ngrams(sample_ch, n=3, n_min =3)
trigram.df<- data.frame(V1= as.vector(names(table(unlist(trigram)))), V2= as.numeric(table(unlist(trigram))))
names(trigram.df)<-c("word", "frequency")                                                      
trigramSort<- trigram.df[with(trigram.df, order(-trigram.df$frequency)),]

ngram3 <- data.frame(do.call('rbind', strsplit(as.character(trigramSort$word),' ',fixed=TRUE)))
names(ngram3) <- c("w1","w2","w3")
ngram3$freq <- trigram.df$frequency

quadgram<-  tokenize_ngrams(sample_ch, n=4, n_min =4)
quadgram.df<- data.frame(V1= as.vector(names(table(unlist(quadgram)))), V2= as.numeric(table(unlist(quadgram))))
names(quadgram.df)<-c("word", "frequency")                                                      
quadgramSort<- quadgram.df[with(quadgram.df, order(-quadgram.df$frequency)),]


ngram4 <- data.frame(do.call('rbind', strsplit(as.character(quadgramSort$word),' ',fixed=TRUE)))
names(ngram4) <- c("w1","w2","w3","w4")
ngram4$freq <- quadgram.df$frequency

pentagram<-  tokenize_ngrams(sample_ch, n=5, n_min =5)
pentagram.df<- data.frame(V1= as.vector(names(table(unlist(pentagram)))), V2= as.numeric(table(unlist(pentagram))))
names(pentagram.df)<-c("word", "frequency")                                                      
pentagramSort<- pentagram.df[with(pentagram.df, order(-pentagram.df$frequency)),]
ggplot(pentagramSort[1:20,])+ geom_point(aes(x=reorder(word, -frequency), y=frequency))+ labs(x="penta-grams in order of frequency")

ngram5 <- data.frame(do.call('rbind', strsplit(as.character(pentagramSort$word),' ',fixed=TRUE)))
names(ngram5) <- c("w1","w2","w3","w4","w5")
ngram5$freq <- pentagram.df$frequency

#save ngrams as Rdata files for further use.
saveRDS(ngram5, file= "~/data1/Capstone_predict_word/ngram5.rds")
saveRDS(ngram4, file= "~/data1/Capstone_predict_word/ngram4.rds")
saveRDS(ngram3, file= "~/data1/Capstone_predict_word/ngram3.rds")
saveRDS(ngram2, file= "~/data1/Capstone_predict_word/ngram2.rds")
saveRDS(ngram1, file= "~/data1/Capstone_predict_word/ngram1.rds")

set.seed(666)
wordcld<- wordcloud(samplecorpus, max.words = 100, random.order = FALSE, rot.per=0.5,
                    use.r.layout=FALSE,colors=brewer.pal(10, "Dark2"), 
                    main="Top 100 Words from sample text dataset")


