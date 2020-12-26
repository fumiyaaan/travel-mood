require 'rails_helper'

RSpec.describe "スポット投稿", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @spot = FactoryBot.build(:spot)
  end

  context 'スポット新規投稿ができるとき' do
    it 'ログインしたユーザーは新規投稿ができる' do
      # ログインページへ移動する
      visit new_user_session_path

      # ログインする
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード', with: @user.password
      find('input[name="commit"]').click

      # スポット一覧ページへ移動する
      visit spots_path

      # スポット新規投稿ページへ移動する
      visit new_spot_path

      # フォームに情報を入力する
      fill_in 'タイトル', with: @spot.title
      fill_in 'スポット説明', with: @spot.description

      # 投稿ボタンを押すとSpotモデルのカウントが1上がることを確認する
      expect{find('input[name="commit"]').click}.to change { Spot.count }.by(1)

      # スポット一覧ページへ遷移する
      expect(current_path).to eq spots_path

      # スポット一覧ページには先ほど投稿した内容のスポットが存在する
      expect(page).to have_content(@spot.title)
    end
  end

  context 'スポット新規投稿ができないとき' do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページに移動する
      visit root_path

      # スポット新規投稿ページへのリンクがない
      expect(page).to have_no_content('投稿する')
    end
  end
end

RSpec.describe 'スポット編集', type: :system do
  before do
    @spot = FactoryBot.create(:spot) 
  end
  
  context 'スポット編集ができるとき' do
    it 'ログインしたユーザーは自分が投稿したスポットのみ編集できる' do
      # @spotを投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @spot.user.email
      fill_in 'パスワード', with: @spot.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path

      # スポット一覧ページへ移動する
      visit spots_path

      # @spotの詳細ページへ移動する
      visit spot_path(@spot)

      # @spotに編集ボタンがあることを確認する
      expect(
        find(".more").hover
      ).to have_link '編集', href: edit_spot_path(@spot)

      # 編集ページへ移動する
      visit edit_spot_path(@spot)

      # すでに投稿済みの内容がフォームに入っていることを確認する
      expect(
        find('#spot_タイトル').value
      ).to eq @spot.title
      expect(
        find('#spot_スポット説明').value
      ).to eq @spot.description

      # 投稿内容を編集する
      fill_in 'タイトル', with: "#{@spot.title}+（編集しました）"
      fill_in 'スポット説明', with: "#{@spot.description}+（編集しました）"

      # 編集してもSpotモデルのカウントは変わらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Spot.count }.by(0)

      # @spotの詳細ページに遷移することを確認する
      expect(current_path).to eq spot_path(@spot)

      # スポット一覧ページへ移動する
      visit spots_path

      # スポット一覧ページには先ほど編集した内容のスポットが存在することを確認する（タイトル）
      expect(page).to have_content(@spot.title)
    end
  end

  context 'スポット編集ができるとき' do
    it 'ログインしたユーザーは自分以外が投稿したスポットの編集画面には移動できない' do
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

      # @spotに編集ボタンがないことを確認する
      expect(page).to have_no_link '編集', href: edit_spot_path(@spot)
    end
  end
end

RSpec.describe 'スポット削除', type: :system do
  before do
    @spot = FactoryBot.create(:spot) 
  end

  context 'スポット削除ができるとき' do
    it 'ログインしたユーザーは自らが投稿したスポットの削除ができる' do
      # @spotを投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @spot.user.email
      fill_in 'パスワード', with: @spot.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path

      # スポット一覧ページへ移動する
      visit spots_path

      # @spotの詳細ページへ移動する
      visit spot_path(@spot)

      # @spotに削除ボタンがあることを確認する
      expect(
        find(".more").hover
      ).to have_link '削除', href: spot_path(@spot)

      # 投稿ボタンを押すとSpotモデルのカウントが1下がることを確認する
      expect{
        find(".more").hover.find_link('削除', href: spot_path(@spot)).click
      }.to change { Spot.count }.by(-1)

      # スポット一覧ページに@spotが存在しないことを確認する（タイトル）
      expect(page).to have_no_content("#{@spot.title}")
    end
  end

  context 'スポット削除ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿したスポットの削除ができない' do
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

      # @spotに削除ボタンがないことを確認する
      expect(page).to have_no_link '削除', href: spot_path(@spot)
    end
  end
end

RSpec.describe 'スポット詳細', type: :system do
  before do
    @spot = FactoryBot.create(:spot)
  end

  it 'ログインしたユーザーは自分以外のユーザーが投稿したスポットの詳細ページでコメント投稿欄を見ることができる' do
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

     # コメント投稿用のフォームが存在することを確認する
     expect(page).to have_selector 'form'
  end

  it 'ログインしたユーザーは自分が投稿したスポットの詳細ページでコメント投稿欄を見ることができない' do
    # @spotを投稿したユーザーでログインする
    binding.pry
    visit new_user_session_path
    fill_in 'メールアドレス', with: @spot.user.email
    fill_in 'パスワード', with: @spot.user.password
    find('input[name="commit"]').click

    # スポット一覧ページへ移動する
    visit spots_path
    
    # @spotの詳細ページへ移動する
    visit spot_path(@spot)

    # コメント投稿用のフォームが存在しないことを確認する
    expect(page).to have_no_selector 'form'
  end
end