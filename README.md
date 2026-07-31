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
back as JSON (default) or dotos (`--format dotos`). Router interface
records include production access facts such as Prometheus' primary
router Wi-Fi and its independent backup Wi-Fi.

```
horizon-cli --cluster goldragon --node tiger < datom.dotos > horizon.json
```

## Consumers

- **horizon-rs** — typed schema + projection. Computes the enriched
  horizon for each `(cluster, node)` viewpoint.
- **CriomOS** — NixOS modules consume the projected horizon (via IFD
  through `horizon-cli --format json`) to build per-node OS configs.

## Schema

The proposal schema is owned by horizon-rs. The integration tests
there project this `datom.dotos` directly; there is no duplicate
fixture.
