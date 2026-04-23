# goldragon

Cluster proposal for the LiGoldragon kriom. Production data for every
node, user, and trust relation in the cluster.

## Wire format

`datom.nota` — positional records per the
[nota](https://github.com/LiGoldragon/nota) data format. Fed to
`horizon-cli` (from horizon-rs) on stdin; the projected horizon comes
back as JSON (default) or nota (`--format nota`).

```
horizon-cli --cluster goldragon --node tiger < datom.nota > horizon.json
```

## Consumers

- **horizon-rs** — typed schema + projection. Computes the enriched
  horizon for each `(cluster, node)` viewpoint.
- **CriomOS** — NixOS modules consume the projected horizon (via IFD
  through `horizon-cli --format json`) to build per-node OS configs.

## Schema

The proposal schema is owned by horizon-rs. The integration tests
there project this `datom.nota` directly; there is no duplicate
fixture.
