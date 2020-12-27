require 'rails_helper'

RSpec.describe "コメント投稿", type: :system do
  before do
    @spot = FactoryBot.create(:spot)
  end

  it 'ユーザーはスポット詳細ページでコメントを投稿できる' do
    # 一旦、ユーザー登録をする
    visit new_user_registration_path
    fill_in 'ニックネーム', with: "次郎"
    fill_in 'メールアドレス', with: "jiro@com"
    fill_in 'パスワード', with: "jiro1022"
    fill_in 'パスワード再確認', with: "jiro1022"
    find('input[name="commit"]').click

    # スポット一覧ページへ移動する
    visit spots_path

    # @spotの詳細ページへ移動する
    visit spot_path(@spot)

    # フォームにコメントを入力する
    fill_in 'comment_text', with: "素晴らしい"

    # Unknownsを評価する
    fill_in 'comment_unknown', with: 5

    # コメント投稿ボタンを押すと、Commentモデルのカウントが1上がることを確認する
    expect{
      find('input[name="commit"]').click
    }.to change { Comment.count }.by(1)

    # スポット詳細ページにリダイレクトされることを確認する
    expect(current_path).to eq spot_path(@spot)
  end
end