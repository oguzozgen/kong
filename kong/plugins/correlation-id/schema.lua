return {
  name = "correlation-id",
  fields = {
    config = {
      type = "record",
      nullable = false,
      fields = {
        { header_name = { type = "string", default = "Kong-Request-ID" }, },
        { generator = { type = "string", default = "uuid#counter",
                        one_of = { "uuid", "uuid#counter", "tracker" }, }, },
        { echo_downstream = { type = "boolean", default = false, }, },
      },
    },
  },
}
