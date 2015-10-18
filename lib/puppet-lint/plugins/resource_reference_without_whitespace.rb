PuppetLint.new_check(:resource_reference_without_whitespace) do
  def check
    resource_indexes.each do |resource|
      resource[:param_tokens].select { |param_token|
        ['require', 'subscribe', 'notify', 'before', 'consume', 'export'].include? param_token.value
      }.each do |param_token|
        value_token = param_token.next_code_token.next_code_token.next_token
        if value_token.type != :LBRACK
          notify :error, {
            :message => 'whitespce between reference type and title',
            :line    => param_token.next_code_token.next_code_token.line,
            :column  => param_token.next_code_token.next_code_token.column
          }
        end
      end
    end
  end
end
