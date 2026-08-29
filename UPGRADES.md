# Upgrades

## ClusterProposal: `datom.dotos` → `proposal.datomic`

The Horizon-owned ClusterProposal source is now `proposal.datomic`, encoded as
positional Datomic and accepted by Horizon 0.5.0. Consumers must replace the
old path and use the current Horizon Text edge; no legacy Dotos parser or
compatibility path is shipped.

This one-shot data conversion decoded the former source with its pinned old
Horizon revision, normalized the intentional `GitoliteServer {}` API break to
the current unit variant, then encoded with Horizon 0.5.0. The old data remains
recoverable outside this repository during release verification.

`synchronizer.dotos` is deliberately unchanged: it is SynchronizerConfig data,
outside the ClusterProposal/Horizon schema boundary, and needs its own owning
tool migration. This repository therefore does not claim a global no-Dotos
conversion.

## Remove Agent Intercom node services

This proposal no longer declares `AgentIntercomLocal` or
`AgentIntercomGraphical`. Consumers must use a Horizon 0.4.0-or-newer revision
that removes both node-service variants before consuming this data.

There is no compatibility data shape. Configure Agent Intercom wrappers and
integrations in their consumers, and configure graphical facilities through
Edge rather than through a proposal service.
