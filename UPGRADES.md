# Upgrades

## HorizonDefinition composition

The retired `proposal.datom` (`Text<ClusterProposal>`) has been removed.
`cluster-definition.datom` is composed with the independently authored
`HorizonConfiguration` by Horizon’s typed composer. Consumers must pass the
resulting canonical `horizon-definition.datom` child explicitly; they must not
infer sibling files or read this checkout.

## Synchronizer

`synchronizer.datomic` changed from a legacy `ClusterRole` proposal lookup to
`DirectHost.prometheus`. The prior NixBuilder resolver selected that host, so
the change preserves the configured build host while removing the retired
parser dependency.
