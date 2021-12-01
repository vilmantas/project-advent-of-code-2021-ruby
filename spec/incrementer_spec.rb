require 'rspec'
require_relative '../lib/incrementer'
require_relative '../lib/data_reader'

describe Incrementer do
  subject { described_class.new }

  it 'runs' do
    expect(subject).not_to be_nil
  end

  it 'starts with 0 increments' do
    expect(subject.increments).to eq(0)
  end

  it 'processes measurements' do
    expect(subject.process(5)).to be_truthy
  end

  it 'does not increment on first occurrence' do
    subject.process(5)
    expect(subject.increments).to eq(0)
  end

  it 'tracks previous measurement' do
    subject.process(5)

    expect(subject.previous).to eq(5)
  end

  it 'tracks measurement increases' do
    subject.process(5)
    expect{subject.process(6)}.to change{subject.increments}.from(0).to(1)
  end

  it 'works with day-1 input' do
    DataReader.get_lines(1).map(&:to_i).each do |measurement|
      subject.process(measurement)
    end

    pp subject.increments
  end
end