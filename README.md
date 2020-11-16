# アプリケーション名
Travel Mood

# アプリケーション概要
Travel Moodは、スポット投稿型SNSです。  
ユーザーを登録するとスポットを投稿できるようになります。自身が投稿したスポットは、編集と削除をすることができます。他のユーザーが投稿したスポットにコメントすることができます。また、投稿されたスポットは、コメントと同時にUnknowns（穴場度）を５段階で評価され、各スポットごとに平均Unknownsが自動的に算出されます。

# 本番環境
https://travel-mood.herokuapp.com/

# テスト用アカウント
- 投稿者用  
  - メールアドレス：poster@com  
  - パスワード：poster_user1  

- コメント・Unknowns評価用  
  - メールアドレス：comment_user@com  
  - パスワード：comment_user1

# 制作背景（意図）  
・行き当たりばったりの旅を楽しみたい  
・王道スポットより穴場スポットが好き  
・リピート地をもっと深掘りしたい  
と思っている人たちはきっと、  

・パンフレットやツアーは、王道コースが多い  
・穴場スポットを気軽に共有できる場所が欲しい  
という思いを抱えていると思います。

そんな人たちの思いを汲み取って制作しました。  

InstagramやTwitterなどの横綱級SNSと差別化させるために、Unknowns評価機能を実装しました。Unknownsとは、「穴場度」を指し、1~5の5段階で評価されます。今まで評価されたUnknownsは各スポットごとに算出されます。ここでいう「バズる」の基準は、Unknownsの高さになります。

# DEMO




# 実装予定の機能


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