require 'rails_helper'

RSpec.describe Task, type: :model do
  let!(:user1) do
    FactoryBot.create(:user)
  end

  let!(:user2) do
    FactoryBot.create(:user)
  end

  let!(:user3) do
    FactoryBot.create(:user)
  end

  context 'validations check' do
    it 'is valid with valid attributes' do
      task = Task.create!(name: 'Task', user_id: user1.id)
      expect(task).to be_valid
    end
  end

  context 'check state machine' do
    describe 'new' do
      it 'should be an initial state' do
        task = Task.create!(name: 'Task1', user_id: user1.id)
        expect(task.status).to eq('new')
      end
    end

    describe 'event #start' do
      it 'should transit from new to in_progress' do
        task = Task.create!(name: 'Task1', user_id: user1.id)
        task.start!
        expect(task.status).to eq('in_progress')
      end
    end

    describe 'event #complete' do
      it 'should transit from in_progress to completed' do
        task = Task.create!(name: 'Task1', user_id: user1.id, status: :in_progress)
        task.approvals.create!(user_id: user2.id)
        task.approvals.create!(user_id: user3.id)
        expect(task.status).to eq('completed')
      end
    end

    describe 'event #cancel_approval' do
      it 'should cancel approval' do
        task = Task.create!(name: 'Task1', user_id: user1.id, status: :in_progress)
        task.approvals.create!(user_id: user2.id)
        task.approvals.create!(user_id: user3.id)
        task.approvals.find_by(user_id: user3.id).destroy
        expect(task.status).to eq('in_progress')
      end
    end

    describe 'event #cancel' do
      it 'should transit from in_progress to canceled' do
        task = Task.create!(name: 'Task1', user_id: user1.id, status: :in_progress)
        task.cancel!
        expect(task.status).to eq('canceled')
      end
    end
  end
end


