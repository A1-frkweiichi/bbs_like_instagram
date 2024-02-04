require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Googleログインのテスト' do
    context 'ユーザーが既に存在する場合' do
      it '既存のユーザーを更新して返す' do
        existing_user = FactoryBot.create(:user, email: 'test@example.com', provider: 'google_oauth2', uid: '1234567890')

        auth_mock = OmniAuth::AuthHash.new({
          provider: 'google_oauth2',
          uid: '1234567890',
          info: {
            email: 'test@example.com',
            name: 'テストユーザー'
          }
        })

        user = User.from_omniauth(auth_mock)

        expect(user).to eq(existing_user)
        expect(user.name).to eq('テストユーザー')
      end
    end

    context 'ユーザーが存在しない場合' do
      it '新しいユーザーを作成して返す' do
        auth_mock = OmniAuth::AuthHash.new({
          provider: 'google_oauth2',
          uid: '新しいuid',
          info: {
            email: 'new@example.com',
            name: '新しいユーザー'
          }
        })

        expect {
          user = User.from_omniauth(auth_mock)
          expect(user.email).to eq('new@example.com')
          expect(user.name).to eq('新しいユーザー')
        }.to change(User, :count).by(1)
      end
    end
  end

  describe 'Deviseログインのテスト' do
    it 'メールアドレスとパスワードでログインできる' do
      user = FactoryBot.create(:user, email: 'login@example.com', password: 'password123', password_confirmation: 'password123')
      login_user = User.find_for_authentication(email: 'login@example.com')
      expect(login_user.valid_password?('password123')).to be true
    end
  end
end
