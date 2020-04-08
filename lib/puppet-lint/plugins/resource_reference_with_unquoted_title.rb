PuppetLint.new_check(:resource_reference_with_unquoted_title) do
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
              if value_token.next_token.next_token.type == :LBRACK
                check_token = value_token.next_token.next_token.next_token
                if check_token.type == :NAME
                  notify :error, {
                    :message => 'unquoted title in resource reference',
                    :line    => check_token.line,
                    :column  => check_token.column,
                    :token   => check_token,
                  }
                end
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

  def fix(problem)
    if problem[:message] == 'unquoted title in resource reference'
      problem[:token].type = :SSTRING
    end
  end
end