require 'uri'
require 'json'

me_json = nil

begin
  me_json = JSON.parse(File.read('./me.json'))
rescue JSON::ParserError => exception
  message = 'O arquivo me.json contém um JSON inválido.'

  puts '-' * message.size
  puts message
  puts '-' * message.size
  puts
  puts "erro: #{exception.message}"
end

email = me_json.fetch("email")

if email.match?(::URI::MailTo::EMAIL_REGEXP)
  bundle_name = email.tr('@', '').tr('.', '').downcase
  bundle_file = "#{bundle_name}.bundle"

  system("rm #{bundle_file}; git bundle create #{bundle_file} main")
  puts
  puts "Parabéns, faça upload do arquivo #{bundle_file} "\
    "nesse form: https://forms.gle/2Bwqm9G3Mzv3nUaD7.\nBoa sorte!"
else
  puts "Detectado email inválido no me.json\n" \
    'Por favor corrija-o e garanta que as outras informações estejam válidas.'
end
