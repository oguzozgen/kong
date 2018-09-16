return {
  name = "tcp-log",
  fields = {
    { config = {
        type = "record",
        nullable = false,
        fields = {
          { host = { type = "string", required = true }, },
          { port = { type = "integer", required = true }, },
          { timeout = { type = "number", default = 10000 }, },
          { keepalive = { type = "number", default = 60000 }, },
          { tls = { type = "boolean", default = false }, },
          { tls_sni = { type = "string" }, },
        },
    }, },
  }
}
