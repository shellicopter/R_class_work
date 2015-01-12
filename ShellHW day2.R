# Complete all of the items below
# Use comments where you're having trouble or questions

# 1. Read your data set into R
getwd()
setwd("~/Dropbox/Winter 2015/R class")
d<- read.csv("AlisonS data.csv")

# 2. Peek at the top few rows
head(d)

# 3. Peek at the top few rows for only a few columns
head(d[1:4])
#or d[,1:4]: this says all the rows and cols 1:4** this one is better
#

# 4. How many rows does your data have?
#length(d) oops!
#nrow(d)
# 5. Get a summary for every column
summary(d)

# 6. Get a summary for one column

summary(d$RT)
# or: summary(d, [, "RT"])
# to get mulitple columns (d, [, c("RT", "AUC", ...)]
# 7. Are any of the columns giving you unexpected values?
#    - missing values? (NA)
#all looks ok! - is there an easy way to check for this? is.na?

# 8. Select a few key columns, make a vector of the column names
colnames(d)
mycols<- colnames(d)[c(1,2,5,10,11,12)]
mycols
# 9. Create a new data.frame with just that subset of columns
#    from #7
#    - do this in at least TWO different ways
d1 <-d[mycols] # 1: cleaner way
d2 <- d[c(1,2,5,10,11,12)] #2: same thing but as if I hadn't established mycols vector

# 10. Create a new data.frame that is just the first 10 rows
#     and the last 10 rows of the data from #8
myrows <-c(1:10,216:226)
d20 <-d1[ myrows,] #I wasnted to do this in one step using "rownames() but couldn't figure it out..
d20
# top <-head(d, 10) **do this
#bottom <- tail (d,10)
#topandbottom <-rbind(top, bottom)
#tandb <-d[c9
# 11. Create a new data.frame that is a random sample of half of the rows.
#d[sample(nrow(d), nrows(d)/2): sample just picks random #'s so you need to give 
d20rand <-sample_frac(d20, size = .5) #random sample of d20
d1rand <-sample_frac(d1, size = .5) #random sample of d1 (all rows)

# 12. Find a comparison in your data that is interesting to make
#     (comparing two sets of numbers)
#compare RT's for: ff_con_h2_t3 vs. ff_inc_h2_t3
dcon <- d$RT[d$code =="ff_con_h2_t3"]
dinc <- d$RT[d$code =="ff_inc_h2_t3"]
#     - run a t.test for that comparison
t_ff<-t.test(dcon, dinc) #nothing sig here
#     - decide whether you need a non-default test
# can't do a paired test because there are different n's for each group here
t.test(dcon, dinc, var.equal = TRUE) # just for fun-true student's t-test- not sure if this is appropriate though
#       (e.g., Student's, paired)
#     - run the t.test with BOTH the formula and "vector"
#       formats, if possible
#     - if one is NOT possible, say why you can't do it
#can't run this with the formula format because there are more than 2 levels in this column
# 13. Repeat #10 for TWO more comparisons

#Now look at same thing but for cognates:
dcogCon <-d$RT[d$code =="cog_con_h2_t3"]
dcogInc <-d$RT[d$code =="cog_inc_h2_t3"]
t_cog<-t.test(dcogCon, dcogInc) #sig findings-- con larger RT than inc

#Now I'll try to look at the 2nd half (all h2) ff_con vs. ff_inc trials and compare RT
dffcon <- d$RT[d$code =="ff_con_h2_t3"|d$code =="ff_con_h2_t2"]
dffinc <- d$RT[d$code =="ff_inc_h2_t3"|d$code =="ff_inc_h2_t2"]
half2ff_test<- t.test(dffcon,dffinc)
#same thing but look at init.time:
dffconit <- d$init.time[d$code =="ff_con_h2_t3"|d$code =="ff_con_h2_t2"]
dffincit <- d$init.time[d$code =="ff_inc_h2_t3"|d$code =="ff_inc_h2_t2"]
half2ff_it_test<-t.test(dffconit,dffincit) #looks like there might be close to something here...

#     - ALTERNATIVELY, if correlations are more interesting,
#       do those instead of t-tests (and try both Spearman and
#       Pearson correlations)

# just trying a correlation here: correlating initiation time with RT- not surprising they're correlated!
cortestp<- cor.test(d1$RT, d1$init.time, method = "pearson")
#cor.test(d1$RT, d1$init.time, method = "spearman") # this one wont work as is because there are tied values
# 14. Save all results from #12 and #13 in an .RData file
save("t_ff","t_cog", "half2ff_test", "half2ff_it_test", file= "Shell_HWDay2.RData")

# 15. Email me your version of this script, PLUS the .RData
#     file from #14
