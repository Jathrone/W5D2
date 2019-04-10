# == Schema Information
#
# Table name: posts
#
#  id         :bigint(8)        not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ApplicationRecord
    validates :title, :subs, :author_id, presence: true

    # attr_reader :

    belongs_to :author,
        primary_key: :id,
        foreign_key: :author_id,
        class_name: "User"

    # belongs_to :sub

    has_many :postsubs,
        primary_key: :id,
        foreign_key: :post_id,
        class_name: "PostSub",
        dependent: :destroy,
        inverse_of: :post

    has_many :subs,
        through: :postsubs,
        source: :sub
    
    has_many :comments,
        foreign_key: :post_id,
        class_name: "Comment"

end
