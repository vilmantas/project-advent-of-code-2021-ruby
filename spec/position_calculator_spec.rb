require 'rspec'
require_relative '../lib/position_calculator'
require_relative '../lib/data_reader'


describe PositionCalculator do
  subject { described_class.new }

  it 'has coordinates' do
    expect(subject.x).not_to be_nil
    expect(subject.y).not_to be_nil
  end

  it 'can move forward' do
    expect{subject.forward(5)}.to change{subject.x}.by(5)
  end

  it 'can move down' do
    expect{subject.down(5)}.to change{subject.y}.by(5)
  end

  it 'can move up' do
    expect{subject.up(5)}.to change{subject.y}.by(-5)
  end

  it 'can aim up' do
    expect{subject.aim_up(5)}.to change{subject.aim}.by(-5)
  end

  it 'can aim down' do
    expect{subject.aim_down(5)}.to change{subject.aim}.by(5)
  end

  it 'can move with aim' do
    subject.aim_down(5)

    subject.aim_forward(5)

    expect(subject.x).to eq(5)
    expect(subject.y).to eq(25)
  end

  it 'works with sample input for part 1' do
    input = [
      'forward 5',
      'down 5',
      'forward 8',
      'up 3',
      'down 8',
      'forward 2'
    ]

    input.map(&:split).each do |direction, step|
      subject.send(direction, step.to_i)
    end

    expect(subject.x * subject.y).to eq(150)
  end

  it 'works with day-2 input for part 1' do
    DataReader.get_lines(2).map(&:split).each do |direction, step|
      subject.send(direction, step.to_i)
    end

    expect(subject.x * subject.y).to eq(1840243)
  end

  it 'works with day-2 sample input for part 2' do
    input = [
      'forward 5',
      'down 5',
      'forward 8',
      'up 3',
      'down 8',
      'forward 2'
    ]

    input.map(&:split).each do |direction, step|
      subject.send('aim_' + direction, step.to_i)
    end

    expect(subject.x * subject.y).to eq(900)
  end

  it 'works with day-2 input for part 2' do
    DataReader.get_lines(2).map(&:split).each do |direction, step|
      subject.send('aim_' + direction, step.to_i)
    end

    expect(subject.x * subject.y).to eq(1727785422)
  end
end
