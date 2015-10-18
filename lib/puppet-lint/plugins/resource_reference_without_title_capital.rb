PuppetLint.new_check(:resource_reference_without_title_capital) do
  def check
    resource_indexes.each do |resource|
      resource[:param_tokens].select { |param_token|
        ['require', 'subscribe', 'notify', 'before', 'consume', 'export'].include? param_token.value
      }.each do |param_token|
        value_token = param_token.next_code_token.next_code_token.next_code_token.next_token
        unless value_token.type == :SSTRING or value_token.type == :VARIABLE
          notify :error, {
            :message => 'resource reference with title with capital letter',
            :line    => value_token.line,
            :column  => value_token.column
          }
        end
      end
    end
  end
end
