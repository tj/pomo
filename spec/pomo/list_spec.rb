require 'spec_helper'

describe Pomo::List do

  let(:list) { Pomo::List.new }
  let(:tasks) { [Pomo::Task.new('foo'), Pomo::Task.new('bar'), Pomo::Task.new('baz')] }

  before(:each) do
    list.tasks.concat(tasks)
  end

  describe '#find' do
    context "given 'all'" do
      it 'yields all tasks' do
        expect { |b| list.find('all', &b) }.to yield_successive_args(tasks[0], tasks[1], tasks[2])
      end

    end

    context "given 'first'" do
      it 'yields the first task' do
        expect { |b| list.find('first', &b) }.to yield_successive_args(tasks[0])
      end
    end

    context "given 'last'" do
      it 'yields the last task' do
        expect { |b| list.find('last', &b) }.to yield_successive_args(tasks[2])
      end
    end

    context "given 'complete'" do
      it 'yields all completed tasks' do
        list.tasks[0].complete = true
        expect { |b| list.find('complete', &b) }.to yield_successive_args(tasks[0])
      end
    end

    context "given 'incomplete'" do
      it 'yields all incompleted tasks' do
        list.tasks[0].complete = true
        expect { |b| list.find('incomplete', &b) }.to yield_successive_args(tasks[1], tasks[2])
      end
    end

    context "given a range e.g. '2..5'" do
      it 'yields the given range of tasks' do
        expect { |b| list.find('1..2', &b) }.to yield_successive_args(tasks[1], tasks[2])
      end
    end

    context "given an index or multiple indexes e.g. '2 8 1'" do
      it 'yields the tasks at the given index(es)' do
        expect { |b| list.find('0', '2', &b) }.to yield_successive_args(tasks[0], tasks[2])
      end
    end
  end
end
