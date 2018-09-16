return {
  name = "udp-log",
  fields = {
    { config = {
        type = "record",
        nullable = false,
        fields = {
          { host = { type = "string", required = true }, },
          { port = { type = "integer", required = true }, },
          { timeout = { type = "number", default = 10000 }, },
    }, }, },
  },
}
