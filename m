Mime-Version: 1.0
Message-Id: <v04220802b5f9f91c55cc@[10.0.0.42]>
In-Reply-To: <14803.48934.472348.909959@esb.bbn.com>
References: <14803.24024.683420.911271@esb.bbn.com>
 <20000928233119.B334@olis.north.de>
 <14803.48934.472348.909959@esb.bbn.com>
Date: Fri, 29 Sep 2000 00:51:41 -0700
To: rshapiro@bbn.com, cl.en@gmx.net
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: beige g3 rage II xf4.0.1 and miBoot
Cc: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 5:59 PM -0400 9/28/00, R Shapiro wrote:

>  > boot-device = ata0/ata-disk@0:x (x=root in hex,)
>
>OF is "unable to open" any variant of this I could come up with.
>
>Thanks anyway, but I guess this machine is stuck with BootX.

It's been a while, but I did have quik based booting working on a
beige G3 at one time.  And I think several others did too.

The issue is that there are nasty bugs in the beige G3's firmware
which prevent it from reliably accessing hard drives, or accessing
them at all.

I don't remember the exact details, but the fix involved using the
"System Disk" utility from MacOS X server (and/or its predecessors)
to get OF patches installed into NVRAM.  These patches fix OF so that
it can reliably access disks to load a first stage booter.  I think
all I had to do was open System Disk, enter its raw OF variables
window, configure boot-device etc. for quik, and exit System Disk.

Note that the current System Disk version included with MacOS X has
eliminated the OF settings window; it now attempts to be completely
point&click, so it's less useful in that regard.  But you might be
able to use it in conjunction with the old Boot Variables utility to
get the job done.

   Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
