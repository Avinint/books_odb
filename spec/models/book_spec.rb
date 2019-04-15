require 'rails_helper'

RSpec.describe Book, type: :model do
  let(:book) { FactoryBot.build :book }

  it "can be instanciated" do
    expect(book).not_to be nil
  end

  it "can be saved" do
    expect(book.save).to be true
  end

  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:author) }
    it do
      should validate_numericality_of(:pages_count).
      is_greater_than(0)
    end
  end

  it { should_not allow_values(0,-1).for(:pages_count)}

  describe "automatic slug definition" do
    it "sets the slug on validation" do
      expect(book.slug).to eq nil
      expect { book.valid? }.to change { book.slug }.from(nil).to(book.title.parameterize)
    end

    it "adds increment number if slug is not unique" do
      book.title = "totoro"
      book.save
      expect(FactoryBot.create(:book, title: "totoro").slug).to eq "totoro-1"
      expect(FactoryBot.create(:book, title: "totoro").slug).to eq "totoro-2"
    end
  end

  # it "is invalid without title" do
  #   book.title = nil
  #   expect(book.valid?).to be false
  #   expect(book.errors.messages).to have_key(:title)
  # end

  # it "is invalid without author" do
  #   book.author = nil
  #   expect(book.valid?).to be false
  #   expect(book.errors.messages).to have_key(:author)
  # end

  # it "is invalid with negative page count" do
  #   book.pages_count = -1
  #   expect(book.save).to be false
  # end

  # it "is invalid with 0 page count" do
  #   book.pages_count = 0
  #   expect(book.save).to be false
  # end
end
