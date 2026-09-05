# goldragon

Public cluster-local Horizon data for the Goldragon cluster. It contains no
secret values; encrypted secret material remains under `secrets/`.

## Authored data and composition

`cluster-definition.datom` is the sole public cluster artifact. It carries
cluster-local nodes, users, domains, trust, and the explicit generic-node
selection. Generic definitions live in the independent
`criomos-horizon-config` producer. A caller pins both immutable sources and
uses its `composeHorizonDefinition` derivation, which invokes Horizon’s typed
composer and exposes the canonical child `horizon-definition.datom`.

Lojix receives that one composed child as its `ProposalSource`. It does not
read this checkout or discover a sibling configuration. Private deployment
material remains a separate privileged Lojix request input.

## Validation

Validate the composed canonical child with Horizon `0.6.0`
(`05879e7c1e5f637f78fbe26234b95213c77c59bc`): it resolves explicitly selected
generic nodes before projecting a requested cluster/node. The composer rejects
unknown selections and local/generic name collisions.

## Synchronizer

`synchronizer.datomic` now names `DirectHost.prometheus`. This preserves the
actual previous NixBuilder result while removing its obsolete
`ClusterProposal` file dependency. A future role-discovery change belongs in
Synchronizer’s own typed consumer migration, not in this data repository.
