require 'spec_helper'

describe Pomo::Task do

  let(:task) { Pomo::Task.new 'foo' }

  describe '#start' do
    it 'does nada'
  end

  describe '#github?' do
    it 'returns false' do
      expect(task.github?).to be_false
    end
  end

end
