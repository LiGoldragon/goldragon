# goldragon — architecture

Goldragon owns public, cluster-local data and the thin Nix composition that
binds it to the independently authored generic catalogue. `cluster-definition.datom`
contains the selected cluster nodes, users, domains, and trust facts. It does
not duplicate generic definitions.

`criomos-horizon-config` owns the generic `HorizonConfiguration`; Horizon owns
the typed decode, composition, and resolution contract. Goldragon’s
`horizon-definition` derivation passes the two immutable inputs to that
composer. Its canonical public interface is the child
`<derivation>/horizon-definition.datom`.

The separate `synchronizer-configuration` derivation renders the current
Synchronizer Datom document. Its builder strategy is
`ClusterRole.{ NixBuilder HorizonDefinition.<canonical-absolute-child> }`.
Synchronizer decodes and resolves that public HorizonDefinition, so only
cluster nodes and explicitly selected generic definitions can compete. It
accepts online nodes, treats an omitted NixBuilder capacity as one, chooses the
largest capacity, and uses node name for deterministic ties. The present
resolved candidates are `ouranos` (one) and `prometheus` (six), selecting
`prometheus` without a host hard-coded in Synchronizer configuration.

Goldragon does not activate Synchronizer or carry a service definition. It
only publishes the immutable configuration artifact. The component list,
branch scheme, verification words, forge, checkout root, and commit author
remain authored config facts; only the obsolete direct-host builder choice was
replaced by the dynamic capability strategy.

Encrypted references under `secrets/` remain outside both generated public
artifacts. No secret content or private deployment authority enters the
Horizon definition, Synchronizer configuration, or Nix outputs.
