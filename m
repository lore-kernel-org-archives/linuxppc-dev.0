Message-ID: <FD52892BD296D71183B400065BFCB69009982F30@il02exm12>
From: Hawkins Jeffrey-CJH016 <Jeffrey.F.Hawkins@motorola.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: RE: Motorola MCP820 Board - 7410 / Harrier ASIC based - System We
	irdn ess
Date: Tue, 11 May 2004 07:26:18 -0500
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> -----Original Message-----
> From: Segher Boessenkool [mailto:segher@kernel.crashing.org]
> Sent: Monday, May 10, 2004 9:09 PM
> To: Hawkins Jeffrey-CJH016
> Cc: linuxppc-dev@lists.linuxppc.org
> Subject: Re: Motorola MCP820 Board - 7410 / Harrier ASIC
> based - System
> Weirdn ess
>
>
> > I am evaluating a Motorola Computer Group MCP820 Board.  It is 7410
> > Based, running at 500 Mhz, 256MB RAM, 2MB L2 Cache.  Testing using
> > 2.4.18 and 2.4.20 Kernels utilizing LMBENCH.  I am seeing
> some strange
> > behavior with the Local Communications Latency Tests.
> Comparing to a
> > similarly configured 750 based System, the UDP and TCP
> operations have
> > a latency that is 2+ times worse than the lesser performing System
> > (MCP750 @ 366 Mhz).
>
> Did you use the same kernel on both systems?  If not, check if both
> are either UP or SMP...
>

Same exact Kernel....

>
> Segher
>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
