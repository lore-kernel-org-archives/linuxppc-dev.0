Message-ID: <38349F1A.8AECF96F@wanadoo.fr>
Date: Fri, 19 Nov 1999 01:51:38 +0100
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>
CC: phandel@cise.ufl.edu, linuxppc-dev@lists.linuxppc.org
Subject: Re: Extreme swapping / new location of Paul's kernels [was Re: Kernel
 debugging??]
References: <19991118110411.015070@mailhost.mipsys.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:
> 
> On Wed, Nov 17, 1999,  <phandel@cise.ufl.edu> wrote:
> 
> >I've noticed the same extreme swapping in 2.3.26, using SCSI disks
> >(PowerCenter Pro 210) and BootX.  Returning to my previous kernel, there
> >was no swapping. This was using BootX 1.2b1.
> 
> And I have absolutely no idea about what in BootX can cause this. Could
> you check if the amount of available RAM seen by the kenrel is correct ?

Comparing boot messages from booting with "good" and "bad" versions of
BootX, I saw that the amount of RAM is OK in both cases, but then I
found one quite incredible thing, and this is essentially the only
difference in the boot messages. Booting with BootX version <= 1.1.3 and
any kernel, I get as usual

   kernel: Calibrating delay loop... 133.12 BogoMIPS 

Booting with BootX-1.2b2, I get with the same kernels

   kernel: Calibrating delay loop... 11.39 BogoMIPS

This is repeatable, but for me quite incomprehensible.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
