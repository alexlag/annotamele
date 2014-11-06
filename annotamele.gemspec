require "./lib/annotamele/version"

Gem::Specification.new do |s|
  s.name        = 'annotamele'
  s.version     = Version.current
  s.executables << 'annotamele'
  s.date        = Version.current_date
  s.files 		= Dir['lib/   *.rb'] + Dir['bin/*']
  s.summary     = "AnnotameLE app generator"
  s.authors     = ["Alexey Laguta"]
  s.email       = 'laguta@ispras.ru'
end