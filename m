Message-ID: <37DEC8E8.33EB2D66@tiac.net>
Date: Tue, 14 Sep 1999 18:15:04 -0400
From: Timothy Wall <twall@tiac.net>
MIME-Version: 1.0
To: Hollis R Blanchard <hollis+@andrew.cmu.edu>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: missing space on ext2fs scsi drive
References: <Pine.LNX.3.96L.990914155416.2958E-100000@unix47.andrew.cmu.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm running a 604e (PowerCenterPro 180) with 128 Mb RAM, 128Mb swap.
The root partition is on either a 4Gb or 8Gb disk (I think it's on the 8Gb).
I've run mke2fs sans arguments w/o problems, but on smaller disks (I've got an 8,
a 4, a 2, and a 0.7Gb).

Hollis R Blanchard wrote:

>
> Yeah. The problem (I hear) is that just running mke2fs on a large hard drive
> from the installer will lock up machines will less than very large amounts of
> RAM. Although now that I think about it, if you're able to run mke2fs by hand
> and it works fine, maybe there really isn't a problem. What are your system
> specs, and can you run mke2fs sans arguments without problem?
>
> -Hollis


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
