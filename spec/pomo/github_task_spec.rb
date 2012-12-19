require 'spec_helper'

describe Pomo::GithubTask do

  let(:github_task) { Pomo::GithubTask.new 'foo' }

  describe '#github?' do
    it 'returns true' do
      expect(github_task.github?).to be_true
    end
  end

end
