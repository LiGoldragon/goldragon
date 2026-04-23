# Agent Bootstrap — goldragon

## First thing

Run `bd list --status open` to see what's already on the table.

## Scope

Data repo only. Owns the cluster proposal — the source of truth for
every node, user, and trust relation in the LiGoldragon kriom.
Consumed by `horizon-rs` (via `horizon-cli` over the proposal nota)
and by CriomOS through the horizon projection.

## Schema

The proposal schema is owned by `horizon-rs` (see that repo's
`docs/DESIGN.md`). Field naming is camelCase on the wire (matches Nix
idiom). Validated by `horizon-cli` on every use; Nix consumers run
`horizon-cli --format json` and read the result via `builtins.fromJSON`
(no `builtins.fromNota` exists).

## Wire format

Currently `datom.nix` during transition; target is `datom.nota`.
See open beads issues `gold-lu7` / `gold-21l` for the conversion work.

## Hard process rules

- Jujutsu only. Never `git` CLI.
- Push immediately after every change.
- Mentci three-tuple commit format:
  `(("CommitType", "scope"), ("Action", "what"), ("Verdict", "why"))`.
