# アプリケーション名
Travel Mood

# アプリケーション概要
Travel Moodは、スポット投稿型SNSです。
ユーザーを登録するとスポットを投稿できるようになります。自身が投稿したスポットは、編集と削除をすることができます。他のユーザーが投稿したスポットにコメントすることができます。また、ユーザー同士でUnknowns（穴場度）を5段階で評価することで、穴場スポットが見つかるかもしれません。

# URL
https://travel-mood.herokuapp.com/

# テスト用アカウント
 

# 利用方法


# 目指した課題解決
  

# 洗い出した用件


# 実装した機能についてのGIFと説明


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


# ローカルでの動作方法
