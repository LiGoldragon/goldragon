# Agent Bootstrap — goldragon

## First thing

Run `bd list --status open` to see what's already on the table.

## Scope

Data repo only. Owns the cluster proposal — the source of truth for
every node, user, and trust relation in the LiGoldragon kriom.
Consumed by horizon-rs (via `horizon-cli` over `datom.dotos`) and by
CriomOS through the horizon projection.

## Schema

The proposal schema is owned by horizon-rs. Records are **positional**
(no `field=value`); field order in the dotos matches source-declaration
order in the Rust structs. Validated by `horizon-cli` on every use;
Nix consumers run `horizon-cli` and read the result via
`builtins.fromJSON` (no `builtins.fromDotos` exists).

## Wire format

`datom.dotos` is the wire form. There is no `datom.nix` and no
`flake.nix` — goldragon is pure data; consumers fetch it as a file.

## Hard process rules

- Jujutsu only. Never `git` CLI.
- Push immediately after every change.
- Mentci three-tuple commit format:
  `(("CommitType", "scope"), ("Action", "what"), ("Verdict", "why"))`.
- Before pushing any `datom.dotos` change, use the exact `horizon-rs` revision
  pinned by the intended Lojix revision to project every declared node. A file
  rename or successful legacy-parser run is not a format migration. The
  current parser must accept the canonical source, and Lojix's typed Horizon
  materializer must accept it before deployment. On Ouranos, every `nix run`
  used for this validation must set `max-jobs = 0`, use only
  `@/etc/nix/machines`, and disable fallback so Prometheus performs realization.
