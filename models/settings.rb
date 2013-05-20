class Settings < Settingslogic
  source "#{Padrino.root}/config/application.yml"
  namespace Padrino.env.to_s
end
