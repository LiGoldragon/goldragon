{
  description = "Goldragon cluster definition, Horizon composition, and Synchronizer configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    horizon = {
      url = "github:LiGoldragon/horizon-rs/a3ddaf8685b920093a2328b85ba350a04e11477a";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    horizon-config = {
      url = "github:LiGoldragon/criomos-horizon-config/74a4ad35f7a7";
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
            ${artifact.horizonCli}/bin/horizon-cli --node ouranos < ${artifact.horizonDefinitionPath} > ouranos.json
            ${pkgs.jq}/bin/jq -e '
              .node.fixedLocation == {
                latitude: 16.736944,
                longitude: -92.6375,
                altitude: 2121,
                accuracy: 1000
              }
            ' ouranos.json
            ${pkgs.jq}/bin/jq -e '
              [ .node, (.exNodes | to_entries[] | .value) ]
              | [ .[]
                  | select(.online != false)
                  | select(any(.capabilities[]?; .kind == "nixBuilder"))
                  | { name, maximum_jobs: ([.capabilities[] | select(.kind == "nixBuilder") | .maximum_jobs][0] // 1) }
                ]
              | sort_by(.name)
              == [
                { name: "prometheus", maximum_jobs: 8 }
              ]
            ' projection.json
            ${pkgs.jq}/bin/jq -e '
              .node.network.routerInterfaces.country == "MX"
              and (.node.capabilities | any(.kind == "tailnetClient" and .preauthKeyReference == "tailnetPreauthKeyPrometheus"))
              and (.exNodes.ouranos.capabilities | any(.kind == "tailnetController" and .tlsCertificateReference == "headscaleTlsCertificate" and .tlsKeyReference == "headscaleTlsKey"))
            ' projection.json
            ${pkgs.jq}/bin/jq -e '
              .node.maxJobs == 1 and .node.isRemoteNixBuilder == false
              and (.node.capabilities | any(.kind == "usbDownlink" and .ipv4Network == "10.44.0.0/24"))
              and (.node.builderConfigs | map(.hostName) == [ "prometheus.goldragon.criome" ])
              and (.node.builderConfigs[0].maxJobs == 8)
            ' ouranos.json
            grep -F 'ClusterRole.{ NixBuilder HorizonDefinition.' ${artifact.synchronizerConfiguration}
            grep -F '${artifact.horizonDefinitionPath}' ${artifact.synchronizerConfiguration}
            touch "$out"
          '';
          synchronizer = synchronizer.packages.${system}.default;
        }
      );
    };
}
