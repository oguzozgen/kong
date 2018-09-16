
return {
  name = "request-termination",
  fields = {
    { config = {
        type = "record",
        nullable = false,
        fields = {
          { status_code = {
            type = "integer",
            default = 503,
            between = { 100, 599 },
          }, },
          { message = { type = "string" }, },
          { content_type = { type = "string" }, },
          { body = { type = "string" }, },
    }, }, },
  },
  entity_checks = {
    { only_one_of = { "config.message", "config.content_type" }, },
    { only_one_of = { "config.message", "config.body" }, },
    { conditional = {
      if_field = "config.content_type", if_match = { match = ".+" },
      then_field = "config.body", then_match = { required = true },
    }, },
  }
}
