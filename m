Message-ID: <3FCB4EDA.5000909@g-house.de>
Date: Mon, 01 Dec 2003 15:23:22 +0100
From: Christian Kujau <evil@g-house.de>
MIME-Version: 1.0
To: Remco Post <r.post@sara.nl>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.6 PReP issues, still freezing
References: <3FC9EEC6.8040507@g-house.de> <20031201121119.768fb4c1.r.post@sara.nl>
In-Reply-To: <20031201121119.768fb4c1.r.post@sara.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Remco Post wrote:
> I stopped complaining a while back (2.5.60 something) since I got absolutely

did you get any further?
i saw one of your posts:
http://www.cs.helsinki.fi/linux/linux-kernel/2002-38/0289.html

yes, the "not-compiling" issues during 2.5.3x. 2.5.38 is only compiling
a "vmlinux.gz", but no zImage.prep here. and this vmlinux.gz is
worthless. do you mind sending in your fix?

> no response. I'm one of the lucky (?) few who have a motorola powerstack
> (II) mobo.

root@sheep:~# cat /proc/cpuinfo
processor       : 0
cpu             : 604r
clock           : ???
revision        : 49.2 (pvr 0009 3102)
bogomips        : 299.00
machine         : PReP Utah (Powerstack II Pro4000)
l2 cache        : 512KiB, parity disabled SRAM:synchronous, pipelined,
no parity


....from ebay :-)


Christian.
--
BOFH excuse #375:

Root name servers corrupted.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
