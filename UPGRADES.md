# Upgrades

## HorizonDefinition composition

The retired `proposal.datom` (`Text<ClusterProposal>`) is replaced by
`cluster-definition.datom`, composed with the independently authored
`HorizonConfiguration` through Horizon’s typed composer. Consumers receive
only the canonical child
`<horizon-definition-derivation>/horizon-definition.datom`; they must not
infer sibling files or read this checkout.

Goldragon now exposes the composition directly as
`packages.<system>.horizon-definition`. The external configuration input is
pinned in `flake.lock`, so rebuilding keeps configuration, cluster data, and
Horizon producer provenance together.

## Synchronizer

`synchronizer.datomic` is now current canonical Datom and uses:

```protos
ClusterRole.{ NixBuilder HorizonDefinition.<canonical-absolute-child> }
```

This retires the temporary `DirectHost.prometheus` configuration while keeping
the prior outcome through typed dynamic selection: the current public
definition resolves `ouranos` at capacity one and `prometheus` at capacity
six, selecting `prometheus`. The remaining configuration semantics—forge,
checkout root, components, branch scheme, verify policy, and commit
identity—are unchanged.

Build `.#synchronizer-configuration` with the matching public Horizon
artifact, then decode it through Synchronizer `0.4.0`'s `validate` example as
shown in the README. This is generation and validation only; it never starts a
Synchronizer run or activates a service.
