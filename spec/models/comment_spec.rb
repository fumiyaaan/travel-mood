require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end

  describe 'コメントの投稿' do
    context 'コメントの投稿がうまくいくとき' do
      it 'text, unknownがあれば投稿できる' do
        expect(@comment).to be_valid
      end
    end

    context 'コメントの投稿がうまくいかないとき' do
      it 'textがなければ投稿できない' do
        @comment.text = ''
        @comment.valid?
        expect(@comment.errors.full_messages).to include("Text can't be blank")
      end

      it 'unknownがなければ投稿できない' do
        @comment.unknown = ''
        @comment.valid?
        expect(@comment.errors.full_messages).to include("Unknown can't be blank")
      end

      it 'unknownが1~5の半角数字で入力されていなければ投稿できない' do
        @comment.unknown = 6
        @comment.valid?
        expect(@comment.errors.full_messages).to include('Unknown Input one number within 1 to 5')
      end
    end
  end
end
