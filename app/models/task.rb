class Task < ActiveRecord::Base
 belongs_to :user
 validates :title, :description, :due_date, :priority, :user_id, :presence => true
end
