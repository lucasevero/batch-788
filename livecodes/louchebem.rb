SUFFIXES = ["em", "é", "ji", "oc", "ic", "uche", "ès"]
def louchebemize(sentence)
  splitted_sentence = sentence.split(/\b/)

  splitted_sentence.map! do |word|
    if word.match(/\W/) || word.size == 1
      word
    elsif (vowel_index = word.index(/[aeiou]/i))
      cons_group = word[0...vowel_index]
      "l#{word[vowel_index..]}#{cons_group}#{SUFFIXES.sample}"
    end
  end
  splitted_sentence.join
end

p louchebemize("Hello, friends!")
p louchebemize("It is a sunny day in Melbourne!")
