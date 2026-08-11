{ pkgs }:

let
  unpacked = pkgs.stdenvNoCC.mkDerivation {
    pname = "chatgpt";
    version = "26.803.81509";

    src = pkgs.requireFile {
      name = "chatgpt_amd64.deb";
      sha256 = "qb+Ro2j598Tuo4CCqfuPtGuNAFtxmm13FdLloZgsOOs=";

      message = ''
        Download the official ChatGPT Linux .deb and add it to the Nix store:

          nix store add-file ~/Downloads/chatgpt_amd64.deb
      '';
    };

    nativeBuildInputs = [ pkgs.dpkg ];

    unpackPhase = ''
      dpkg-deb -x "$src" .
    '';

    installPhase = ''
      mkdir -p "$out"
      cp -a usr "$out/"
    '';
  };

  fhs = pkgs.buildFHSEnv {
    name = "chatgpt";

    targetPkgs =
      pkgs: with pkgs; [
        # Audio
        alsa-lib

        # GTK / graphics
        atk
        at-spi2-atk
        cairo
        gdk-pixbuf
        glib
        gtk3
        pango

        # Graphics / Electron
        libdrm
        libgbm
        mesa

        # Networking / TLS
        curl
        openssl
        nss
        nspr

        # Desktop / system
        dbus
        cups
        expat
        udev

        # X11
        libx11
        libxcomposite
        libxdamage
        libxext
        libxfixes
        libxrandr
        libxcb
        libxkbcommon

        # Wayland
        wayland

        # USB
        libusb1

        # Compression / misc
        zlib
      ];

    runScript = "${unpacked}/usr/lib/chatgpt/codex-launcher";
  };

in
pkgs.runCommand "chatgpt-${unpacked.version}" { } ''
  mkdir -p "$out/bin" "$out/share/applications" "$out/share/pixmaps"

  ln -s "${fhs}/bin/chatgpt" "$out/bin/chatgpt"
  cp "${unpacked}/usr/share/applications/chatgpt.desktop" \
    "$out/share/applications/chatgpt.desktop"
  cp "${unpacked}/usr/share/pixmaps/chatgpt.png" \
    "$out/share/pixmaps/chatgpt.png"
''
