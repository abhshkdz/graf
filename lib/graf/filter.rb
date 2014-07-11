#encoding: utf-8

module Graf
  class Filter
    class << self
      IS_GIT = 'git rev-parse --is-inside-work-tree'
      IS_LOG = 'git log'

      def process
        o, e, s = Open3.capture3(IS_GIT)

        if e.include? 'Not a git repository'
          return 'Not a git repository (or any of the parent directories)'
        else
          o, e, s = Open3.capture3(IS_LOG)

          if e.include? 'bad default revision'
            return 'This git repository don\'t have any commits yet'
          else
            Source.authors()
          end
        end
      end
    end
  end
end
