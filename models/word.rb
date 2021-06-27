class Word < Sequel::Model
  many_to_one :content

  def word_and_pronunciation
    _word_and_pronunciation = self.word.split(' /')
    if _word_and_pronunciation && _word_and_pronunciation.size == 2
      return _word_and_pronunciation[0], '/'+_word_and_pronunciation[1]
    end
    return self.word, nil
  end

end
