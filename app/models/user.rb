#encoding: utf-8
class User < ActiveRecord::Base
  has_many :sent_smses, :class_name => "SentSms"
  attr_accessible :email, :password, :name, :password_confirmation
  
  VALID_EMAILS_REGEX= /^([a-z0-9_-]+\.)*[a-z0-9_-]+@[a-z0-9_-]+(\.[a-z0-9_-]+)*\.[a-z]{2,6}$/
  validates :email, format: {with: VALID_EMAILS_REGEX, message: "Вы ввели некорректный E-mail"},
                    uniqueness: {message: "Такой E-mail уже зарегистрирована на сайте."}
  validates :name, length: {in: 2..20, message: "Имя должно содержать от 2-х до 20 символов"}
  validates :password,  length: {in: 6..50, message: "Пароль должен содержать от 6 до 50 символов"},
                        confirmation: {message: "Неверно введено подтверждение пароля"}
  
  before_validation do |user|
    if user.email != nil
      user.email=user.email.downcase
    end
    if user.password != user.password_confirmation
      errors.add(:password_confirmation, "")
    end
  end
  
  after_validation do |user|
    if user.password != nil
      user.password = Digest::SHA1.hexdigest(user.password)
    end
  end
  
end
