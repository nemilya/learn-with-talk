class Word < Sequel::Model
  many_to_one :content

  def word_and_pronunciation
    word_and_prunonciation = self.word.split(' /')
    if word_and_pronunciation && word_and_pronunciation.size == 2
      return word_and_pronunciation[0], '/'+word_and_pronunciation[1]
    end
    return self.word, nil
  end

end
