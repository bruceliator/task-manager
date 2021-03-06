class User < ActiveRecord::Base
 has_many :tasks, :dependent =>:destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

 validates_presence_of :first_name
 validates_presence_of :last_name

 def full_name
     "#{first_name} #{last_name}"
 end
end
