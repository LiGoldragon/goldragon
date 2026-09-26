# Upgrades

## Horizon 0.13.0: tailnet, router country, USB downlink

Goldragon composes with Horizon 0.13.0.

- Every tailnet client names its own reusable Headscale preauth-key secret:
  `TailnetClient.{ tailnetPreauthKeyOuranos }`, and likewise
  `tailnetPreauthKeyPrometheus`, `tailnetPreauthKeyMirrorAlpha`,
  `tailnetPreauthKeyMirrorBeta` and `tailnetPreauthKeyVmTesting`. Each
  `secrets/<name>.sops` is encrypted to that host's age key alone.
- The controller (ouranos) names its TLS secrets and carries the public
  cluster CA as base64 DER:
  `TailnetController.{ Some.MII… { headscaleTlsCertificate } { headscaleTlsKey } }`.
  It is `None` until the CA is minted; CriomOS refuses to evaluate a tailnet
  node while it is `None`.
- Prometheus's router declares its regulatory country, `MX`, as the last
  `RouterInterfaces` field.
- Ouranos declares `UsbDownlink.{ 10.44.0.0/24 }`. Prometheus declares none:
  its Router LAN already is `10.18.0.0/24`.

- Prometheus builds with eight jobs (`NixBuilder.Some.8`) and records its
  real 16 cores. Ouranos leaves the builder set: with no `NixBuilder`
  capability it projects `max-jobs = 0`, and its dispatcher list names
  Prometheus alone.

The running Lojix and its Signal contracts must carry Horizon 0.13.0 before
this definition is submitted.

## Fixed node location

Horizon 0.9 adds a trailing optional fixed location to every `NodeDefinition`.
Each existing node must carry `None`; a deliberately declared node location is
`Some.{ <latitude-degrees> <longitude-degrees> <altitude-metres> <accuracy-metres> }`.
The Ouranos value is a San Cristóbal de las Casas city-centre override supplied
by its user. It is not a laptop position measurement. Consumers must compose
this cluster source with the same pinned Horizon revision before materializing
or deploying a Horizon definition.

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
