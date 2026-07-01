# goldragon — architecture

## Overview

`goldragon` is a **data repository only**. It owns the cluster proposal — the
single source of truth for every node, user, and trust relation in the
LiGoldragon kriom. This is production data, not a fixture.

The repository holds no code and no build: there is no `datom.nix` and no
`flake.nix`. Consumers fetch the data as a file.

## Data ownership

- `datom.nota` is the wire form and the only substantive artifact. It holds the
  production nodes, the users, and the trust and access relations of the cluster,
  including router interface records that carry production access facts (for
  example Prometheus's primary router Wi-Fi and its independent backup Wi-Fi).
- `secrets/` holds the deployment secret material the proposal references; secret
  files are named to match their verbatim camelCase attribute names in the data,
  and the values referenced from the proposal (such as the router SAE passwords)
  are secret material that stays out of any public surface.

## Wire format

`datom.nota` is **positional NOTA** per the
[nota](https://github.com/LiGoldragon/nota) data format: records carry no
`field=value` pairs, and field order matches source-declaration order in the
owning Rust structs. The file is canonical NOTA — bracket strings, curly maps,
and Pascal-case booleans.

It is fed to `horizon-cli` on stdin; the projected horizon comes back as JSON by
default or NOTA with `--format nota`:

```sh
horizon-cli --cluster goldragon --node tiger < datom.nota > horizon.json
```

## Schema ownership

The proposal schema is **owned by horizon-rs** (its `ClusterProposal` type), not
by this repository. `horizon-cli` validates the data on every use. Nix consumers
run `horizon-cli --format json` and read the result with `builtins.fromJSON`;
there is no `builtins.fromNota`, so JSON is the projection format Nix reads.

## Consumers

- **horizon-rs** — the typed schema plus projection. It computes the enriched
  horizon for each `(cluster, node)` viewpoint. Its integration tests project this
  `datom.nota` directly; there is no duplicate fixture copy.
- **CriomOS** — NixOS modules consume the projected horizon (via IFD through
  `horizon-cli --format json`) to build the per-node operating-system configs.

## Constraints

- The data is the source of truth: keep it authoritative and do not fork a second
  copy for testing. horizon-rs projects this file directly.
- Records stay positional and in source-declaration order; validity is defined by
  the horizon-rs schema and enforced by `horizon-cli`, not by this repository.
- No code, no `datom.nix`, no `flake.nix` — the repository stays pure data.
- Process posture (jj-only version control, push immediately after every change,
  and the Mentci three-tuple commit format) is operational and lives in
  `AGENTS.md`.

## Code map

- `datom.nota` — the cluster proposal (the wire form and source of truth).
- `secrets/` — referenced deployment secret material.
