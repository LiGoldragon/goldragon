{
  description = "Goldragon cluster definition, Horizon composition, and Synchronizer configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    horizon = {
      url = "github:LiGoldragon/horizon/05879e7c1e5f637f78fbe26234b95213c77c59bc";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    horizon-config = {
      url = "github:LiGoldragon/criomos-horizon-config/7050afef14bcfe649c0d05bdaa681d1577cafc46";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    synchronizer = {
      url = "github:LiGoldragon/synchronizer/b42c9df295adccdd65381f8bd444147099036183";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, nixpkgs, horizon, horizon-config, synchronizer, ... }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" ];
      forSystems = nixpkgs.lib.genAttrs systems;
      artifacts = system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          horizonDefinition = horizon-config.lib.composeHorizonDefinition {
            inherit system;
            horizonCompose = horizon.packages.${system}.horizon-compose;
            configuration = "${horizon-config}/horizon-configuration.datom";
            cluster = ./cluster-definition.datom;
          };
          horizonDefinitionPath = horizon-config.lib.horizonDefinitionPath horizonDefinition;
          synchronizerConfiguration = pkgs.runCommand "goldragon-synchronizer.datom" { } ''
            substitute ${./synchronizer.datomic} "$out" \
              --replace-fail '@horizon-definition@' '${horizonDefinitionPath}'
          '';
        in
        {
          inherit horizonDefinition horizonDefinitionPath synchronizerConfiguration;
          horizonCli = horizon.packages.${system}.default;
        };
    in
    {
      packages = forSystems (
        system:
        let artifact = artifacts system;
        in {
          default = artifact.horizonDefinition;
          horizon-definition = artifact.horizonDefinition;
          horizon-cli = artifact.horizonCli;
          synchronizer-configuration = artifact.synchronizerConfiguration;
        }
      );

      checks = forSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          artifact = artifacts system;
        in {
          horizon-definition = artifact.horizonDefinition;
          synchronizer-configuration = pkgs.runCommand "goldragon-synchronizer-configuration-check" {
            nativeBuildInputs = [ artifact.horizonCli pkgs.jq pkgs.gnugrep ];
          } ''
            test -s ${artifact.horizonDefinitionPath}
            ${artifact.horizonCli}/bin/horizon-cli --node prometheus < ${artifact.horizonDefinitionPath} > projection.json
            ${pkgs.jq}/bin/jq -e '
              [ .node, (.exNodes | to_entries[] | .value) ]
              | [ .[]
                  | select(.online != false)
                  | select(any(.capabilities[]?; .kind == "nixBuilder"))
                  | { name, maximum_jobs: ([.capabilities[] | select(.kind == "nixBuilder") | .maximum_jobs][0] // 1) }
                ]
              | sort_by(.name)
              == [
                { name: "ouranos", maximum_jobs: 1 },
                { name: "prometheus", maximum_jobs: 6 }
              ]
            ' projection.json
            grep -F 'ClusterRole.{ NixBuilder HorizonDefinition.' ${artifact.synchronizerConfiguration}
            grep -F '${artifact.horizonDefinitionPath}' ${artifact.synchronizerConfiguration}
            touch "$out"
          '';
          synchronizer = synchronizer.packages.${system}.default;
        }
      );
    };
}
