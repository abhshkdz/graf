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
					frequency[email] ||= {}
					frequency[email][:count] ||= 0
					frequency[email][:count] += count.to_i
					frequency[email][:username] = username
				end
				max = frequency.map {|v|v.last[:count]}.max
				authors = frequency.keys.sort_by do |author|
					frequency[author][:count]
				end.reverse.map do |author|
					TICK * (frequency[author][:count] * 70 / max) +
					" #{frequency[author][:username]} (#{frequency[author][:count]} commit" +
					(frequency[author][:count] == 1 ? ")" : "s)")
				end
				return authors
			end
		end
	end
end