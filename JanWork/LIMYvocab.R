getwd()
library(plyr)
library(lme4)
library(bear)
library(ez)
d<-read.csv("LIMYvocab.csv")
head(d)
vocab.m<-glmer(error~wordcond*stroop+(1|subject) +(1|sound), data = d, family = "binomial")
summary(vocab.m)
bysubs.d1 <- cast(d, subject + wordcond + stroop ~ ., mean, value = "error", na.rm=TRUE)
head(bysubs.d1)
colnames(bysubs.d1)[4] <- "acc"
bysubs.sum <- summarySEwithin(bysubs.d1, measurevar="acc", withinvars=c("wordcond","stroop"), idvar="subject")
bysubs.sum
plot<- ggplot(bysubs.sum, aes(x=wordcond, y=acc, colour = stroop, shape = stroop, stat="identity")) +
  geom_pointrange(aes(ymax=acc+se, ymin=acc-se), size = 1, position = position_dodge(w=.4))
plot
