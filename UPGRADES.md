# Upgrades

## Remove Agent Intercom node services

This proposal no longer declares `AgentIntercomLocal` or
`AgentIntercomGraphical`. Consumers must use a Horizon 0.4.0-or-newer revision
that removes both node-service variants before consuming this data.

There is no compatibility data shape. Configure Agent Intercom wrappers and
integrations in their consumers, and configure graphical facilities through
Edge rather than through a proposal service.
