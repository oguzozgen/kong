return {
  name = "request-size-limiting",
  fields = {
    config = {
      type = "record",
      nullable = false,
      fields = {
        { allowed_payload_size = { type = "integer", default = 128 }, },
      },
    },
  },
}
