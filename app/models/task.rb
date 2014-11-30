class Task < ActiveRecord::Base
 belongs_to :user
 validates :title, :description, :due_date, :priority, :user_id, :presence => true
 validate :task_set_in_the_future
 
 
 def task_set_in_the_future
    if due_date <= DateTime.current
      errors.add(:task, "Please Choose A Future Date & Time")
    end
  end
  
end
