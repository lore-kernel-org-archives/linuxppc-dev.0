Message-ID: <383A30B7.37700779@jlc.net>
Date: Tue, 23 Nov 1999 01:14:15 -0500
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: LiuTao <tliu@ict.ac.cn>
CC: linuxppc <linuxppc-dev@lists.linuxppc.org>
Subject: Re: need suggestions
References: <3839F122.3BF6FEDF@ict.ac.cn> <383A0E2D.CFACF894@jlc.net> <383A0E2E.9A261E81@ict.ac.cn>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


LiuTao wrote:


> .......... So I hope
> to find a TFTP source code and program a bootloader by myself.
> Of course, if anybody has a presented bootloader source code,
> that's great.

A couple of people from Motorola have indicated, for the past year
or so, an interest in providing a TFTP monitor for the FADS board.
When they have asked what to do, I said make sure it is GPL and send
it to me for posting on a server somewhere (like ppc.kernel.org).
I have never heard a reply.

I am sure you could put something together from some of the netboot
code that is around.

My approach is to actually port a Linux kernel to the 8xx board, which
is pretty easy these days for just the minimal network support, then
slightly "customize" it (so it doesn't use _all_ of memory) and flash
is using S-record download or BDM tools.  I then just use the Linux
kernel with a TFTP application to do the job.  Just mmap() the unused
memory for loading a new image, and modify the reboot to call a
specific address rather than return to rom.



	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
