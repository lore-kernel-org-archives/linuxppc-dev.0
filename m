From: Alan Mimms <alan@packetengines.com>
To: LiuTao <tliu@ict.ac.cn>,
        "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: What does KERNELBASE mean?
Date: Tue, 4 Jan 2000 21:11:15 -0800
Content-Type: text/plain
References: <3872CF70.45BCE11C@ict.ac.cn>
In-Reply-To: <3872CF70.45BCE11C@ict.ac.cn>
MIME-Version: 1.0
Message-Id: <00010421122803.00773@alan.corp.packetengines.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


KERNELBASE is the virtual address the physical RAM is mapped to.

On most kernels on PowerPC this is 0xC0000000.  If you subtract KERNELBASE from
a virtual address, you get its physical address in RAM, since PowerPC platforms
more or less universally define that RAM starts at 0x00000000.  Hence the name
TOPHYS.

a

On Tue, 04 Jan
2000, LiuTao wrote: > Hi:
> 
> In linux/arch/ppc/kernel/head.S, what does KERNELBASE mean?
> What does the following mean?
> ".long	TOPHYS(__start),0,0"
> 
> Thanks.
> 
> LiuTao
-- 
Alan Mimms     Packet Engines, Inc.     Spokane, Washington [99214-0497]
  USA, Earth, Sol, Milky Way, The Local Group, Virgo Supercluster, U0
Despite the cost of living, have you noticed how popular it remains?
  -- Steven Wright?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
