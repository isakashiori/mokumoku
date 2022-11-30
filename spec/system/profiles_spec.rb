require 'rails_helper'

RSpec.describe "Profiles", type: :system do
  let(:user)       { create :user, hobby: 'プログラミング', profile: 'プログラミングスクール「RUNTEQ」にて学び...' }
  let(:other_user) { create :user, hobby: '読書', profile: '読書が好きで...' }
  let(:new_user)   { create :user }
  let(:event)      { create :event, user: user }
  let(:attended_event) { EventAttendance.create(user: other_user, event: event) }

  describe 'profile関係' do
    context 'profileを登録できる・更新できる' do
      it 'ユーザーはhobby・profileを登録できる。' do
        login(new_user)
        visit mypage_profile_path
        fill_in 'Hobby', with: '学習'
        fill_in 'Profile', with: '今月からWebエンジニアを目指して...'
        click_button '更新する'

        expect(page).to have_field 'Hobby', with: '学習'
        expect(page).to have_field 'Profile', with: '今月からWebエンジニアを目指して...'
      end

      it 'ユーザーはhobby・profileを更新できる。' do
        login(user)
        visit mypage_profile_path
        expect(page).to have_field 'Hobby', with: user.hobby
        expect(page).to have_field 'Profile', with: user.profile

        fill_in 'Hobby', with: '学習'
        fill_in 'Profile', with: '今月からWebエンジニアを目指して...'
        click_button '更新する'

        expect(page).to have_field 'Hobby', with: '学習'
        expect(page).to have_field 'Profile', with: '今月からWebエンジニアを目指して...'
      end
    end

    context 'イベント主催者のプロフィールを閲覧できる' do
      it 'イベント主催者の名前をクリックすると、イベント主催者のhobby・profileが閲覧できる。' do
        event
        login(new_user)
        visit root_path
        expect(page).to have_content(event.title)

        click_link event.user.name

        expect(page).to have_content(event.user.name)
        expect(page).to have_content(event.user.hobby)
        expect(page).to have_content(event.user.profile)
      end
    end

    context 'イベント参加者のプロフィールを閲覧できる' do
      it 'イベント詳細ページから参加者の名前をクリックすると、対象ユーザーのhobby・profileが閲覧できる。' do
        attended_event
        login(new_user)
        visit root_path
        expect(page).to have_content(attended_event.event.title)

        click_link attended_event.event.title
        click_link attended_event.user.name

        expect(page).to have_content(attended_event.user.name)
        expect(page).to have_content(attended_event.user.hobby)
        expect(page).to have_content(attended_event.user.profile)
      end
    end
  end
end
