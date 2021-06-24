class Word < Sequel::Model
  many_to_one :content
end
