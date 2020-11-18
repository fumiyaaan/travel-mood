# アプリケーション名
Travel Mood

# アプリケーション概要
Travel Moodは、スポット投稿型SNSです。  
ユーザーを登録するとスポットを投稿できるようになります。自身が投稿したスポットは、編集と削除をすることができます。他のユーザーが投稿したスポットにコメントすることができます。また、投稿されたスポットは、コメントと同時にUnknowns（穴場度）を５段階で評価され、各スポットごとにUnknownsの平均値が自動的に算出されます。

# 本番環境
https://travel-mood.herokuapp.com/

## テスト用アカウント
- 投稿者用  
  - メールアドレス：poster@com  
  - パスワード：poster_user1  

- コメント投稿・Unknowns評価用  
  - メールアドレス：comment_user@com  
  - パスワード：comment_user1

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

# DEMO
## トップページ
[![Image from Gyazo](https://i.gyazo.com/263d9568798b5664b5858169e7762559.gif)](https://gyazo.com/263d9568798b5664b5858169e7762559)  

背景を動画にしました。  
トップページから、新規登録ページ、ログインページへ遷移することができます。また、START!をクリックすると、アプリ説明ページへ遷移します。

## アプリ説明ページ
[![Image from Gyazo](https://i.gyazo.com/4f7196a5b2a6ff7a321125c2900f7a2b.jpg)](https://gyazo.com/4f7196a5b2a6ff7a321125c2900f7a2b)

## 新規登録ページ
[![Image from Gyazo](https://i.gyazo.com/7dc9992ebee506c34c361911a033e870.jpg)](https://gyazo.com/7dc9992ebee506c34c361911a033e870)

## ログインページ
[![Image from Gyazo](https://i.gyazo.com/2e75f711e088520be1e0e7def0e32c0b.jpg)](https://gyazo.com/2e75f711e088520be1e0e7def0e32c0b)

## スポット投稿一覧ページ
[![Image from Gyazo](https://i.gyazo.com/c6ada2ac8092b33dab1a4fefdbbc89a3.jpg)](https://gyazo.com/c6ada2ac8092b33dab1a4fefdbbc89a3)

今まで投稿された全てのスポットが表示されます。

## 新規スポット投稿ページ
[![Image from Gyazo](https://i.gyazo.com/8bd4fa5ebc3725706895a34b270bf40f.jpg)](https://gyazo.com/8bd4fa5ebc3725706895a34b270bf40f)

## スポット詳細ページ
[![Image from Gyazo](https://i.gyazo.com/2884f9b478c9d81d39a341634afd708a.gif)](https://gyazo.com/2884f9b478c9d81d39a341634afd708a)  

スポット詳細ページより、スポットの編集・削除ができます。


## コメント投稿・Unknowns評価
[![Image from Gyazo](https://i.gyazo.com/a6d697d79228ae9536f6e7cbad783dc5.gif)](https://gyazo.com/a6d697d79228ae9536f6e7cbad783dc5)  

スポット詳細ページ上で、コメント投稿・Unknowns評価をすることができます。  
今まで評価されたUnknownsの平均値が算出され、表示されます。

## ユーザー詳細ページ
[![Image from Gyazo](https://i.gyazo.com/54a6555f3169ba8d6cc93c542e8fcbc7.jpg)](https://gyazo.com/54a6555f3169ba8d6cc93c542e8fcbc7)

各ユーザーのプロフィールと今まで投稿したスポットを見ることができます。

# 工夫したポイント
- 入り口となるトップページの背景を動画にすることで、ユーザーがワクワクするような見た目を意識しました。  
- InstagramやTwitterなどの横綱級SNSと差別化させるために、Unknowns評価機能を実装しました。

# 使用技術
Ruby / Ruby on Rails / MySQL / GitHub / Heroku / AWS / Visual Studio Code / Trello

# 課題
- 現状、トップページの動画が再生されるまで約30秒ほどかかってしまうため、ファイル圧縮などの改善を考えております。

# 今後実装したい機能
- スポット検索機能  
  - キーワード、Unknownsの高さなどの条件を指定して検索できる機能  
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