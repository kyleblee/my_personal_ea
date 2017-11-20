require 'bundler'
require 'rack-flash'
Bundler.require

require_all 'app'

configure :development do
  ActiveRecord::Base.establish_connection(
    :adapter => 'sqlite3',
    :database => "db/development.sqlite"
  )
end

configure :production do
  db = URI.parse(ENV['DATABASE_URL'] || 'postgres://ahheecdyfangjs:454cbb597691c8ef3af90f7ff43dd9c5726ef45fe70aac1e3074fc744644f33f@ec2-50-17-235-5.compute-1.amazonaws.com:5432/ddlfej8i75quef')

  ActiveRecord::Base.establish_connection(
    :adapter => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
    :host => db.host,
    :username => db.user,
    :password => db.password,
    :database => db.path[1..-1],
    :encoding => 'utf8'
  )
end
