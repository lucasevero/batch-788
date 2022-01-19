SUFFIXES = ["em", "é", "ji", "oc", "ic", "uche", "ès"]
def louchebemize(sentence)
  # Splitting the sentence into an array of words (and special characters strings)
  splitted_sentence = sentence.split(/\b/)

  # Manipulating the array
  splitted_sentence.map! do |word|
    # No changes if it is special characters string || a one-letter word
    if word.match(/\W/) || word.size == 1
      word
    # Using the index of the first vowel to manipulate the words
    elsif (vowel_index = word.index(/[aeiou]/i))
      # Getting the consonant group in the beggining of the string
        # (notice that if the word starts with a vowel, cons_string will be "")
      cons_group = word[0...vowel_index]
      # Returning the new string:
        # - starting with l
        # - the word without the cons_group
        # - the cons_group
        # - a rondom suffix
      "l#{word[vowel_index..]}#{cons_group}#{SUFFIXES.sample}"
    end
  end

  # Joining into a single string again
  splitted_sentence.join
end

p louchebemize("Hello, friends!")
p louchebemize("It is a sunny day in Melbourne!")
