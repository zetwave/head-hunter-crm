require "test_helper"

class CompaniesControllerTest < ActionDispatch::IntegrationTest

    def setup
      @company = create(:company)
      @user = create(:user)
    end

    test 'should get edit' do
      log_in_as(@user)
      get edit_company_path(@company)
      assert_response :success
    end

    test 'should redirect home when disconnected' do
      get edit_company_path(@company)
      assert_redirected_to login_url
    end
    test 'should get new' do
      log_in_as(@user)
      get new_company_path
      assert_response :success
    end

    test 'should get show' do
      log_in_as(@user)
      get company_path(@company.id)
      assert_response :success
    end
    test 'should redirect update' do
      log_in_as(@user)
      patch company_path(@company), params: { company: { company_name: @company.company_name } }
      refute flash[:success].empty?
      assert_redirected_to companies_url
    end

    test 'should edit when wrong update' do
      log_in_as(@user)
      patch company_path(@company), params: { company: { company_name: ""} }
      refute flash[:danger].empty?
      assert_template 'companies/edit'
    end
    test 'should list people from a company' do
      log_in_as(@user)
      get list_people_company_path(@company.id)
      assert_response :success
      assert_template 'companies/company_people'
    end

    test 'Should get properly sorted list' do
      log_in_as(@user)
      Company.order('company_name DESC').first
      get companies_path, params: { sort: '-updated_at' }
      assert_response :success
    end

    test 'should create company' do
      log_in_as(@user)
      assert_difference 'Company.count', 1 do
        post companies_path,
             params: { company: FactoryBot.attributes_for(:company) }
      end
    end

    test 'should redirect to companies index when creating a company' do
      log_in_as(@user)
      post companies_path,
           params: { company: FactoryBot.attributes_for(:company) }
      assert_redirected_to companies_url
    end

end
