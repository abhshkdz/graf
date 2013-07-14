#encoding: utf-8

module Graf

	class Source

		class << self

			def count_of_commits(log, author)
				log.grep(author).size
			end

			TICK = '▇'

			def authors()
				freq = Hash.new()
				log = `git log --pretty=format:'%an'`.split("\n")
				log.uniq.each do |author|
					freq[author] = count_of_commits(log, author)
				end

				max = freq.max_by { |k,v| v }[1]

				authors = freq.keys.sort_by do |author|
					freq[author]
				end.reverse.map do |author|
					TICK * (freq[author] * 70 / max) +
					" #{author} (#{freq[author]} commit" +
					(freq[author] == 1 ? ")" : "s)")
				end

				return authors
			end

		end

	end

end