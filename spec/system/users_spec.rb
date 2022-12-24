require 'rails_helper'

RSpec.describe "Users", type: :system do
  describe 'Sign up関係' do
    context '成功系' do
      it 'Sign upを行い、ログイン処理を行うとイベント一覧ページにリダイレクトされる。' do
        visit signup_path
        fill_in 'Name', with: 'らんてくん'
        fill_in 'Email', with: 'sample@example.com'
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: 'password'
        click_button '登録'

        visit login_path
        fill_in 'email', with: 'sample@example.com'
        fill_in 'password', with: 'password'
        click_button 'ログイン'

        expect(page).to have_content('もくもく会を作る')
      end
    end

    context '失敗系' do
      it 'passwordが未入力だと。Sign upページが表示される。' do
        visit signup_path
        fill_in 'Name', with: 'らんてくん'
        fill_in 'Email', with: 'sample@example.com'
        fill_in 'Password', with: ''
        fill_in 'Password confirmation', with: 'password'
        click_button '登録'

        expect(page).to have_content('I agree to the Terms of Service and Privacy Policy.')
      end

      it 'password_confirmationが未入力だと。Sign upページが表示される。' do
        visit signup_path
        fill_in 'Name', with: 'らんてくん'
        fill_in 'Email', with: 'sample@example.com'
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: ''
        click_button '登録'

        expect(page).to have_content('I agree to the Terms of Service and Privacy Policy.')
      end

      it 'password, password_confirmationが未入力だと。Sign upページが表示される。' do
        visit signup_path
        fill_in 'Name', with: 'らんてくん'
        fill_in 'Email', with: 'sample@example.com'
        fill_in 'Password', with: ''
        fill_in 'Password confirmation', with: ''
        click_button '登録'

        expect(page).to have_content('I agree to the Terms of Service and Privacy Policy.')
      end
    end
  end
end
