PuppetLint.new_check(:resource_reference_without_whitespace) do
  def check
    resource_indexes.each do |resource|
      resource[:param_tokens].select { |param_token|
        ['require', 'subscribe', 'notify', 'before', 'consume', 'export'].include? param_token.value
      }.each do |param_token|
        value_token = param_token.next_code_token
        check = value_token.next_token
        until resource[:param_tokens].include? check or not resource[:tokens].include? check or check.nil?
          case value_token.next_token.type
          when :CLASSREF
            begin
              if value_token.next_token.next_token.type == :WHITESPACE
                notify :error, {
                  :message => 'whitespce between reference type and title',
                  :line    => value_token.next_token.next_token.line,
                  :column  => value_token.next_token.next_token.column
                }
              end
              value_token = value_token.next_token
              check = value_token.next_token
            end
          else
            value_token = value_token.next_token
            check = value_token.next_token
          end
        end
      end
    end
  end
end
