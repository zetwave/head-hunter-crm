require 'test_helper'
# Table name: comactions
#
#  id          :integer          not null, primary key
#  name        :string
#  status      :string
#  action_type :string
#  start_time  :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#  mission_id  :integer
#  person_id   :integer
#  end_time    :datetime

class ComactionTest < ActiveSupport::TestCase
  def setup
    @comaction = create(:comaction)
    @former_comaction = build(:former_comaction)
  end

  test 'should be valid' do
    assert @comaction.valid?
  end

  test 'empty start_time is ok' do
    @comaction.start_time = nil
    assert @comaction.valid?, "start_time is optional"
  end

  test 'user is mentioned' do
    @comaction.user = nil
    refute @comaction.valid?, "user is linked"
  end

  test 'mission is mentioned' do
    @comaction.mission = nil
    refute @comaction.valid?, "mission is linked"
  end

  test 'person is mentioned' do
    @comaction.person = nil
    refute @comaction.valid?, "person is linked"
  end

  test 'comaction overlap is forbidden' do
    @former_comaction.start_time = @comaction.start_time
    @former_comaction.end_time = @comaction.end_time
    refute @former_comaction.valid?
  end

end
