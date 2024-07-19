##### Install directly as EFI entry

- Boot from Arch install USB
- Mount installed partition: `mount /dev/nvme0n1p5 /mnt`
- Mount boot partition (EFI): `mount /dev/nvme0n1p1 /mnt/boot`
- chroot with: `arch-chroot /mnt`
- Prepare EFI: `mkdir -p /boot/efi/EFI/Arch`
- Copy boot files to EFI:
  ```
  cp /boot/initramfs-linux-fallback.img /boot/EFI/Arch/
  cp /boot/initramfs-linux.img /boot/EFI/Arch/
  cp /boot/vmlinuz-linux /boot/EFI/Arch/
  ```
  efibootmgr --create --disk /dev/nvme0n1 --part 1 --label "Arch Linux" --loader '\EFI\Arch\vmlinuz-linux' --unicode 'root=UUID=aa4edddb-bb3e-4d76-b9c3-d87580204748 rw initrd=\EFI\Arch\initramfs-linux.img'
  ```
  (Partition UUID can be found with `lsblk -f`)
- Now you can boot from that EFI entry. Even put it as the first one with `efibootmgr -o`
