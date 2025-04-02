---
authors:
    - spixx
date: 2021-03-16
categories:
    - general
    - thoughts
    - opensource
    - archive
---

# So about that thing with CentOS 8 #
As many might have heard, Redhat (and do not argue that they had no sway in 
this) is to end the CentOS 8.X support during 2021. This comes as a small (and 
nasty) surprise since CentOS has always been a downstream rebrand and release
of Redhats RHEL. Instead we get CentOS 8 Stream which will be an upstream beta
of RHEL with rolling releases. Many bricks were shat when this news dropped. 

<!-- more -->

## So what? ##
Many built their applications upon the versioned releases, which did make them 
come to a grinding halt when suddenly the target OS had no versioning locks 
and thus became that much harder to support. Others had come to expect that 
CentOS releases would keep for eight years and be the bastion of the 
datacenter. Maybe the worst was for those who had started the sometimes complex
and cumbersome task of moving onto the already released Centos 8.1. 

## Others step forward ##
Luckily there were others who stepped forward; SUSE for instance and Oracle 
among others. Scrambling for the confused and scared masses who Redhat just
abandoned. Although Oracle is mentioned here more ironically than anything 
else. If the risk is vendor lock-in they should be feared since they are known
to be very aggressive on this front. Either way some good alternatives are 
available, such as Debian, Rocky Linux and Redhat RHEL (which released free 
licenses for developers).

## So? ##
Simply put, this is good. It is not nice and I really understand the anger from
those who had started to use the versioned CentOS 8. But it is good, mostly due 
to one very simple reason:

> Things are moving at an ever accelerating pace

Since I do a lot of lurking in the IRC channel it is quite obvious that people 
have a tendency to keep the status quo unless forced to change. Some ask for 
support on outdated or even unsupported versions of the operating system. Many 
do not even dare to upgrade their infrastructure because “it might break”. This
indicates a failure of the people not the product. If your application is 
written so that you have no other choice then utilize a plus four year old 
version of an operating system then your money might have been better spent 
elsewhere. I am not excusing what Redhat did here, they (or the CentOS board)
had made a promise to support l CentOS 8.X until end of 2029. My point here is
that we are now forced to a steady renewal of our baseline operating system. If
you have not had the foresight of having a testing environment now is a good 
time to set something up. CICD is not only for developers but for everyone and 
there are several good products out there that can assist in getting started 
with some type of automation. Proxmox VE for free virtualization (Debian), 
Ansible for configuration management and Jenkins for pipelines just to name a
few. There will be more guides on how to get started with automation and 
testing of infrastructure in the future. But for now we can just wait and see 
what happens.
