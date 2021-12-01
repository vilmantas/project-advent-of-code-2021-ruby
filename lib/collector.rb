
class Collector

  attr_reader :buckets, :size, :up_to

  def initialize(size=3)
    @buckets = []
    @size = size
    @up_to = 1

    prepare_buckets
  end

  def prepare_buckets
    size.times do
      buckets.append([])
    end
  end

  def add(item)
    current_bucket_index = 0

    up_to.times do
      buckets[current_bucket_index] << item
      current_bucket_index += 1
    end

    @up_to += 1 unless @up_to >= size

    validate_buckets
  end

  def on_bucket_full(&action)
    @on_bucket_full = action
  end

  private

  def validate_buckets
    buckets.each { |bucket| check(bucket) }
  end

  def check(bucket)
    if bucket.count == size
      notify_full(bucket.shift(size))
    end
  end

  def notify_full(data)
    unless @on_bucket_full.nil?
      @on_bucket_full.call(data)
    end
  end
end