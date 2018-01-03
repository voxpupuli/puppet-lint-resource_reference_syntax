require 'pry'
PuppetLint.new_check(:resource_reference_without_whitespace) do
  def check
    resource_indexes.each do |resource|
      tokens.select { |token|
        [:CLASSREF].include? token.type
      }.each do |param_token|
        check = param_token
        case check.type
        when :CLASSREF
#          binding.pry
          begin
            if check.next_token.type == :WHITESPACE and check.next_code_token.type == :LBRACK
              notify :error, {
                :message => 'whitespce between reference type and title',
                :line    => check.line,
                :column  => check.column
              }
            end
          end
        end
      end
    end
  end
end
