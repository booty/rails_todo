# frozen_string_literal: true

class QueryCounter
  class ItsADatabaseNotAPunchingBag < StandardError; end

  # Borrowed from:
  #   https://stackoverflow.com/questions/5490411/counting-the-number-of-queries-performed
  # I modified it to record time elapsed as well.

  def self.measure(label:, logger: Rails.logger, &block)
    count = 0
    start_time = Time.current
    old_object_hash = ObjectSpace.count_objects

    counter = ->(_name, _started, _finished, _unique_id, payload) {
      unless payload[:name].in? %w[CACHE SCHEMA]
        count += 1
      end
    }

    block_result = ActiveSupport::Notifications.subscribed(counter, "sql.active_record", &block)
    new_object_hash = ObjectSpace.count_objects
    result = {
      query_count: count,
      elapsed: Time.current - start_time,
    }

    logger.info("[QueryCounter] #{label} #{result} #{hash_delta(old_object_hash, new_object_hash)}")
    block_result
  end

  private_class_method def self.hash_delta(old, new)
    old.keys.each_with_object({}) do |k, memo|
      memo[k] = new[k] - old[k]
    end.reject { |_k, v| v.zero? }
  end
end

result = QueryCounter.measure(label: "Inventory") do
  puts "Wow There are #{List.count} lists and"\
       " #{Todo.count} todo items. Where will we find the time?"
  Todo.count + List.count
end

result = QueryCounter.measure(label: "Create 100 strings") do
  100.times.map do
    # "fuck#{rand(0..999)}"
    "hi"
  end
end
