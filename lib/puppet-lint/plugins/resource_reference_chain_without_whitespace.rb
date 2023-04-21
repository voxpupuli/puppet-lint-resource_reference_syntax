# Check for Class references
PuppetLint.new_check(:resource_reference_chain_without_whitespace) do
  def check
    tokens.select do |token|
      [:TYPE].include? token.type
    end.each do |param_token|
      check = param_token
      case check.type
      when :TYPE

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
