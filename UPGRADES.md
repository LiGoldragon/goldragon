# Upgrades

## ClusterProposal: `datom.dotos` → `proposal.datom`

The Horizon-owned ClusterProposal source is the sole canonical named artifact
`proposal.datom`, embodied by Horizon 0.5.0 as `Text<ClusterProposal>`.
Consumers must use the current Horizon Text edge; no legacy Dotos parser or
compatibility artifact is shipped.

The one-shot conversion removed the obsolete `AgentIntercomLocal` and
`AgentIntercomGraphical` node-service variants and normalized
`GitoliteServer {}` to its current unit variant. It preserves the remaining
cluster facts and their Horizon projections.

## SynchronizerConfig: `synchronizer.dotos` → `synchronizer.datomic`

The Synchronizer-owned configuration now names the canonical
`/git/github.com/LiGoldragon/goldragon/proposal.datom` source for its declared
ClusterProposal builder-role resolution.
