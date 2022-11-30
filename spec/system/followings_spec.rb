require 'rails_helper'

RSpec.describe "Followings", type: :system do
  let(:user)           { create :user }
  let(:new_user)       { create :user }
  let(:event)          { create :event }
  let(:attended_event) { EventAttendance.create(user: user, event: event) }

  describe 'フォロー関係' do
    context 'フォローする' do
      it 'ユーザーは他のイベント参加者をフォローできる。' do
        attended_event
        login(new_user)
        visit root_path
        expect(page).to have_content(attended_event.event.title)

        click_link attended_event.event.title
        click_link attended_event.user.name

        expect(page).to have_content('フォローする')

        click_link 'フォローする'

        expect(page).to have_content('フォローを外す')
      end

      it 'ユーザーはイベント主催者をフォローできる。' do
        login(new_user)
        visit event_path(event)
        expect(page).to have_content(event.title)
        expect(page).to have_content('開催前')

        click_link event.user.name

        expect(page).to have_content('フォローする')

        click_link 'フォローする'

        expect(page).to have_content('フォローを外す')
      end
    end

    context 'フォローを解除する' do
      it 'ユーザーは他のイベント参加者でフォロー登録している人を外すことができる' do
        attended_event
        login(new_user)
        visit root_path
        expect(page).to have_content(attended_event.event.title)

        click_link attended_event.event.title
        click_link attended_event.user.name

        expect(page).to have_content('フォローする')

        click_link 'フォローする'

        expect(page).to have_content('フォローを外す')

        click_link 'フォローを外す'

        expect(page).to have_content('フォローする')
      end

      it 'ユーザーはイベント主催者をフォローから外すことができる' do

        login(new_user)
        visit event_path(event)
        expect(page).to have_content(event.title)
        expect(page).to have_content('開催前')

        click_link event.user.name

        expect(page).to have_content('フォローする')

        click_link 'フォローする'

        expect(page).to have_content('フォローを外す')

        click_link 'フォローを外す'

        expect(page).to have_content('フォローする')
      end
    end
  end
end
