From: "Anil Giri" <anil@india.tejasnetworks.com>
To: "bhupinder sahran" <bhup_sah@yahoo.com>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: RE: problem in booting kernel
Date: Mon, 12 May 2003 14:16:56 +0530
Message-ID: <NFBBIIPBPPALGBNPGLOBGEEPJBAB.anil@india.tejasnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20030507155215.73920.qmail@web41504.mail.yahoo.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
    Kernel Booting hangs just after entering start_kernel function.
Even I can't see the printk fuction for printing linux banner getting
executed.
I have compiled linux-2.4.18 for MPC860.

-Anil


-----Original Message-----
From: bhupinder sahran [mailto:bhup_sah@yahoo.com]
Sent: Wednesday, May 07, 2003 9:22 PM
To: Anil Giri; linuxppc-embedded@lists.linuxppc.org
Subject: Re: problem in booting kernel

Hi
>From the inuts u have given it is very tough to find
out. But let me ask u some of the questions.

1. One possiblity is that ur serial port is not
configured properly & u are not seeing any message
from the console port.

2. IF u are having the JTAG debugger find out the
value in Program conuter & see where it matches in
System.map.

So tell me the PC value then it might be possible to
catch the problem

Thanx
Bhupi
Linux+Hypertransport -->Silicon
www.gdatech.com
Good after beer ---Linux


--- Anil Giri <anil@india.tejasnetworks.com> wrote:
>
> Hi,
>
>
>    I m trying to boot kernel for linux-2.4.18
> (MPC860 processor), but it
>
>
> hangs after "Now booting the kernel"  message. What
> could be the reason???
>
>
> also on debugging i found negative value for
> register R3 instead of ptr to
>
>
> board info data. Other register settings were ok.
>
>
> Any imputs...
>
>
>
>
> -Anil
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
