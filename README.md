# アプリケーション名
Travel Mood

# アプリケーション概要
*旅行気分を味わえる*ことを意識したスポット投稿型SNS
ユーザーを登録するとスポットを投稿できるようになります。自身が投稿したスポットは、編集と削除をすることができます。他のユーザーが投稿したスポットにコメントすることができます。他のユーザーが投稿したスポットを、お気に入りのスポットとして保存することができます。

# URL
※デプロイ後に記述

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
| email              | string | null: false               |
| password           | string | null: false               |
| profile            | text   |                           |

### Association
-has_many :spots
-has_many :comments
-has_many :likes


## spotsテーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| title       | string     | null: false                    |
| description | text       | null: false                    |
| user        | references | null: false, foreign_key: true |

### Association
-belongs_to :user
-has_many :comments
-has_many :likes


## commentsテーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| text   | text       | null: false                    |
| user   | references | null: false, foreign_key: true |
| spot   | references | null: false, foreign_key: true |

### Association
-belongs_to :user
-belongs_to :spot


## likesテーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| spot   | references | null: false, foreign_key: true |

### Association
-belongs_to :user
-belongs_to :spot


## ER図
[![Image from Gyazo](https://i.gyazo.com/2b254ac1e46869bbb1c5597c79431982.png)](https://gyazo.com/2b254ac1e46869bbb1c5597c79431982)


# ローカルでの動作方法
