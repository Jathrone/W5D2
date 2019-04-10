# == Schema Information
#
# Table name: comments
#
#  id                :bigint(8)        not null, primary key
#  content           :string           not null
#  author_id         :integer          not null
#  post_id           :integer          not null
#  parent_comment_id :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Comment < ApplicationRecord
    validates :content, presence:true

    belongs_to :author,
        foreign_key: :author_id,
        class_name: :User
    belongs_to :post,
        foreign_key: :post_id,
        class_name: :Post

    has_many :child_comments,
        foreign_key: :parent_comment_id,
        class_name: :Comment

    belongs_to :parent_comment,
        foreign_key: :parent_comment_id,
        class_name: :Comment,
        optional: true
end
