#encoding: utf-8

module Graf
  class Source
    class << self
      TICK = '▇'

      def authors
        log = `git shortlog -se`
        log = log.scan(/(\d+)\t(.*)\<(.*)\>/)
        frequency = {}

        log.each do |row|
          count, username, email = *row
          username.strip!
          email.strip!
          email.gsub!(/(.*)@.*/, '\1')

          frequency[email] ||= {}
          frequency[email][:count] ||= 0
          frequency[email][:count] += count.to_i
          frequency[email][:username] = username
        end

        max = frequency.map { |v| v.last[:count] }.max

        authors = frequency.keys.sort_by { |author| frequency[author][:count] }
        .reverse.map do |author|
          data = TICK * (frequency[author][:count] * 70 / max)
          data << " #{frequency[author][:username]}"
          data << " (#{frequency[author][:count]} commit"
          data << (frequency[author][:count] == 1 ? ")" : "s)")
        end

        authors
      end
    end
  end
end
