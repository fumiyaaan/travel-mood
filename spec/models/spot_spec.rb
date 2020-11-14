require 'rails_helper'

RSpec.describe Spot, type: :model do
  before do
    @spot = FactoryBot.build(:spot)
  end

  describe 'スポットの投稿' do
    context 'スポットの投稿がうまくいくとき' do
      it 'image, title, descriptionがあれば投稿できる' do
        expect(@spot).to be_valid
      end
    end

    context 'スポットの投稿がうまくいかないとき' do
      it 'imageがなければ投稿できない' do
        @spot.image = nil
        @spot.valid?
        expect(@spot.errors.full_messages).to include("Image can't be blank")
      end

      it 'titleがなければ投稿できない' do
        @spot.title = ''
        @spot.valid?
        expect(@spot.errors.full_messages).to include("Title can't be blank")
      end

      it 'descriptionがなければ投稿できない' do
        @spot.description = nil
        @spot.valid?
        expect(@spot.errors.full_messages).to include("Description can't be blank")
      end
    end
  end
end
