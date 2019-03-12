rm(list = ls())

library(reshape)
library(tidyverse)

load(file = "data4000_ffd.RData")

mean_narm <- function(x) mean(x, na.rm = TRUE)

data.DT$word_token_exp <- with(data.DT, paste(word_token, experiment, sep = "_"))

data_for_SEM <- data.DT %>%
  filter(experiment == "full") %>%
  group_by(word_token,   # unique identifier for a word within a sentence
           currentword,  # word number within sentence
           word,         # letter string of the word (commas etc. removed). Currently, this gives the high-frequency word only
           dv,           # dependent variable. Can be FFD = first fixation duration, GD = gaze duration, SFD = single fixation duration
           n1,           # was the first word to the right of fixation masked or available?
           n2,           # was the second word to the right of fixation masked or available?
           target_freq,  # was the target word low or high frequency?
           npos,         # where was the target word in the sentence?
           bnc_freq,     # log frequency of the current word from the British National Corpus
           bnc_freq1,    # log frequency of the previous word from the British National Corpus
           bnc_freq2 ,    # log frequency of the upcoming word from the British National Corpus
           trigram_prob,     # conditional trigram probability (P(word)|word-1, word-2) of the current word from the Penn corpus
           trigram_prob1,    # conditional trigram probability (P(word)|word-1, word-2) of the previous word from the Penn corpus 
           trigram_prob2,     # conditional trigram probability (P(word)|word-1, word-2) of the upcoming word from the Penn corpus
           p,     # cloze (fill in the blank) probability of the current word 
           p1,    # cloze (fill in the blank) probability of the previous word 
           p2,     # cloze (fill in the blank) probability of the upcoming word
           cpos,     # (simplified) part of speech of the current word 
           cpos1,    # (simplified) part of speech of the previous word 
           cpos2     # (simplified) part of speech of the upcoming word
           ) %>% 
  summarize(fixation_time = mean_narm(value))

# In the end, cast from the reshape package worked best here
data_for_sem.c <- cast(data_for_SEM, value = "fixation_time", word_token + currentword + dv + bnc_freq + bnc_freq1 + bnc_freq2 + trigram_prob + trigram_prob1 + trigram_prob2 + p + p1 + p2 + cpos + cpos1 + cpos2 ~ n1 + n2 + target_freq, mean)

data_for_SEM_FFD <- subset(data_for_SEM.c, dv == "FFD")

data_for_SEM_SFD <- subset(data_for_SEM.c, dv == "SFD")

data_for_SEM_GD <- subset(data_for_SEM.c, dv == "GD")


save(data_for_SEM_FFD, data_for_SEM_GD, data_for_SEM_SFD, file = "data for SEM.RData")
