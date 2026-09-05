# goldragon — architecture

`goldragon` is public, pure cluster data. `cluster-definition.datom` is its
only substantive public Horizon artifact. It contains cluster-local facts and
an explicit list of selected generic node names; it does not duplicate the
generic catalogue.

The independent `criomos-horizon-config` flake owns
`HorizonConfiguration`. A caller supplies pinned paths for that configuration
and this cluster definition to its parameterized typed composition derivation.
The result is a directory whose canonical `horizon-definition.datom` child is
the only public proposal document admitted by Lojix.

The repository holds encrypted references under `secrets/`; no secret content
enters `cluster-definition.datom`, the composed document, or Nix outputs.

The Synchronizer configuration uses its explicit `DirectHost.prometheus`
strategy. It no longer parses an obsolete Horizon proposal from this repository.
