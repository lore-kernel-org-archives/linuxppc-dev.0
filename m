From: phandel@cise.ufl.edu
Date: Wed, 17 Nov 1999 19:35:44 -0500 (EST)
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Martin Costabel <costabel@wanadoo.fr>,
        Dev-Linux <linuxppc-dev@lists.linuxppc.org>
Subject: Extreme swapping / new location of Paul's kernels [was Re: Kernel
 debugging??]
In-Reply-To: <Pine.LNX.4.05.9911172207200.25661-100000@callisto.of.borg>
Message-ID: <Pine.LNX.4.10.9911171932360.868-100000@PetesBox.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 17 Nov 1999, Geert Uytterhoeven wrote:

> On Tue, 16 Nov 1999, Martin Costabel wrote:
> > Just for information: Paul M's 2.3.27 rsync kernel compiles and runs
> > just fine on this Pmac 6400. The machine swaps like crazy and is
> > therefore rather slow, but I am not sure if this is the kernel's fault.

I've noticed the same extreme swapping in 2.3.26, using SCSI disks
(PowerCenter Pro 210) and BootX.  Returning to my previous kernel, there
was no swapping. This was using BootX 1.2b1.

> Are you sure about the version? I just checked out this tree, and it's 2.3.22,
> according to the Makefile. Perhaps I made a mistake? This is the first time I
> used rsync (`rsync -auvz samba.anu.edu.au::linux-pmac-devel .').

rsync -auvz linuxcare.com.au::linux-pmac-devel /usr/src/linux-2.3.devel
(from Ben's post a few days ago)


Thanks,
Peter

-- 
Peter F. Handel          "[The anti-Christ] also forced everyone, small and
phandel@cise.ufl.edu      great ... to receive a mark [smart card?] on his
www.cise.ufl.edu/~phandel right hand or on his forehead, so that no one could
FAX: (561) 619-8051       buy or sell unless he had the mark"-Revelation13:16


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
