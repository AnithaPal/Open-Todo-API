require 'rails_helper'

RSpec.describe User, :type => :model do

  it "has valid factory" do
    expect(build(:user)).to be_valid
  end

  it "is invalid without a username" do
    user = build(:user, username: nil)
    user.valid?
    expect(user.errors[:username]).not_to include("can't be blank")
  end

  it "is invalid without an email" do
    user = build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).not_to include("can't be blank")
  end

  it "is invalid without a password" do
    user = build(:user, password: nil)
    user.valid?
    expect(user.errors[:password]).not_to include("can't be blank")
  end

  it "is invalid with a duplicate email address" do
    create(:user, email: 'john@example.com')
    user = build(:user, email: 'john@example.com')
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end
end
