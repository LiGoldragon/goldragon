# Agent Bootstrap — goldragon

## First thing

Run `bd list --status open` to see what's already on the table.

## Scope

Data repo only. Owns the cluster proposal — the source of truth for
every node, user, and trust relation in the LiGoldragon kriom.
Consumed by `horizon-rs` (via `horizon-cli` over the proposal TOML)
and by CriomOS through the horizon projection.

## Schema

The proposal schema lives in [horizon-rs/docs/DESIGN.md](../horizon-rs/docs/DESIGN.md).
Field naming is camelCase (matches Nix idiom when consumed via
`builtins.fromTOML`). Validated by `horizon-cli` on every use.

## Wire format

Currently `datom.nix` during transition; target is `datom.toml`.
See open beads issues for the conversion work.

## Hard process rules

- Jujutsu only. Never `git` CLI.
- Push immediately after every change.
- Mentci three-tuple commit format:
  `(("CommitType", "scope"), ("Action", "what"), ("Verdict", "why"))`.
