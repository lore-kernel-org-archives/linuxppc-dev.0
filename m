From: phandel@cise.ufl.edu
Date: Thu, 18 Nov 1999 05:22:42 -0500 (EST)
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Extreme swapping / new location of Paul's kernels [was Re: Kernel
 debugging??]
In-Reply-To: <19991118110411.015070@mailhost.mipsys.com>
Message-ID: <Pine.LNX.4.10.9911180520580.616-100000@PetesBox.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 18 Nov 1999, Benjamin Herrenschmidt wrote:

> On Wed, Nov 17, 1999,  <phandel@cise.ufl.edu> wrote:
> 
> >I've noticed the same extreme swapping in 2.3.26, using SCSI disks
> >(PowerCenter Pro 210) and BootX.  Returning to my previous kernel, there
> >was no swapping. This was using BootX 1.2b1.
> 
> And I have absolutely no idea about what in BootX can cause this. Could
> you check if the amount of available RAM seen by the kenrel is correct ?

I'm having a hard time blaming BootX - top did reveal an incorrect amount
of memory (total/free/etc.) but I've heard that top is broken in the 2.3
series.  I'll grab Paul's new 2.3.28 rsync later tomorrow and look at the
memory.

The same version of BootX works perfectly with the 2.2 series.


Thanks,
Pete

-- 
Peter F. Handel          "[The anti-Christ] also forced everyone, small and
phandel@cise.ufl.edu      great ... to receive a mark [smart card?] on his
www.cise.ufl.edu/~phandel right hand or on his forehead, so that no one could
FAX: (561) 619-8051       buy or sell unless he had the mark"-Revelation13:16


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
