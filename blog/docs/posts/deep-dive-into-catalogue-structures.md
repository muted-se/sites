---
authors:
    - spixx
date: 2024-07-04
categories:
    - general
    - thoughts
    - linux
    - deep-dive
    - folders
    - structure
---

# Deep dive into catalogue structures #
To start out lets just get one thing out of the way; what is written here is
not in any strong sense of the word a common standard. It is rather what my
experience has been when it comes to the ideal way of handling the filesystem
and harddrive mount-points in Linux. It is loosely based on the now defunct NSA
guide to hardening CentOS/RHEL but the [wayback machine](https://web.archive.org/web/20140404154830/https://www.nsa.gov/ia/_files/os/redhat/NSA_RHEL_5_GUIDE_v4.2.pdf)
has a copy of the now very old PDF.

<!-- more -->
## Mount-points ##

| Mount point      | Size     | Comment                                       |
|------------------|----------|-----------------------------------------------|
| /                | 8GB      | Root partition                                |
| /tmp             | 4GB      | Temporary files                               |
| /usr             | 16GB     | Binaries and libraries                        |
| /var             | 4GB      | System variable files                         |
| /var/tmp         | 4GB      | Temporary files                               |
| /var/log         | 1GB      | Logfiles                                      |
| /var/log/audit   | 512M     | Audit logfile                                 |
| /var/lib/flatpak | 16GB     | Flatpak binaries                              |
| /opt             | 1GB      | Optional files (used forinstance by Chrome)   |
| /boot            | 1GB      | Boot files                                    |
| /boot/efi        | 1GB      | UEFI boot files                               |
| /home            | 1GB      | Home with user files                          |
| swap             | XGB      | Swap file, can be `0` or equal to the RAM size|
