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

という思いを抱えていると考えました。

そんな人たちの思いを汲み取って制作しました。  

現在、Unknowns評価機能を実装しています。ここで言うUnknownsとは、「穴場度」を指し、1~5の5段階で評価されます。今まで評価されたUnknownの平均値は各スポットごとに算出されます。ここでいう「バズる」の基準は、Unknownsの高さになります。

# DEMO
## トップページ
[![Image from Gyazo](https://i.gyazo.com/263d9568798b5664b5858169e7762559.gif)](https://gyazo.com/263d9568798b5664b5858169e7762559)  
トップページは、背景を動画にしました。  
トップページから、新規登録ページ、ログインページへ遷移することができます。また、START!をクリックすると、アプリ説明ページへ遷移します。  
現時点では、背景の動画が再生されるまで数十秒かかるので、ファイル圧縮などの改善を予定しています。

## アプリ説明ページ
[![Image from Gyazo](https://i.gyazo.com/4f7196a5b2a6ff7a321125c2900f7a2b.jpg)](https://gyazo.com/4f7196a5b2a6ff7a321125c2900f7a2b)

## 新規登録ページ
[![Image from Gyazo](https://i.gyazo.com/7dc9992ebee506c34c361911a033e870.jpg)](https://gyazo.com/7dc9992ebee506c34c361911a033e870)

## ログインページ
[![Image from Gyazo](https://i.gyazo.com/2e75f711e088520be1e0e7def0e32c0b.jpg)](https://gyazo.com/2e75f711e088520be1e0e7def0e32c0b)

## スポット投稿一覧ページ
[![Image from Gyazo](https://i.gyazo.com/62c451a31ed129684a52543ecc8f7f0a.jpg)](https://gyazo.com/62c451a31ed129684a52543ecc8f7f0a)
スポット投稿一覧ページから、新規スポット投稿ページとスポット詳細ページへ遷移することができます。  
現在、投稿されたスポットの画像をAmazon S3へ保存していないため、非表示となっております。

## 新規投稿ページ
[![Image from Gyazo](https://i.gyazo.com/8bd4fa5ebc3725706895a34b270bf40f.jpg)](https://gyazo.com/8bd4fa5ebc3725706895a34b270bf40f)

# 実装予定の機能
・コメント投稿機能  
・Unknowns評価機能  
・Amazon S3への画像保存

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