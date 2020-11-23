# アプリケーション名
Travel Mood  

[![Image from Gyazo](https://i.gyazo.com/76bba3ecce2af409dce3b8be27031f42.jpg)](https://gyazo.com/76bba3ecce2af409dce3b8be27031f42)

# アプリケーション概要
Travel Moodは、スポット投稿型SNSです。  
ユーザーを登録するとスポットを投稿できるようになります。自身が投稿したスポットは、編集と削除をすることができます。他のユーザーが投稿したスポットにコメントすることができます。また、投稿されたスポットは、コメントと同時にUnknowns（穴場度）を５段階で評価され、各スポットごとにUnknownsの平均値が自動的に算出されます。

# 本番環境
http://54.238.38.60/

https://travel-mood.herokuapp.com/

## ID/Pass
- ID：satou
- Pass：90615

## テスト用アカウント 
  - メールアドレス：sample@com
  - パスワード：sample10

# DEMO
１. テスト用アカウントでログイン  
[![Image from Gyazo](https://i.gyazo.com/f098995462122e9507ec832bfdb8827f.jpg)](https://gyazo.com/f098995462122e9507ec832bfdb8827f)  

２. ログイン後、「START!」をクリック  
[![Image from Gyazo](https://i.gyazo.com/912cc04501438983994d6d3012c323b4.jpg)](https://gyazo.com/912cc04501438983994d6d3012c323b4)

３. 右下の「投稿する」をクリック  
[![Image from Gyazo](https://i.gyazo.com/be85a933fad2f87587d8e26c3c03da3c.jpg)](https://gyazo.com/be85a933fad2f87587d8e26c3c03da3c)  

４. 画像・タイトル・スポット説明を入力して、「投稿」ボタンをクリック  
[![Image from Gyazo](https://i.gyazo.com/bab3884d5c587bf31524b16e08188695.jpg)](https://gyazo.com/bab3884d5c587bf31524b16e08188695)  

５. 投稿したスポットは一覧ページに表示されます   
[![Image from Gyazo](https://i.gyazo.com/7234d010afedae042d8c20c5f424ce0b.jpg)](https://gyazo.com/7234d010afedae042d8c20c5f424ce0b)  

６. 一覧ページ上で投稿したスポット画像をクリックすると、以下のスポット詳細ページに遷移します  
[![Image from Gyazo](https://i.gyazo.com/bfac5c878bdf6ad449f699aebb96df5c.jpg)](https://gyazo.com/bfac5c878bdf6ad449f699aebb96df5c)  

７. 他のユーザーが投稿したスポットにコメント・Unknowns評価  
[![Image from Gyazo](https://i.gyazo.com/be17ad211cb4531cddfe85bbeb6c66fc.jpg)](https://gyazo.com/be17ad211cb4531cddfe85bbeb6c66fc)  

８. 投稿したコメントが表示され、平均Unknownsが算出されます  
[![Image from Gyazo](https://i.gyazo.com/670f5938441ed226cea5fa12441fb357.jpg)](https://gyazo.com/670f5938441ed226cea5fa12441fb357)


# 制作背景（意図）  
- 行き当たりばったりの旅を楽しみたい  
- 王道スポットより穴場スポットが好き  
- リピート地をもっと深掘りしたい  

と思っている人たちはきっと、  

- パンフレットやツアーは、王道コースが多い  
- 穴場スポットを気軽に共有できる場所が欲しい  

という思いを抱えていると考えました。

そんな人たちの思いを汲み取って制作しました。  

また、Unknownsをお互いに評価し合うことで、穴場スポットの発見・共有ができると考えました。  
ここで言うUnknownsとは、「穴場度」を指し、1~5の5段階で評価されます。今まで評価されたUnknownsの平均値は各スポットごとに算出されます。ここでいう「バズる」の基準は、Unknownsの高さになります。

# 工夫したポイント
- 入り口となるトップページの背景を動画にすることで、ユーザーがワクワクするような見た目を意識しました。  
下記URLよりトップページの動画をご覧ください。  
[![Image from Gyazo](https://i.gyazo.com/c56f7e55e030bba1fcc9b32a6e6a9e94.gif)](https://gyazo.com/c56f7e55e030bba1fcc9b32a6e6a9e94) 

- InstagramやTwitterなどの横綱級SNSと差別化させるために、Unknowns評価機能を実装しました。

# 使用技術
Ruby / Ruby on Rails / MySQL / GitHub / Heroku / AWS / Visual Studio Code / Trello

# 課題
- 現状、トップページの動画が再生されるまで約10秒ほどかかってしまうため、ファイル圧縮などの改善を考えております。

# 今後実装したい機能
- スポットの地図情報投稿機能（Google Maps APIの導入）  
- ユーザー情報編集機能
  - ニックネームとプロフィールを自由に変更できる機能

# データベース設計
## usersテーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| name               | string | null: false               |
| email              | string | null: false, unique: true |
| password           | string | null: false               |
| profile            | text   |                           |

### Association
-has_many :spots  
-has_many :comments


## spotsテーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| title       | string     | null: false                    |
| description | text       | null: false                    |
| user        | references | null: false, foreign_key: true |

### Association
-belongs_to :user  
-has_many :comments


## commentsテーブル

| Column  | Type       | Options                        |
| ------  | ---------- | ------------------------------ |
| text    | text       | null: false                    |
| unknown | integer    | null: false                    |
| user    | references | null: false, foreign_key: true |
| spot    | references | null: false, foreign_key: true |

### Association
-belongs_to :user  
-belongs_to :spot

## ER図
[![Image from Gyazo](https://i.gyazo.com/a4e1454a92f2de5ba7204f7dc9c90a9c.png)](https://gyazo.com/a4e1454a92f2de5ba7204f7dc9c90a9c)