Date: Mon, 1 Dec 2003 15:52:01 +0100
From: Remco Post <r.post@sara.nl>
To: Christian Kujau <evil@g-house.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.6 PReP issues, still freezing
Message-Id: <20031201155201.4c5c7996.r.post@sara.nl>
In-Reply-To: <3FCB4EDA.5000909@g-house.de>
References: <3FC9EEC6.8040507@g-house.de>
	<20031201121119.768fb4c1.r.post@sara.nl>
	<3FCB4EDA.5000909@g-house.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 01 Dec 2003 15:23:22 +0100
Christian Kujau <evil@g-house.de> wrote:

>
> Remco Post wrote:
> > I stopped complaining a while back (2.5.60 something) since I got
> > absolutely
>
> did you get any further?
> i saw one of your posts:
> http://www.cs.helsinki.fi/linux/linux-kernel/2002-38/0289.html
>
> yes, the "not-compiling" issues during 2.5.3x. 2.5.38 is only compiling
> a "vmlinux.gz", but no zImage.prep here. and this vmlinux.gz is
> worthless. do you mind sending in your fix?
>

I didn't fix a thing. At least, not that I recall. The later kernels
2.5.5something and up compiled but crashed as soon as there was any status
change on the utp, disconnecting the cable would crash the kernel. Didn't
look at that for a long time (months)....

> > no response. I'm one of the lucky (?) few who have a motorola powerstack
> > (II) mobo.
>
> root@sheep:~# cat /proc/cpuinfo
> processor       : 0
> cpu             : 604r
> clock           : ???
> revision        : 49.2 (pvr 0009 3102)
> bogomips        : 299.00
> machine         : PReP Utah (Powerstack II Pro4000)
> l2 cache        : 512KiB, parity disabled SRAM:synchronous, pipelined,
> no parity
>
>
> ....from ebay :-)
>
>
> Christian.
> --
> BOFH excuse #375:
>
> Root name servers corrupted.
>
>
>


--
Met vriendelijke groeten,

Remco Post

SARA - Reken- en Netwerkdiensten                      http://www.sara.nl
High Performance Computing  Tel. +31 20 592 8008    Fax. +31 20 668 3167

"I really didn't foresee the Internet. But then, neither did the computer
industry. Not that that tells us very much of course - the computer industry
didn't even foresee that the century was going to end." -- Douglas Adams

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
