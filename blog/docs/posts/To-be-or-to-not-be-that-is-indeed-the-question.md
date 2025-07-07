---
authors:
    - spixx
date: 2025-07-01
categories:
    - general
    - thoughts
    - linux
---

A while ago there was a strange thing occurring with the CentOS project, for some reason they changed their planned end-of-life date for their release of CentOS 8. Since many utilised this as their main Operating System many butts where hurt and there was much gnashing of teeth. You, dear reader, should not forget that they were complaining about the fact that a free (as in beer) resource were being taken away from them. This was of course a move that Redhat made attempting to make freeloaders buy licenses for their Redhat Enterprise Linux (RHEL). CentOS did not leave anyone hanging though but instead of the slow cadence of CentOS they now provide CentOS stream which is a rolling release (IE no 8.1, 8.2 and so on).

I know this is a bit of an history lesson but I will get to the point of why I think it is good to get rug-pulled every so often within the field of IT.
<!-- more -->

## The issue with removing a stable release in lieu of a rolling release
Many built their applications upon the versioned releases, which did make them come to a grinding halt when suddenly the target OS had no versioning locks and thus became that much harder to support. Others had come to expect that CentOS releases would keep for eight years and be the bastion of the data-center. Maybe the worst was for those who had started the sometimes complex and cumbersome task of moving onto the already released CentOS 8.1.

### Others step forward to fill the void
Luckily there were others who stepped forward; SUSE for instance and Oracle among others. Scrambling for the confused and scared masses who Redhat just abandoned. Although Oracle is mentioned here more ironically than anything else. If the risk is vendor lock-in they should be feared since they are known to be very aggressive on this front. Either way some good alternatives are available, such as [Debian](https://www.debian.org/index.sv.html), [Rocky Linux](https://rockylinux.org/) and Redhat RHEL (which released free licenses for developers).

### So in what way is the rug-pulling a positive?
Since I do a lot of lurking in the IRC channel it is quite obvious that people have a tendency to keep the status quo unless forced to change. Some ask for support on outdated or even unsupported versions of the operating system. Many do not even dare to upgrade their infrastructure because “it might break”. This indicates a failure of the people not the product. If your application is written so that you have no other choice then utilise a plus four year old version of an operating system then your money might have been better spent elsewhere. I am not excusing what Redhat did here, they (or the CentOS board) had made a promise to support l CentOS 8.X until end of 2029. My point here is that we are now forced to a steady renewal of our baseline operating system. If you have not had the foresight of having a testing environment now is a good time to set something up. CICD is not only for developers but for everyone and there are several good products out there that can assist in getting started with some type of automation. [Proxmox VE](https://pve.proxmox.com/) for free virtualization (Debian), [Ansible](https://www.ansible.com/) for configuration management and [Jenkins](https://www.jenkins.io/) for pipelines just to name a few. There will be more guides on how to get started with automation and testing of infrastructure in the future. In the end it is a positive that change is being forced upon any holdouts. The older ways are dying faster and faster and with the dawn of the LLM this has been accelerated ever further.

## Redhat then decided to further complicate the situation
Redhat (IBM) has figured they should further complicate their relationship with their community. By preventing the likes of Alma/Rocky/Oracle to use their sources as a way to repackage as their own. The way they opted to go was to move the source code behind a end user license agreement, so only paying customers and partners have access to the source code. A whole lot of bricks were shat this time.

### So what?
This time it is a bit harder to actually defend the actions taken, they are not following the spirit of Open Source licensing but rather the letter. By moving the source code away from any public repository and allowing for only signed up entities they very efficiently close down this avenue to repackage the full release. This has been very well written up [by](https://www.jeffgeerling.com/blog/2023/im-done-red-hat-enterprise-linux) [several](https://latenightlinux.com/late-night-linux-episode-236/) smart individuals so please read/listen to what their thoughts are on this.

### So why is this a bigger issue then the rug-pull?
This time it is rather bad, not only did they perform a penile move but they also did just lock away many future potential users for some short-sighted gains. To exemplify I have been a hardcore CentOS user, when I started working in enterprise environments the effort to working with a RHEL server was near zero. But for all new system administrators, developers and enthusiasts there is no options left. So instead the next generations will be using other distributions.

### What are the alternatives
So clearly there is now many caveats with utilising any code released by Redhat that is not directly licensed by them to you. There is still the developer license available but if they can yank a fully working distribution mid-cycle they can change those terms at a moments notice.

In the future I will migrate over to Debian fully, but due to the sheer amount of time put into the Ansible automation I currently sport it is a long time before I will be able to make the switch. Debian is not only a strong community driven distribution, it is also not as susceptible to being overtaken like CentOS proved to be. There are other alternatives with similar community driven projects like [archlinux](https://archlinux.org/) and [voidlinux](https://voidlinux.org/) to name two. For servers some stability is required so the above might be fun to use on the desktop but not for hosting applications. My main line of thought is to keep away from any company owned distribution (like Ubuntu, Oracle Linux and SUSE).
