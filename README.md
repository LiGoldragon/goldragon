# goldragon

Cluster proposal for the LiGoldragon kriom. Production data for every
node, user, and trust relation in the cluster.

Replaces `maisiliym` as the source of truth. Seeded from the maisiliym
`datom.nix` as the production starting point.

## Wire format

Currently Nix (`datom.nix` exported via `flake.outputs.NodeProposal`).
Both Nix and JSON are placeholders — neither is the long-term format.
A new format will be chosen as horizon-rs and the surrounding tooling
mature.

## Consumers

- [`horizon-rs`](https://github.com/LiGoldragon/horizon-rs) — typed
  schema + projection. Computes the enriched horizon for each
  `(cluster, node)` viewpoint.
- [`CriomOS`](https://github.com/LiGoldragon/CriomOS) — NixOS modules
  consume the projected horizon to build per-node OS configs.

## Schema

See [/home/li/git/CriomOS/docs/HORIZON.md](https://github.com/LiGoldragon/CriomOS/blob/main/docs/HORIZON.md)
for the full method DAG and field meanings.
