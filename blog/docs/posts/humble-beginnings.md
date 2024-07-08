---
authors:
    - spixx
date: 2020-11-06
categories:
    - general
    - thoughts
---

# Humble beginnings #

This post will be the first in a series of articles and how to guides that will
chronicle my virtual datacenter setup. This first post will walk you through 
the platform I will utilize and discuss a bit about how it is designed and 
setup.

<!-- more -->

## The hardware ##
### Requirements ###

There were several requirements for the hardware that was important to fulfill. 
First of all it had to be both compact, quiet and not to obtrusive. This was 
due to the restrictive location of the server, which is in my home-office. The 
second requirement was that the server should have a shelf-life of at least 5 
years and utilize as much of my existing hardware as possible. Mainly to save 
money and make use of hardware wasting away on my shelfs. Thirdly the server 
will be utilized as a virtualization host, which does require some “umphf” 
when it comes to hardware. Since the server would be hosting a virtual 
environment for many years to come.

### Components ###
| Component     | Choice                                                      |
|---------------|-------------------------------------------------------------| 
| Motherboard   | Asrock Rack EP2C602 SSI                                     |
| Chassi        | Enthoo Pro White SSI EEB fulltower                          |
| Processor	    | 2x Intel E5-2690v2 10 core 2,9GHz                           |
| Memory        | 8x 16GB ECC DDR3 1866MHz                                    |
| OS Drive      | 2x Kingston 120GB                                           |
| HDD           | 4x 4TB Western Digital Green                                |
| SSD           | 1x 1TB Corsair Force MP510                                  |
| SSD           | 2x 1TB Western Digital Blue                                 |
| Power supply  | Corsair HX1000 V2 1000W                                     |
| Graphics Card | ASUS ROG Strix Radeon RX 5700 XT 8GB                        |

### Reasoning ###

There is a very large market of cheap second-hand processors online and mostly 
they are of good quality. They are also plentiful and one can buy a high-end 
processor for a tenth of the original pricing. This does require some rather 
expensive hardware around it but memory for older servers is also easy to find 
and cheap to buy. There were two things that are a bit outside of the box, 
first the Graphics card. The reason behind buying this was that my aim is to 
have a virtual Desktop with PCI-E passthrough so that I can utilize it for 
gaming. The second thing is the motherboard which I actually bought new 
instead of second-hand.

### Software ###

The next step is to find a good candidate to host the virtual machines on the 
hardware. My choice fell on Proxmox mostly due to the simple interface, easy 
installation and feature-rich web GUI.

There are several other choices like VMware and HyperV which are aimed at a 
server rather then for instance Virtualbox and VMware Workstation who are aimed
at desktops. In the end Proxmox became quite obvious as a choice since it is 
both flexible since I can actually utilize a terminal and work directly on a 
well-known Operating system (Debian 10). Furthermore it has a very good UI that
is capable of configuring both the host operating system and the virtual 
machines.

In the next article I will go more into depth on the configuration of the 
proxmox and the logical diagram of the virtual networks and servers within.
