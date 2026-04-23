# goldragon

Cluster proposal for the LiGoldragon kriom. Production data for every
node, user, and trust relation in the cluster.

Replaces `maisiliym` as the source of truth. Seeded from the maisiliym
`datom.nix` as the production starting point.

## Wire format

Currently Nix (`datom.nix` exported via `flake.outputs.NodeProposal`).
Target is `datom.nota` — `horizon-cli` reads nota on stdin and emits
the enriched horizon as nota by default, or as JSON via
`--format json` for Nix consumers (since `builtins.fromNota` does not
exist). Tracked in beads `gold-lu7` / `gold-21l`.

## Consumers

- [`horizon-rs`](https://github.com/LiGoldragon/horizon-rs) — typed
  schema + projection. Computes the enriched horizon for each
  `(cluster, node)` viewpoint.
- [`CriomOS`](https://github.com/LiGoldragon/CriomOS) — NixOS modules
  consume the projected horizon to build per-node OS configs.

## Schema

See [/home/li/git/horizon-rs/docs/DESIGN.md](/home/li/git/horizon-rs/docs/DESIGN.md)
for the typed schema and projection logic. The integration tests in
[/home/li/git/horizon-rs/lib/tests/projection.rs](/home/li/git/horizon-rs/lib/tests/projection.rs)
(against the nota fixture in `lib/tests/fixtures/maisiliym.nota`) are
the executable spec.
