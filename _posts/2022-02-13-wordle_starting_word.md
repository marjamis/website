---
title: Wordle - How about trying this starting word?
date: 2022-02-13 21:01:50 +1100
categories:
  - random
---

Wordle has taken the world by storm but are you wondering what your first starting word should be without coming up with the "optimal" word. How about:

{% gist d1434147ff1c821218fb53f1f7206174 wordle-starting-word.txt %}

This is a random word from a dictionary which is:

* 5 letters long
* has a scrabble score of 5 (meaning only using common letters)
* doesn't have any words with duplicates letters (to maximise your unique letter usage)

This is refreshed daily at **12:30 UTC**.

More details about how this works is available in this [GitHub Action on my kata-go repository](https://github.com/marjamis/kata-go/blob/main/.github/workflows/wordle-push-to-gist.yml).
