require 'spec_helper'

describe Post do
  let(:user) {FactoryGirl.create(:user) }
  before { @post = user.posts.build(title: "Blank title", content: "Lorem ipsum") }

  subject { @post }

  it { should respond_to(:title) }
  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should == user }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Post.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "when user_id is not present" do
    before { @post.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank title" do
    before { @post.title = " " }
    it { should_not be_valid }
  end
  
  describe "with blank content" do
    before { @post.content = " " }
    it { should_not be_valid }
  end

  describe "with title that is too long" do
    before { @post.title = "a" * 201 }
    it { should_not be_valid }
  end

  describe "with content that is too long" do
    before { @post.content = "a" * 451 }
    it { should_not be_valid }
  end

end
