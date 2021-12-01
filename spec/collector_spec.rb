require 'rspec'
require_relative '../lib/collector'
require_relative '../lib/incrementer'
require_relative '../lib/data_reader'

describe Collector do
  subject { described_class.new }

  it 'has three buckets' do
    expect(subject.buckets).to eq([[],[],[]])
  end

  it 'adds item to first empty bucket' do
    subject.add(1)

    expect(subject.buckets).to eq([[1],[],[]])
  end

  it 'adds items to buckets' do
    subject.add(1)
    subject.add(2)

    expect(subject.buckets).to eq([[1,2],[2],[]])
  end

  it 'clears bucket when full' do
    subject.add(1)
    subject.add(2)
    subject.add(3)

    expect(subject.buckets).to eq([[],[2,3],[3]])
  end

  it 'notifies when bucket is full' do
    notified = false

    subject.on_bucket_full do |arr|
      notified = true
    end

    subject.add(1)
    subject.add(2)
    subject.add(3)

    expect(notified).to eq(true)
  end

  it 'notifies with bucket data' do
    bucket = []
    subject.on_bucket_full do |arr|
      bucket = arr
    end

    subject.add(1)
    subject.add(2)
    subject.add(3)

    expect(bucket).to eq([1,2,3])
  end

  it 'works with sample input' do
    incrementer = Incrementer.new

    subject.on_bucket_full do |arr|
      incrementer.process(arr.sum)
    end

    subject.add(199)
    subject.add(200)
    subject.add(208)
    subject.add(210)
    subject.add(200)
    subject.add(207)
    subject.add(240)
    subject.add(269)
    subject.add(260)
    subject.add(263)

    expect(incrementer.increments).to eq(5)
  end

  it 'works' do
    incrementer = Incrementer.new

    subject.on_bucket_full do |arr|
      pp arr.sum
      incrementer.process(arr.sum)
    end

    DataReader.get_lines(1).map(&:to_i).each do |measurement|
      subject.add(measurement)
    end

    pp incrementer.increments
  end
end
