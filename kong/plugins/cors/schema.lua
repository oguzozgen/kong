local typedefs = require "kong.db.schema.typedefs"


local methods = { type = "string",
                  one_of = { "HEAD", "GET", "POST", "PUT", "PATCH", "DELETE" } }


return {
  name = "cors",
  fields = {
    { consumer = typedefs.no_consumer },
    { config = {
        type = "record",
        nullable = false,
        fields = {
          { origins = { type = "array", elements = { type = "string", is_regex = true }, }, },
          { headers = { type = "array", elements = { type = "string" }, }, },
          { exposed_headers = { type = "array", elements = { type = "string" }, }, },
          { methods = { type = "array", elements = methods }, },
          { max_age = { type = "number" }, },
          { credentials = { type = "boolean", default = false }, },
          { preflight_continue = { type = "boolean", default = false }, },
    }, }, },
  },
}

