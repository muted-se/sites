---
authors:
    - spixx
date: 2025-05-01
categories:
    - general
    - thoughts
    - linux
    - nerdery
---
While some might think  that creating anything more then the one `root` partition is unnecessarily obscure or obtuse, for me, a Linux installation is not complete without a carefully planned partition scheme. The benefits are several, first and foremost you protect yourself against a single stupid application logging to much and filling your entire drive with some spammed `syslog` message. Secondly there is some security benefits since you can deny specific actions from being available to a unprivileged user in the system via `others` writable areas. It also simplifies restoration when a system has had failures,or as in my case: I have yet again reinstalled the Operating system and need to now dump all my stuff back into the `/home/` directories.

The method we will use is to now break down the `what` and slowly work our way to the `why` and in the end we might end up understanding my train of thoughts in respect to why having several mount-points is a good thing.

<!-- more -->

## What
In most modern Desktop and Server Linux distributions today you will be allowed to partition your disk during installation, this is in essence a way to logically divide a hard-drive into smaller pieces with more narrow purposes. This allows us to split out the `/home` path so that it does not share storage with `/var/log` for instance. Using tools like `fdisk` you can both list and manipulate the partition table written to the early blocks of your storage medium. But since this is not 1990 you can also use more modern tooling such as LVM (or utilize cool filesystems like [ZFS](https://en.wikipedia.org/wiki/ZFS) or [BTRFS](https://en.wikipedia.org/wiki/Btrfs)) to instead create a virtual partition scheme. This is helpful since a [GPT](https://en.wikipedia.org/wiki/GUID_Partition_Table) or even [MBR](https://en.wikipedia.org/wiki/Master_boot_record) is not really flexible (you will still have a GPT scheme just that you will have only two or three partitions for `/boot`, `/boot/efi` and for the LVM).

> But wait! You think; this matters little on a laptop since the underlying drive will not change.

This is a correct thought to have but there is not really a good reason to overly allocate storage space either. A modest setup can get by with a very small footprint and the only real storage requirements might be the `/home` partition.

We will use my current laptop as a example of how it could be:

```
NAME                                          MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINTS
nvme0n1                                       259:0    0 238.5G  0 disk  
└─nvme0n1p1                                   259:1    0 238.5G  0 part  
  └─luks-00000000-0000-0000-0000-000000000000 253:0    0 238.5G  0 crypt 
    ├─vg0-root                                253:1    0     8G  0 lvm   /
    ├─vg0-swap                                253:2    0     4G  0 lvm   [SWAP]
    ├─vg0-usr                                 253:3    0    16G  0 lvm   /usr
    ├─vg0-var_lib_flatpak                     253:4    0    16G  0 lvm   /var/lib/flatpak
    ├─vg0-var_log_audit                       253:5    0     1G  0 lvm   /var/log/audit
    ├─vg0-var                                 253:6    0     4G  0 lvm   /var
    ├─vg0-tmp                                 253:7    0     4G  0 lvm   /tmp
    ├─vg0-var_log                             253:8    0     1G  0 lvm   /var/log
    ├─vg0-var_cache                           253:9    0     4G  0 lvm   /var/cache
    └─vg0-var_tmp                             253:10   0     4G  0 lvm   /var/tmp
nvme1n1                                       259:2    0 931.5G  0 disk  
├─nvme1n1p1                                   259:3    0     1G  0 part  /boot/efi
├─nvme1n1p2                                   259:4    0     1G  0 part  /boot
└─nvme1n1p3                                   259:5    0 929.5G  0 part  
  └─luks-00000000-0000-0000-0000-000000000000 253:11   0 929.5G  0 crypt 
    ├─vg1-opt                                 253:12   0    32G  0 lvm   /opt
    └─vg1-home                                253:13   0   512G  0 lvm   /home

```

Note here that I have two separate NVME drives (nvme0n1 and nvme1n1) which are used for Operating system related storage and storage for my personal data. Furthermore the above `lsblk` output tells us that I have a Encrypted partition and some un-encrypted partitions. This is what is called "encrypted LVM" which is basically three partitions, one for `/boot` (nvme1n1p1), one for `/boot/efi` (nvme1n1p2) and a third for a LUKS encrypted partition (nvme1n1p3) containing a Logical Volume Group. 

We can summarise this saying that we have three old-school partitions and inside of the encrypted third partition we have a Logical Volume Group containing our actual Operating system and personal files. We can also see that there are several logical volumes in both a `vg0` and `vg1`. Each mounted to a specific path in the Operating System (Flags always include defaults and noatime):

| Path             | Size   | Flags (fstab)       | Function                      |
| ---------------- | ------ | ------------------- | ----------------------------- |
| /                | 8 GiB  |                     | Root partition                |
| /usr             | 16 GiB |                     | System binaries and libraries |
| /var/lib/flatpak | 16 GiB | nosuid,nodev        | System flatpak storage        |
| /var/log/audit   | 1 GiB  | nosuid,nodev,noexec | Audit logs                    |
| /var             | 4 GiB  | nosuid,nodev        | Variable data                 |
| /var/log         | 1 GiB  | nosuid,nodev,noexec | System logs (syslog)          |
| /var/cache       | 4 GiB  | nosuid,nodev,noexec | Cached files                  |
| /var/tmp         | 4 GiB  | nosuid,nodev,noexec | Temporary Files               |
| /tmp             | 4 GiB  | nosuid,nodev,noexec | Temporary Files               |
| /opt             | 32 GiB | nosuid,nodev        | External packages             |
| Swap             | 4 GiB  |                     | System SWAP space             |
| /home            | X GiB  | nosuid,nodev        | User files and binaries       |
| /dev/shm         | N/A    | nosuid,nodev,noexec | Shared memory area            |
| /run             | N/A    | nosuid,nodev        | Runtime information           |
| /dev             | N/A    | nosuid,noexec       | Devices and pseudo devices    |
| /boot            | 1 GiB  | nosuid,nodev,noexec | Boot files                    |

If you look back at the output from `lsblk` you can see that I have used the larger drive to be in a Logical Volume Group named `vg1` and the smaller drive to be in `vg0` which separates the user-data further from the system data. You can also see my mistake in having (somewhat illogically) the `/boot` and `/boot/efi` on the second drive `¯\_(ツ)_/¯`.

## Why separating mount-points is good practice?
As mentioned in the ingress there are two major reasons to actually do this, first being able to add `noexec,nodev,nosuid` to mount-points to protect against malicious actors, secondly to prevent either user-mistakes or run-away issues from eating up all disk-space for the entire machine.

### Security and compliance benefits
The scheme adds the ability to follow the principles of least privileges by restricting certain types of actions within critical mount-points from being available. It also acts as a initial barrier to any malicious actor that has managed to get a foot-hold on the machine from easily escalating their privileges. There is also the issue of most individuals not understanding that having just one big mount-point for `root` leaves them vulnerable and the guides and setup of most operating systems does not inform of the risk and potential benefits of utilising this type of schema to separate their mount-points. There is also some security/compliance standards that require this to be the case, not only because they like to be draconian but because it is a way of removing low-hanging fruits from any attackers.

### Protection against mistakes and dumb stuff
The other major benefit is that you are now protected from a single log-file growing due to random reasons and filling your drive up. It might sound innocent but on a database server this can be catastrophic when it occurs. This type of knowledge comes from experiencing getting a notification during on-call that the drive is full and the subsequent head-scratching and curses this leads to.

### Risks are also a thing here
One thing to keep in mind is that using a lean mount-point schema you also is at risk of having allocated to little. In my templates there is usually 40 GiB of allocated storage for the defaults. Due to the flexible nature of LVM this is usually not an issue but if you are a bit cheap and allow only 512 MiB for your `/boot` you might be in a world of hurt when it comes time to expand a actual GPT partition.

## In conclusion
Using a somewhat over-complex/overcompensating partition and mount-point scheme brings many benefits and even if there are several draw-backs in the end having a basic hardening of the operating systems data-storage in place removes some of the venues that a attacker might utilise. This is not a guide since there are several things that requires consideration since the example here is for a Desktop rather then a Server. Still the complexity added is actually low unless you utilise Ubuntu since Canonical still leans on using partitions rather then LVM.

I did also ask Google's Gemini to fact-check me to ensure I am not just making things up as I go along;

> What reasons are there and what recommendations does exist for adding noexec,nodev or nosuid to mouint points in the FSTAB file in linux? Specify reasons for, what mount-points should have which flags and find good facts to back up this

Okay, let's break down the `noexec`, `nodev`, and `nosuid` mount options in Linux's `/etc/fstab` file. These options are primarily used for security hardening by restricting potentially dangerous actions on specific filesystems.  

**Understanding the Flags**

1. **`nosuid` (No Set User ID)**
    
    - **What it does:** Prevents Set-User-ID (SUID) and Set-Group-ID (SGID) bits from taking effect on executables within the mounted filesystem. Normally, an executable with the SUID bit set runs with the privileges of the file's owner (often `root`), not the user who executed it. SGID makes it run with the group privileges of the file's group.  
    - **Reason for use (Security):** This is a crucial security measure to prevent privilege escalation. If an attacker compromises a user account and manages to place or modify a SUID/SGID binary (especially one owned by `root`) on a partition mounted _without_ `nosuid`, they could execute it to gain elevated privileges (e.g., root access). Disabling SUID/SGID effectively neutralizes this common attack vector on partitions where users might have write access or where untrusted files could land.  
2. **`nodev` (No Devices)**
    
    - **What it does:** Prevents the interpretation of character or block special device files on the mounted filesystem. Device files (like `/dev/sda`, `/dev/random`, `/dev/mem`) provide interfaces to hardware or kernel functions.  
    - **Reason for use (Security):** Creating or accessing device files requires specific privileges, but if an attacker could somehow create a malicious device file (e.g., one pointing to raw disk memory) on a partition mounted _without_ `nodev`, they might be able to use it to bypass security controls, access sensitive data directly, or crash the system. This option prevents files on the partition from being treated as device interfaces.  
3. **`noexec` (No Execute)**
    
    - **What it does:** Prevents the direct execution of _binary_ executables residing on the mounted filesystem. The execute permission bits on files are ignored for binaries.
    - **Important Note:** This often _does not_ prevent the execution of scripts (like Shell, Python, Perl) if the interpreter itself resides on a partition mounted _with_ execute permissions (e.g., `/bin/bash`, `/usr/bin/python`). You could still run `sh /path/to/script.sh` even if `/path/to/` is on a `noexec` partition. However, it stops direct execution like `./myprogram`.
    - **Reason for use (Security):** This adds a layer of defense against malware execution. If an attacker manages to upload a malicious compiled program (binary) onto a partition mounted with `noexec` (like `/tmp`), they cannot directly run it from that location. They would need to move it to an executable partition first, which might be prevented by other controls.

**Recommendations: Which Flags on Which Mount Points?**

The general principle is **least privilege**: a filesystem should only be mounted with the capabilities necessary for its intended purpose.

Here are common recommendations, often found in security guides like the CIS Benchmarks:

1. **`/tmp`**
    
    - **Recommended Flags:** `defaults,nosuid,nodev,noexec`
    - **Rationale:** `/tmp` is world-writable and designed for temporary files. It's a prime target for attackers to store malicious scripts, binaries, device files, or SUID exploits. Disabling all three (`nosuid`, `nodev`, `noexec`) significantly hardens this volatile area. Legitimate applications generally don't need to execute binaries directly from `/tmp`, create devices there, or rely on SUID files within it. _Note: Some poorly written installers or applications might try to execute from `/tmp`, so `noexec` can occasionally cause compatibility issues, requiring investigation._
2. **`/var/tmp`**
    
    - **Recommended Flags:** `defaults,nosuid,nodev,noexec`
    - **Rationale:** Similar to `/tmp`, but often persists across reboots. The same security concerns apply, making it a target for dropped malware or exploit tools. The same hardening flags are strongly recommended.
3. **`/dev/shm` (Shared Memory)**
    
    - **Recommended Flags:** `defaults,nosuid,nodev,noexec`
    - **Rationale:** This is a `tmpfs` (RAM-based filesystem) used for POSIX shared memory. It's typically used for Inter-Process Communication (IPC), not for storing regular executables, device files, or SUID programs. Applying these flags prevents potential misuse of this memory-backed filesystem.  
        
4. **`/home` (If a separate partition)**
    
    - **Recommended Flags:** `defaults,nodev,nosuid` (`noexec` is often _not_ recommended here)
    - **Rationale:**
        - `nodev`: Users should generally never need to create device files within their home directories. Enabling `nodev` prevents potential misuse.
        - `nosuid`: Prevents users from introducing SUID/SGID binaries into their home directories (or having downloaded malware gain root via SUID if placed there). This is a significant security benefit on multi-user systems.
        - `noexec`: This is _controversial and often problematic_ for `/home`. Users often need to execute scripts or compile and run legitimate software within their home directories. Applying `noexec` breaks this common workflow and can cause major usability issues. It's generally only used in very high-security, restricted environments.
5. **Removable Media (USB drives, external HDDs - often handled by `udisks` or automounters, not static fstab)**  
    
    - **Recommended Flags (if manually configured or via udev rules):** `noexec,nosuid,nodev,nofail,user` (or `users`)
    - **Rationale:** External media is inherently untrusted. It could contain malware, SUID exploits, or malicious device files. Applying all three restrictions significantly reduces the risk when mounting unknown devices. `nofail` prevents boot issues if the device isn't present, and `user`/`users` allows regular users to mount/unmount.
6. **`/boot` (If a separate partition)**
    
    - **Recommended Flags:** `defaults,nosuid,nodev,noexec` (Optional but good practice)
    - **Rationale:** Contains the kernel, initramfs, and bootloader config. No execution, device files, or SUID binaries should ever be needed here during normal operation. Adding these flags adds a minor layer of integrity protection, although write access is usually restricted to root anyway.
7. **`/`, `/usr`, `/var` (excluding `/var/tmp`), `/opt`**
    
    - **Recommended Flags:** `defaults` (Generally _do not_ add `noexec`, `nodev`, `nosuid`)
    - **Rationale:** These partitions contain the core operating system, essential system binaries (many requiring `exec`), libraries, potentially legitimate SUID binaries (like `passwd`, `sudo`, `ping`), and system data. Applying `noexec` or `nosuid` here would break the system fundamentally. `nodev` is usually unnecessary as device creation is typically restricted to `/dev`.

**Facts and Justification**

- **Defense in Depth:** These options provide additional security layers. Even if one control fails (e.g., an application vulnerability allows file upload), `noexec` or `nosuid` might prevent the subsequent exploitation or privilege escalation step.
- **Principle of Least Privilege:** Filesystems should only grant the minimum necessary permissions. If execution isn't needed (`/tmp`), don't allow it. If device nodes aren't needed (`/home`), disable them.
- **Compliance and Benchmarks:** Security standards like the CIS (Center for Internet Security) Benchmarks for various Linux distributions explicitly recommend using `nosuid`, `nodev`, and `noexec` on partitions like `/tmp`, `/var/tmp`, and `/dev/shm`. They often recommend `nodev` and `nosuid` for `/home` as well. Following these benchmarks is common practice in security-conscious environments.
- **Preventing Common Attack Vectors:** Exploits often rely on writing to world-writable areas like `/tmp` and then executing code or using SUID binaries from there. These flags directly counter such common techniques.
