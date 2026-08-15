# Minimal NixOS ISO installation

This flake installs a pure Wayland Niri + DankMaterialShell desktop. It does not enable Plasma, SDDM, or the X11 server. Older X11 applications run through xwayland-satellite.

## 1. Boot and connect

Boot the NixOS minimal ISO. For Wi-Fi:

```bash
sudo systemctl start NetworkManager
nmtui
```

## 2. Partition and mount the target

Partition the new disk for EFI, root, and optional swap using your preferred tool. Mount the target root at `/mnt` and its EFI system partition at `/mnt/boot`. Confirm with `lsblk -f` before continuing.

Generate hardware configuration:

```bash
sudo nixos-generate-config --root /mnt
```

## 3. Mount the Sauce drive

Find it with `lsblk -f`, then:

```bash
sudo mkdir -p /mnt/sauce
sudo mount /dev/disk/by-label/Sauce /mnt/sauce
cd /mnt/sauce/NixOS-Migration-2026-08-15
sha256sum -c SHA256SUMS
```

## 4. Restore the flake into the target system

```bash
sudo mkdir -p /mnt/home/joey
sudo tar -xzf nixos-working-tree.tar.gz -C /mnt/home/joey
sudo cp /mnt/etc/nixos/hardware-configuration.nix /mnt/home/joey/nixos/hardware-configuration.nix
sudo mkdir -p /mnt/home/joey/Downloads
sudo cp chatgpt_amd64.deb /mnt/home/joey/Downloads/
```

The generated hardware file from the NEW laptop must replace the backed-up Lenovo file, as shown above.

Add the local ChatGPT package to the target Nix store:

```bash
sudo nix store --store /mnt add --mode flat --name chatgpt_amd64.deb /mnt/home/joey/Downloads/chatgpt_amd64.deb
```

## 5. Install

```bash
sudo nixos-install --flake /mnt/home/joey/nixos#nixos
```

Fix ownership of the restored working tree and set Joey's password before rebooting:

```bash
sudo nixos-enter --root /mnt -c 'chown -R joey:users /home/joey'
sudo nixos-enter --root /mnt -c 'passwd joey'
```

Then reboot. Tuigreet appears on tty1; log in and it launches Niri.

## 6. Restore home configs after the first login

Mount the Sauce drive, enter the migration directory, and run as Joey:

```bash
bash restore-home.sh
```

Reboot or log out and back in afterward. This restores Zsh, tmux/TPM, scripts, SSH, Ghostty, Niri, DMS, and related configs. Existing conflicts receive numbered backups.

## New-laptop checks

After boot, check Wi-Fi, graphics, audio, suspend, brightness keys, Bluetooth, webcam, and fingerprint hardware. The EasyEffects preset is associated with the old Lenovo speaker node and will not autoload on unrelated speakers. Tune a new profile only after identifying the new audio device.
