Message-ID: <3C52ADC0.20409@pacbell.net>
Date: Sat, 26 Jan 2002 13:23:12 +0000
From: Armin <akuster@pacbell.net>
MIME-Version: 1.0
To: ChangYl Lee <bluecafe@sgi21.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Booting linux-2.4.18-pre7 with IBM405GP(rev E)
References: <002501c1a649$ef2b4ba0$74b0f8cb@bluecafe>
Content-Type: text/plain; charset=x-windows-949
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


ChangYl Lee wrote:

> Hi all..!
> I'm going to develop new board based on a IBM405GP(rev. E) processor and I cloned linux_2_4_devel and tested it.
>
> kernel version is 2.4.18-pre7 and default config is set to walnut_defconfig.
>
> Attempting to debug, I've found out my kernel is stopped or hung at real address 0.
> Before jumping address 0, it seems to be nice and I can see my debug character with serial console.
> but I can't see my debug character start of "start_here:" at arch/ppc/kernel/head_4xx.S
>
> I've read posted message titled "booting HardHat on IBM405GP" but still I can't understand.
> The output of the booting message looks like this:
> -----------------
> MON> go
> Linux porting start.... press any key..
>
> loaded at:     00250000 002E8238
> board data at: 002E5168 002E51A8
> relocated to:  002E5128 002E5168
> zimage at:     00255B30 002E4CCB
> avail ram:     002E9000 04000000
>
> Linux/PPC load: console=ttyS0,115200 root=/dev/ram rw debug ram=64m
> Uncompressing Linux...done.
> Now booting the kernel
> ----------------
>
> Any help is greatly appreciated.
>
> ------------------------------------------------------------
> Be happy..!
> ChangYl, Lee : bluecafe@sgi21.com
>
>
>
>

Chang,

First of all, what type of bootloader are you using and is it a walnut?
The memory locactions are not correct for a walnut.  The load addr
starts @ 500000 and uses treeboot.

I just tried it on my walnut and have no problems.

-armin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
