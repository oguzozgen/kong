local ORDERED_PERIODS = { "second", "minute", "hour", "day", "month", "year" }


local function validate_periods_order(limit)
  for i, lower_period in ipairs(ORDERED_PERIODS) do
    local v1 = limit[lower_period]
    if type(v1) == "number" then
      for j = i + 1, #ORDERED_PERIODS do
        local upper_period = ORDERED_PERIODS[j]
        local v2 = limit[upper_period]
        if type(v2) == "number" and v2 < v1 then
          return nil, string.format("The limit for %s(%f) cannot be lower than the limit for %s(%f)",
                                    upper_period, v2, lower_period, v1)
        end
      end
    end
  end

  return true
end


return {
  name = "response-ratelimiting",
  fields = {
    config = {
      type = "record",
      nullable = false,
      fields = {
        { header_name = { type = "string", default = "x-kong-limit" }, },
        { limit_by = { type = "string",
                       default = "consumer",
                       one_of = { "consumer", "credential", "ip" },
        }, },
        { policy = { type = "string",
                     default = "cluster",
                     one_of = { "local", "cluster", "redis" },
        }, },
        { fault_tolerant = { type = "boolean", default = true }, },
        { redis_host = { type = "string" }, },
        { redis_port = { type = "number", default = 6379 }, },
        { redis_password = { type = "string" }, },
        { redis_timeout = { type = "number", default = 2000 }, },
        { redis_database = { type = "number", default = 0 }, },
        { block_on_first_violation = { type = "boolean", default = false}, },
        { hide_client_headers = { type = "boolean", default = false }, },
        { limits = {
            type = "map",
            required = "true",
            default = {},
            keys = { type = "string" },
            values = {
              type = "record",
              fields = {
                { second = { type = "number", gt = 0 }, },
                { minute = { type = "number", gt = 0 }, },
                { hour = { type = "number", gt = 0 }, },
                { day = { type = "number", gt = 0 }, },
                { month = { type = "number", gt = 0 }, },
                { year = { type = "number", gt = 0 }, },
              },
              custom_validator = validate_periods_order,
            },
            entity_checks = {
              { at_least_one_of = ORDERED_PERIODS },
            },
          },
        },
      },
    },
  },
  entity_checks = {
    { conditional = {
      if_field = "config.policy", if_match = { eq = "redis" },
      then_field = "config.redis_host", then_match = { required = true },
    } },
    { conditional = {
      if_field = "config.policy", if_match = { eq = "redis" },
      then_field = "config.redis_port", then_match = { required = true },
    } },
    { conditional = {
      if_field = "config.policy", if_match = { eq = "redis" },
      then_field = "config.redis_timeout", then_match = { required = true },
    } },
  },
}
