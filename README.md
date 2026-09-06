# goldragon

Public cluster-local Horizon data and generated integration artifacts for the
Goldragon cluster. Encrypted secret material remains under `secrets/`; it is
not an input to the public Horizon or Synchronizer outputs.

## Authored data and composition

`cluster-definition.datom` is the public cluster artifact. It carries
cluster-local nodes, users, domains, trust, and the explicit generic-node
selection. Generic definitions live in the independent
`criomos-horizon-config` producer.

This flake pins Horizon `0.6.0`, the cluster-neutral external configuration,
and Synchronizer `0.4.0`. Its two public outputs are:

- `horizon-definition`: a derivation directory containing the canonical child
  `horizon-definition.datom`.
- `synchronizer-configuration`: one current Synchronizer Datom document whose
  `ClusterRole.NixBuilder` source is that exact canonical child.

The derivation invokes Horizon’s typed composer. It rejects unknown generic
selections and local/generic name collisions. The public definition contains
no private deployment material. Lojix receives that canonical child as its
single `ProposalSource`; secret authority remains a separate caller-owned
input.

## Build and validate

Build the public artifacts remotely through the configured builders:

```sh
nix build -L --no-link --max-jobs 0 --option fallback false \
  .#horizon-definition .#synchronizer-configuration
```

The canonical proposal is
`$(nix path-info .#horizon-definition)/horizon-definition.datom`; do not pass
the directory or discover sibling files. Decode the rendered configuration
without starting a Synchronizer run:

```sh
(
  cd /path/to/checked-out/synchronizer-at-b42c9df295adccdd65381f8bd444147099036183
  nix develop --command cargo run --example validate -- \
    "$(nix path-info /path/to/goldragon#synchronizer-configuration)"
)
```

`nix flake check` verifies the definition with Horizon CLI, verifies the
rendered absolute child reference, and records the current eligible
`NixBuilder` set: `ouranos` at the default capacity of one and `prometheus` at
six. Synchronizer’s typed resolver therefore selects `prometheus`; its own
role-resolution tests cover capacity, online eligibility, deterministic ties,
and missing candidates.
