describe User do

  before(:each) { @user = User.new(email: 'user@example.com') }

  subject { @user }

  it { is_expected.to have_many :labels }

  it { should respond_to(:email) }

  it "#email returns a string" do
    expect(@user.email).to match 'user@example.com'
  end

end
