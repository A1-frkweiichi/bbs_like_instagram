FactoryBot.define do
  factory :post do
    body { "テスト投稿の本文" }
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/sample.png'), 'image/png') }
    user
  end
end
