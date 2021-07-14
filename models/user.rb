class User < Sequel::Model
  one_to_many :contents, order: :title
end
