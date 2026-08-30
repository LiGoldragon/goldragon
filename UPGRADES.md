# Upgrades

## ClusterProposal: `datom.dotos` → `proposal.datom`

The Horizon-owned ClusterProposal source is now the canonical named artifact
`proposal.datom`, embodied by Horizon 0.5.0 as `Text<ClusterProposal>`.
Consumers must replace the
old path and use the current Horizon Text edge; no legacy Dotos parser or
compatibility path is shipped.

This one-shot data conversion decoded the former source with its pinned old
Horizon revision, normalized the intentional `GitoliteServer {}` API break to
the current unit variant, then encoded with Horizon 0.5.0. The old data remains
recoverable outside this repository during release verification.

At the time of the ClusterProposal conversion, `synchronizer.dotos` remained
outside Horizon's ownership. Its later Synchronizer-owned migration is recorded
below; this repository still does not claim unrelated data boundaries migrated.

## SynchronizerConfig: `synchronizer.dotos` → `synchronizer.datomic`

The Synchronizer-owned configuration is now `synchronizer.datomic`, decoded
and emitted by Synchronizer 0.3.0 through its Ethos-authored Datomic schema.
The one-shot migration used the pinned legacy Synchronizer decoder once, then
the new `Text<SynchronizerConfig>` encoder. The sole intentional value change
is its cluster-source path: `datom.nota` became the already-migrated
`proposal.datom`. The legacy input remains recoverable outside this data
repository during release verification; no compatibility decoder ships.

## Remove Agent Intercom node services

This proposal no longer declares `AgentIntercomLocal` or
`AgentIntercomGraphical`. Consumers must use a Horizon 0.4.0-or-newer revision
that removes both node-service variants before consuming this data.

There is no compatibility data shape. Configure Agent Intercom wrappers and
integrations in their consumers, and configure graphical facilities through
Edge rather than through a proposal service.
