# goldragon

Cluster proposal for the LiGoldragon kriom. Production data for every
node, user, and trust relation in the cluster.

This repository is **public** and not authorization-gated. `datom.dotos`
holds no secret values — only references to them. The referenced secret
material (for example the router SAE passwords) lives encrypted in
`secrets/` (SOPS) and never appears in plaintext here, so the repository
and its data are safe to treat as public. Only those encrypted values
are protected; the repo itself is not private.

## Wire format

`datom.dotos` — positional records per the
[dotos](https://github.com/LiGoldragon/dotos) data format. Fed to
`horizon-cli` (from horizon-rs) on stdin; the projected horizon comes
back as JSON. Canonical records use brace bodies, maps use
`Map.(key.value)`, and options use `Some.value` / `None`. Router interface
records include production access facts such as Prometheus' primary router
Wi-Fi and its independent backup Wi-Fi.

```
horizon-cli --cluster goldragon --node tiger < datom.dotos > horizon.json
```

## Validation contract

Before pushing a proposal change, resolve the exact `horizon-rs` revision from
the Lojix revision that will consume it and project every node in this file with
that `horizon-cli`. On Ouranos, launch it with local Nix jobs disabled, the
Prometheus-only `/etc/nix/machines` builder set, and fallback disabled. This is
the durable wire-format witness: validation by a pre-DOTOS/legacy parser or a
mere file-extension rename does not count.

## Consumers

- **horizon-rs** — typed schema + projection. Computes the enriched
  horizon for each `(cluster, node)` viewpoint.
- **CriomOS** — NixOS modules consume the projected horizon (via IFD
  through `horizon-cli`) to build per-node OS configs.

## Schema

The proposal schema is owned by horizon-rs. This canonical source is validated
directly; no shadow migration fixture is authoritative.
