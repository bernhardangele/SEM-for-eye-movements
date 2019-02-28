rm(list = ls())

library(tidyverse)

load(file = "data4000_ffd.RData")

mean_narm <- function(x) mean(x, na.rm = TRUE)

data_for_SEM <- data.DT %>%
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

  
    
