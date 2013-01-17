require 'spec_helper'

describe Pomo::Configuration do

  describe '#initialize' do
    it 'instantiates object' do
      options = {
        :notifier => 'foo',
        :progress => 'bar',
        :tmux     => 'baz'
      }
      config = Pomo::Configuration.new(options)
      expect(config.notifier).to eq 'foo'
      expect(config.progress).to eq 'bar'
      expect(config.tmux).to eq 'baz'
    end
  end

  describe '.load' do
    context 'not given a configuration file' do
      it 'returns Configuration object with default options' do
        config = Pomo::Configuration.load
        expect(config.notifier).to eq Pomo::Configuration.default_notifier
        expect(config.progress).to be false
        expect(config.tmux).to be false
      end

      it 'writes a configuration file with default options' do
        Pomo::Configuration.load
        expect(File.read(Pomo::Configuration.config_file)).to eq \
          YAML::dump(Pomo::Configuration.default_options)
      end
    end

    context 'given a configuration file' do
      before(:each) do
        opts = {
          :notifier => 'foo',
          :progress => 'bar',
          :tmux     => 'baz'
        }
        File.open(Pomo::Configuration.config_file, 'w') do |file|
          YAML::dump(opts, file)
        end
      end

      it 'returns Configuration object with options in file' do
        config = Pomo::Configuration.load
        expect(config.notifier).to eq 'foo'
        expect(config.progress).to eq 'bar'
        expect(config.tmux).to eq 'baz'
      end

      context 'given options' do
        it 'overrides options in configuration file' do
          options = {
            :notifier => 'goo',
            :progress => 'car',
            :tmux     => 'caz'
          }
          config = Pomo::Configuration.load(options)
          expect(config.notifier).to eq 'goo'
          expect(config.progress).to eq 'car'
          expect(config.tmux).to eq 'caz'
        end
      end

    end
  end

  describe '.save' do
    let(:options) { {:notifier => 'foo', :progress => 'bar', :tmux => 'baz'} }

    context 'not given a configuration file' do
      it 'writes a configuration file with options' do
        Pomo::Configuration.save(options)
        expect(File.read(Pomo::Configuration.config_file)).to eq \
          YAML::dump(options)
      end
    end

    context 'given a configuration file' do
      before(:each) do
        opts = {
          :notifier => 'goo',
          :progress => 'car',
          :tmux     => 'caz'
        }
        File.open(Pomo::Configuration.config_file, 'w') do |file|
          YAML::dump(opts, file)
        end
      end

      it 'does not overwrite' do
        Pomo::Configuration.save(options)
        expect(File.read(Pomo::Configuration.config_file)).to_not eq \
          YAML::dump(options)
      end

      it 'does overwrite if passed `force` option' do
        Pomo::Configuration.save(options.merge(:force => true))
        expect(File.read(Pomo::Configuration.config_file)).to eq \
          YAML::dump(options)
      end
    end
  end

end
