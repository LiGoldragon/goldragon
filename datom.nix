{
  nodes = {
    balboa = {
      species = "center";
      machine = {
        species = "metal";
        arch = "arm64";
        model = "rock64";
        cores = 4;
      };
      preCriomes = {
        ssh = "AAAAC3NzaC1lZDI1NTE5AAAAIPvxPTAPPKe6Ne9MW4C04Ihe0g4NS12xydci/JW59pIe";
      };
      io = {
        disks = {
          "/" = {
            device = "/dev/disk/by-label/NIXOS_SD";
            fsType = "ext4";
          };
        };
      };
    };

    tiger = {
      species = "edgeTesting";
      size = 3;
      trust = 3;
      machine = {
        species = "metal";
        arch = "x86-64";
        model = "ThinkPadE15Gen2Intel";
        cores = 4;
      };
      nodeIp = "5::4/128";
      linkLocalIps = [ ];
      io = {
        keyboard = "colemak";
        bootloader = "uefi";
        disks = {
          "/" = {
            device = "/dev/disk/by-uuid/158a5a78-3dbc-4c80-99b6-96e433bd836a";
            fsType = "ext4";
          };
          "/boot" = {
            device = "/dev/disk/by-uuid/50F3-9E04";
            fsType = "vfat";
          };
        };
        swapDevices = [ { device = "/dev/disk/by-uuid/4dcf2ad2-4677-483f-9900-046f0f53053a"; } ];
      };
      preCriomes = {
        nixPreCriome = "/1SYuET5/IIscPvZcgZyrfsMcRiCFcmV051+0U5YXVM=";
        nixSigningPublicKey = "/1SYuET5/IIscPvZcgZyrfsMcRiCFcmV051+0U5YXVM=";
        ssh = "AAAAC3NzaC1lZDI1NTE5AAAAIKeoCIfvbUDue17FBglmKF1N2cKH9CWsS5EcXOyBxq5T";
        yggdrasil = {
          preCriome = "38ed4c7c9ffd2e79361af3202f406810069fa37ff991e6d1d434a529ba75dfb3";
          address = "202:3895:9c1b:16:8c36:4f28:66fe:85fc";
          subnet = "302:3895:9c1b:16";
        };
      };
    };

    xerxes = {
      species = "hybrid";
      size = 3;
      trust = 3;
      machine = {
        species = "metal";
        arch = "x86-64";
        model = "ThinkPadX240";
        cores = 2;
      };
      nodeIp = "5::1/128";
      linkLocalIps = [
        {
          species = "ethernet";
          suffix = "aec6:ecad:34e0:b41f";
        }
      ];
      wireguardPreCriome = "oOeqiGZC+oaIL0rKirFyiJ4N6qDQWICZ2wRelLMOR0o=";
      io = {
        keyboard = "colemak";
        bootloader = "uefi";
        disks = {
          "/" = {
            device = "/dev/disk/by-uuid/c5788e39-39da-41f1-9f6c-4137abb0c406";
            fsType = "btrfs";
            options = [ "subvol=__active/root" ];
          };
          "/nix" = {
            device = "/dev/disk/by-uuid/c5788e39-39da-41f1-9f6c-4137abb0c406";
            fsType = "btrfs";
            options = [ "subvol=__active/nix" ];
          };
          "/home" = {
            device = "/dev/disk/by-uuid/c5788e39-39da-41f1-9f6c-4137abb0c406";
            fsType = "btrfs";
            options = [ "subvol=__active/home" ];
          };
          "/var" = {
            device = "/dev/disk/by-uuid/c5788e39-39da-41f1-9f6c-4137abb0c406";
            fsType = "btrfs";
            options = [ "subvol=__active/var" ];
          };
          "/boot" = {
            device = "/dev/disk/by-uuid/0A84-F61D";
            fsType = "vfat";
          };
        };
        swapDevices = [
          { device = "/dev/disk/by-uuid/03a014a2-9d6c-4c8e-b4be-b01415ad1beb"; }
        ];
      };
      preCriomes = {
        ssh = "AAAAC3NzaC1lZDI1NTE5AAAAIE172GOItdwxQwJhnVeaSuHIwYrcj5bENafKL9y/mKZX";
        nixPreCriome = "AAqjPi1kOaOWyZrwupTpHNL/7SYjYmaeDu1J+hNtVFA=";
        nixSigningPublicKey = "AAqjPi1kOaOWyZrwupTpHNL/7SYjYmaeDu1J+hNtVFA=";
        yggdrasil = {
          preCriome = "2748bfce76cf7c2a8d6d73241fadd4cad2a32f631df6a4be4bfb33969b0490e0";
          address = "202:c5ba:18c:4984:1eab:9494:66df:291";
          subnet = "302:c5ba:18c:4984";
        };
      };
    };

    zeus = {
      species = "edge";
      size = 3;
      trust = 3;
      machine = {
        species = "metal";
        arch = "x86-64";
        model = "ThinkPadT14Gen2Intel";
        cores = 4;
      };
      linkLocalIps = [ ];
      io = {
        keyboard = "colemak";
        bootloader = "uefi";
        disks = {
          "/" = {
            device = "/dev/disk/by-uuid/4bd0cbe7-082d-4f06-9283-978b834a85db";
            fsType = "ext4";
          };
          "/boot" = {
            device = "/dev/disk/by-uuid/1491-B84C";
            fsType = "vfat";
            options = [
              "fmask=0022"
              "dmask=0022"
            ];
          };
        };
        swapDevices = [ ];
      };
      preCriomes = {
        ssh = "AAAAC3NzaC1lZDI1NTE5AAAAIMAZxp1YpShbxSy1/Khu4wc57o+yWyuMh/80+dKHg6TW";
        yggdrasil = {
          preCriome = "f40458290d7a2d79efdbef4b5f046fb7f825626eda9d118e4f2b869c105f6ec4";
          address = "200:17f7:4fad:e50b:a50c:2048:2169:41f7";
          subnet = "300:17f7:4fad:e50b";
        };
      };
    };

    ouranos = {
      species = "edgeTesting";
      size = 3;
      trust = 3;
      nordvpn = true;
      machine = {
        species = "metal";
        arch = "x86-64";
        model = "ThinkPadT14Gen5Intel";
        cores = 12;
      };
      nodeIp = "5::3/128";
      linkLocalIps = [ ];
      io = {
        keyboard = "colemak";
        bootloader = "uefi";
        disks = {
          "/" = {
            device = "/dev/disk/by-uuid/38a88e99-3b6e-4de6-9772-05adddc3a1ca";
            fsType = "ext4";
          };
          "/boot" = {
            device = "/dev/disk/by-uuid/725A-E86A";
            fsType = "vfat";
            options = [
              "fmask=0022"
              "dmask=0022"
            ];
          };
        };
        swapDevices = [ ];
      };
      preCriomes = {
        ssh = "AAAAC3NzaC1lZDI1NTE5AAAAIP/v8LZFBXHMzflegvnHEgi6EyDn8P5i//iGjboVjtRr";
        nixPreCriome = "AAqjPi1kOaOWyZrwupTpHNL/7SYjYmaeDu1J+hNtVFA=";
        nixSigningPublicKey = "AAqjPi1kOaOWyZrwupTpHNL/7SYjYmaeDu1J+hNtVFA=";
        yggdrasil = {
          preCriome = "6487aabfe0d4f491a2986f4b41388ebcbd3c69a654f32feb9b1fba351bbd590a";
          address = "201:6de1:5500:7cac:2db9:759e:42d2:fb1d";
          subnet = "301:6de1:5500:7cac";
        };
      };
    };

    prometheus = {
      species = "largeAI-router";
      size = 3;
      trust = 3;
      machine = {
        species = "metal";
        arch = "x86-64";
        model = "GMKtec EVO-X2";
        cores = 8;
      };
      nodeIp = "5::5/128";
      preCriomes = {
        yggdrasil = {
          preCriome = "de749c6fe90c14d5d843e5cb0eec4674e96b66d0b8b68866887c27a85d58cb7c9adf4a76f8229421981cdaaaf4d0177a57119eee5848499eaa9e0fdf107363cf";
          address = "200:ca41:6b12:fba:d7bc:cfc6:4aaa:165f";
          subnet = "300:ca41:6b12:fba";
        };
      };
      io = {
        bootloader = "uefi";
        disks = {
          "/" = {
            device = "/dev/disk/by-uuid/d3ad7f53-2470-4744-9ddf-b183c7c22f31";
            fsType = "btrfs";
            options = [ "subvol=root" ];
          };
          "/home" = {
            device = "/dev/disk/by-uuid/d3ad7f53-2470-4744-9ddf-b183c7c22f31";
            fsType = "btrfs";
            options = [ "subvol=home" ];
          };
          "/nix" = {
            device = "/dev/disk/by-uuid/d3ad7f53-2470-4744-9ddf-b183c7c22f31";
            fsType = "btrfs";
            options = [ "subvol=nix" ];
          };
          "/var" = {
            device = "/dev/disk/by-uuid/d3ad7f53-2470-4744-9ddf-b183c7c22f31";
            fsType = "btrfs";
            options = [ "subvol=var" ];
          };
          "/boot" = {
            device = "/dev/disk/by-uuid/A252-A02B";
            fsType = "vfat";
          };
        };
        swapDevices = [ ];
      };
    };

    klio = {
      species = "edge";
      size = 3;
      trust = 2;
      machine = {
        species = "metal";
        arch = "x86-64";
        model = "ThinkPadX250";
        cores = 2;
      };
      nodeIp = "5::2/128";
      io = {
        keyboard = "colemak";
        bootloader = "uefi";
        disks = {
          "/" = {
            device = "/dev/disk/by-uuid/ac609ecf-be8e-49ee-a892-2552e74d97e3";
            fsType = "ext4";
          };
          "/boot" = {
            device = "/dev/disk/by-uuid/BBE9-75C7";
            fsType = "vfat";
          };
        };
        swapDevices = [ { device = "/dev/disk/by-uuid/f86fc799-cbc2-473b-94ce-abfc1aa040f2"; } ];
      };
      preCriomes = {
        ssh = "AAAAC3NzaC1lZDI1NTE5AAAAID7E6ca/f2Bkz5Z9ZX4ASHXPLF7TYI/Z4C0/Is/Ljpyu";
        nixPreCriome = "7N3PTqwWdA0p4XNjupKhLhVD5D0cEFcY/mUk3FRo5lI=";
        nixSigningPublicKey = "7N3PTqwWdA0p4XNjupKhLhVD5D0cEFcY/mUk3FRo5lI=";
        yggdrasil = {
          preCriome = "cef05ea020845caf73f2b3b3c15d27e3d55dd35b5155692a5464b7920b6b03b9";
          address = "200:621f:42bf:bef7:46a1:181a:9898:7d45";
          subnet = "300:621f:42bf:bef7";
        };
      };
    };

    asklepios = {
      species = "hybrid";
      size = 1;
      trust = 3;
      machine = {
        species = "metal";
        arch = "x86-64";
        model = "all-x86-64";
        cores = 1;
      };
      preCriomes = {
        ssh = "AAAAC3NzaC1lZDI1NTE5AAAAIHEtxRF2wjSD1DzlYCW9BivOsz9X0P95msrbXvGATy/p";
      };
    };

    eibetik = {
      species = "center";
      size = 1;
      trust = 2;
      machine = {
        species = "pod";
        superNode = "xerxes";
        superUser = "li";
        cores = 1;
      };
    };
  };

  users = {
    li = {
      species = "unlimited";
      size = 3;
      keyboard = "colemak";
      githubId = "LiGoldragon";
      preCriomes = {
        zeus = {
          ssh = "AAAAC3NzaC1lZDI1NTE5AAAAIII6G7yMqNXJSuHDlH8R2JRSLSM6sZZLULaK8yDzquwO";
          keygrip = "CEEA0DD02CA901E5F71A8CB3EB5C5EB902AA210E";
        };
        tiger = {
          ssh = "AAAAC3NzaC1lZDI1NTE5AAAAILTm644m4foET1j+DGHl0gfEyGD9A4YltsNOidDUn3BG";
          keygrip = "1785B4D2813D7ED1913A05FA74FF42B9153EEFF0";
        };
        ouranos = {
          ssh = "AAAAC3NzaC1lZDI1NTE5AAAAIHEtxRF2wjSD1DzlYCW9BivOsz9X0P95msrbXvGATy/p";
          keygrip = "7FAFE190D2C749B222B249E54E5A7AD71C1BDDBD";
        };
        xerxes = {
          ssh = "AAAAC3NzaC1lZDI1NTE5AAAAICiHPTciuu3Yn8my604bWPo+T/9cIIMOqbrzPjqAt88/";
          keygrip = "DE688BEA4BAC3595A263EC1B76373B7C275899D9";
        };
      };
    };

    bird = {
      species = "multimedia";
      size = 3;
      keyboard = "colemak";
      preCriomes = {
        klio = {
          ssh = "AAAAC3NzaC1lZDI1NTE5AAAAIK4NC1v3l3Q55Bue6aorvvAB/WoTEdeJXJfwZbxKAwbu";
          keygrip = "45D28CE63EFE23CB5FB9C093786C73450ECD3384";
        };
        tiger = {
          ssh = "AAAAC3NzaC1lZDI1NTE5AAAAIGhaPt/4ytqbJ9oPk5DE5WEK23N36pZRbvaEuqr/MtfF";
          keygrip = "943502A0A9D25EF34C16E2ED2A120C26279C4248";
        };
        zeus = {
          ssh = "AAAAC3NzaC1lZDI1NTE5AAAAIMioAruS5HbgT8hUOVAgKKUP0P6s4gXliVb+AcrtWr4V";
          keygrip = "962157586FC998370969F675812FE1EBBD9CF8DA";
        };
      };
    };

    maikro = {
      species = "code";
      size = 1;
      keyboard = "colemak";
      preCriomes = {
        xerxes = {
          ssh = "AAAAC3NzaC1lZDI1NTE5AAAAIEygb1Ft1hIB+ExPGLq08im9rFYvOeYXX+NetgqjI3Db";
          keygrip = "63A149ECC539BAF2B001C57E9A55A566BCD48446";
        };
      };

    };
  };

  domains = { };

  trust = {
    cluster = 3;
    clusters = { };
    nodes = {
      balboa = 3;
      xerxes = 3;
      zeus = 3;
      ouranos = 3;
      prometheus = 3;
      asklepios = 3;
      eibetik = 2;
      tiger = 3;
    };
    users = {
      maikro = 3;
      li = 3;
      bird = 2;
    };
  };
}
