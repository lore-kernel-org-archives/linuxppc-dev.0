Message-Id: <200010160409.FAA04918@cthulhu.dircon.co.uk>
Subject: Re: Bummer, can't open /dev/tty2
In-Reply-To: <971667729.39ea7911988cb@www.suwon.ac.kr> from "mac21c@mail.suwon.ac.kr"
 at "Oct 16, 2000 12:42:09 pm"
To: mac21c@mail.suwon.ac.kr
Date: Mon, 16 Oct 2000 05:09:54 +0100 (GMT/BST)
CC: linuxppc-embedded@lists.linuxppc.org
From: Digby Tarvin <digbyt@acm.org>
Reply-To: digbyt@acm.org (Digby Tarvin)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> When i boot, i get this messag.
> I write the initab file and list of /dev/tty?.
>
> This problum hard on me for a week.
>
> please help me...
>
> Is this problum caused the busybox or kernel ??
>
> maybe busybox....??
>
Is your NFS host a Linux box?

I had a similar problem when I first tried using a BSD system
to host the root file system, because there was an incompatibility
in the device special files. Consequently when the kernel mounted
it, it got the wrong major/minor device number from the inode
and couldn't talk to the tty.

Regards,
DigbyT
--
Digby R. S. Tarvin                                              digbyt@acm.org
http://www.cthulhu.dircon.co.uk

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
