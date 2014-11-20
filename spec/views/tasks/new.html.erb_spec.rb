require 'spec_helper'

describe "tasks/new" do
  before(:each) do
    assign(:task, stub_model(Task,
      :title => "MyString",
      :description => "MyString",
      :priority => 1,
      :user_id => 1
    ).as_new_record)
  end

  it "renders new task form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", tasks_path, "post" do
      assert_select "input#task_title[name=?]", "task[title]"
      assert_select "input#task_description[name=?]", "task[description]"
      assert_select "input#task_priority[name=?]", "task[priority]"
      assert_select "input#task_user_id[name=?]", "task[user_id]"
    end
  end
end
