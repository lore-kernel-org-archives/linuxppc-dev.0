Message-Id: <383BA2FD.E894EC61@ict.ac.cn>
Date: Wed, 24 Nov 1999 16:34:05 +0800
From: LiuTao <tliu@ict.ac.cn>
Mime-Version: 1.0
To: Dan Malek <dmalek@jlc.net>
Cc: LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>,
        "linuxppc-embedded@lists.linuxppc.org"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: need suggestions
References: <3839F122.3BF6FEDF@ict.ac.cn> <383A0E2D.CFACF894@jlc.net> <383A0E2E.9A261E81@ict.ac.cn> <383A30B7.37700779@jlc.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi:

Dan Malek wrote:
> My approach is to actually port a Linux kernel to the 8xx board, which
I have a ADS8xx board and I downloaded kernel source mpc8xx-2.2.13.tgz
from ppc.kernel.org. Can you tell me how to port it to ADS8xx board and
make a bootrom of Linux?
I am a newbie, so please tell something in detail.
Thanks!

LiuTao

> is pretty easy these days for just the minimal network support, then
> slightly "customize" it (so it doesn't use _all_ of memory) and flash
> is using S-record download or BDM tools.  I then just use the Linux
> kernel with a TFTP application to do the job.  Just mmap() the unused
> memory for loading a new image, and modify the reboot to call a
> specific address rather than return to rom.
> 
>         -- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
