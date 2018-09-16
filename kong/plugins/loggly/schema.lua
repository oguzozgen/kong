local severity = {
  type = "string",
  default = "info",
  one_of = { "debug", "info", "notice", "warning", "err", "crit", "alert", "emerg" },
}

return {
  name = "loggly",
  fields = {
    config = {
      type = "record",
      nullable = false,
      fields = {
        { host = { type = "string", default = "logs-01.loggly.com" }, },
        { port = { type = "integer", default = 514 }, },
        { key = { type = "string", required = true }, },
        { tags = {
            type = "set",
            default = { "kong" },
            elements = { type = "string" },
        }, },
        { log_level = severity },
        { successful_severity = severity },
        { client_errors_severity = severity },
        { server_errors_severity = severity },
        { timeout = { type = "number", default = 10000 }, },
      },
    },
  },
}
