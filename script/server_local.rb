APP_PATH = "./config/application"

ARGV.replace([
  "server",
  "-b", ENV.fetch("BIND", "127.0.0.1"),
  "-p", ENV.fetch("PORT", "3000")
])

require "./config/boot"
require "rails/commands"
