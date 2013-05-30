#encoding: utf-8
require "unicode"
class Employee < ActiveRecord::Base
  belongs_to :user
  attr_accessible :first_name, :last_name, :phone_number
  
  VALID_PHONE_NUMBER_REGEX = /\A38( ||)[0-9]{3}( |)[0-9]{7}\z/
  
  validates :first_name,    length: {in: 2..30, message: "Имя должно содержать от 2 до 30 символов"}
  validates :last_name,     length: {in: 2..30, message: "Фамилия должна содержать от 2 до 30 символов"}
  validates :phone_number,  format: {with: VALID_PHONE_NUMBER_REGEX, message: "Неверно введен номер телефона"},
                            uniqueness: {message: "Работник с таким номероом уже зарегистрирован"} 
  
  before_save do |empl|
    puts empl.first_name[0]      =empl.first_name[0].upcase
    puts empl.first_name[1..-1]  =empl.first_name[1..-1].downcase
    empl.last_name[0]            =empl.last_name[0].upcase
    empl.last_name[1..-1]        =empl.last_name[1..-1].downcase
    empl.phone_number            =empl.phone_number.delete " " 
  end
  
end

class String
   def downcase
     Unicode::downcase(self)
   end
   
   def downcase!
     self.replace downcase
   end

   def upcase
     Unicode::upcase(self)
   end

   def upcase!
     self.replace upcase
   end

   def capitalize
     Unicode::capitalize(self)
   end

   def capitalize!
     self.replace capitalize
   end

end