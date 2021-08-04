class User < Sequel::Model
  one_to_many :contents, order: :title
  one_to_many :content_groups, order: :title
end
