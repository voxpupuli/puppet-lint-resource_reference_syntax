# Check for resource references
PuppetLint.new_check(:resource_reference_without_whitespace) do
  def check
    resource_indexes.each do |_resource|
      tokens.select do |token|
        [:CLASSREF].include? token.type
      end.each do |param_token|
        check = param_token
        case check.type
        when :CLASSREF

          if check.next_token.type == :WHITESPACE and check.next_code_token.type == :LBRACK
            notify :error, {
              message: 'whitespce between reference type and title',
              line: check.line,
              column: check.column,
            }
          end

        end
      end
    end
  end
end
