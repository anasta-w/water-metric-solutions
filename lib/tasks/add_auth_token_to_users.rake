namespace :user_auth_tokens do

  def has_auth_token? (user)
    return true if user.auth_token
    false
  end

  task :add_auth_tokens  => :environment do
    no_token = User.all.select do |user|
      user if !has_auth_token?(user)
    end

    no_token.each do |user|
      add_auth_token_to_user(user)
    end
  end

  def add_auth_token_to_user (user)
    user.generate_token(:auth_token)
    user.save!
  end

end
