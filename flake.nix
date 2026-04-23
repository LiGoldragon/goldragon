{
  description = "goldragon — cluster proposal (production data for the LiGoldragon kriom)";

  outputs = _: {
    NodeProposal = import ./datom.nix;
  };
}
