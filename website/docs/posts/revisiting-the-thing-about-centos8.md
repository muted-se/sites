---
authors:
    - spixx
date: 2023-08-24
categories:
    - general
    - thoughts
---

# Revisiting the thing about CentOS 8 #
So during this year Redhat (IBM) has figured they should further complicate 
their relationship with their community. This time it is not actually about 
CentOS directly but rather an attempt to prevent the likes of Alma/Rocky/Oracle
to use their sources as a way to repackage as their own. The way they opted to 
go was to move the source code behind a end user license agreement, so only 
paying customers and partners have access to the source code. A whole lot of 
bricks were shat this time.

<!-- more -->

## So what? ##
This time it is a bit harder to actually defend the actions taken, they are not
following the spirit of Open Source licensing but rather the letter. By moving 
the source code away from any public repository and allowing for only signed up
entities they very efficiently close down this avenue to repackage the full
release. This has been very well written up [by](https://www.jeffgeerling.com/blog/2023/im-done-red-hat-enterprise-linux) 
[several](https://latenightlinux.com/late-night-linux-episode-236/) smart 
individuals so please read/listen to what their thoughts are on this.

## So? ##
This time it is rather bad, not only did they perform a penile move but they
also did just lock away many future potential users for some short-sighted 
gains. To exemplify I have been a hardcore CentOS user, when I started working
in enterprise environments the effort to working with a RHEL server was near
zero. But for all new system administrators, developers and enthusiasts there 
is no options left. So instead the next generations will be using other 
distributions.

## What are the alternatives ##
So clearly there is now many caveats with utilising any code released by Redhat
that is not directly licensed by them to you. There is still the developer 
license available but if they can yank a fully working distribution mid-cycle 
they can change those terms at a moments notice. For the near future I will stay 
on Stream-9.

> Linux enki 6.1.0-11-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.38-4 (2023-08-08) x86_64 GNU/Linux

In the future I will migrate over to Debian fully (my desktop uname above as 
proof), but due to the sheer amount of time put into the Ansible automation I 
currently sport it is a long time before I will be able to make the switch.
Debian is not only a strong community driven distribution, it is also not as
susceptible to being overtaken like CentOS proved to be. There are other 
alternatives with similar community driven projects like [archlinux](https://archlinux.org/)
and [voidlinux](https://voidlinux.org/) to name two. For servers some 
stability is required so the above might be fun to use on the desktop but not 
for hosting applications. My main line of thought is to keep away from any 
company owned distribution (like Ubuntu, Oracle Linux and SUSE).
