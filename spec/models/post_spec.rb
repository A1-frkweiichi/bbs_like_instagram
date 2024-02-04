require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'バリデーションのテスト' do
    it '本文と画像があれば有効である' do
      user = create(:user)
      post = build(:post, user: user)
      expect(post).to be_valid
    end

    it '本文がなければ無効である' do
      post = build(:post, body: nil)
      post.valid?
      expect(post.errors[:body]).to include("can't be blank")
    end

    it '画像がなければ無効である' do
      post = build(:post, image: nil)
      post.valid?
      expect(post.errors[:image]).to include("can't be blank")
    end

    it 'ユーザーIDがなければ無効である' do
      post = build(:post, user_id: nil)
      post.valid?
      expect(post.errors[:user_id]).to include("can't be blank")
    end
  end

end
