Date: Mon, 25 Oct 1999 01:00:18 -0400 (EDT)
From: "Mark S. Mathews" <mark@absoval.com>
To: Dan Malek <dan@netx4.com>
cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: MPC8xx updates to 2.2.13
In-Reply-To: <3810F8F6.B831114B@netx4.com>
Message-ID: <Pine.LNX.3.96.991025005407.16660D-100000@tristar.cc.absoval.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hey Dan,

We just got done getting the 2.2.13 running on the RPX-lite.  We had to
add CONFIG_ENET_SCC2 to its config to make it work.  Thanks for the
update!

BTW: have you compiled any of these with CONFIG_MODULES turned on?  We've
tried with a couple of different kernels and generally get syntax errors
from ppc_ksyms.c and, after fixing those, we get a bunch of unresolved
symbols from kernel.o .  We didn't dig very deep on this, we were just
curious if it would work...apparently not. ;-)

I'm wondering if anyone else has played with this?

Oh well, we'll just go back to a static kernel and work from there, no big
deal.

Thanks Again,
-Mark

On Fri, 22 Oct 1999, Dan Malek wrote:

> 
> I just put a tar image of 2.2.13 with the 8xx updates on
> ppc.kernel.org.  I needed it for a couple of real applications....
> 
> It has a few things in it that I have yet to check into the 2.3.xx
> baseline.  In particular there are a couple of 10/100 Ethernet
> PHYs I want to ensure work properly.  There are also CPM port
> configurations I want to complete.
> 
> I tested it on the MBX, BrightStar Engineering BSE-IP, and the
> Embedded Planet RPX-CLLF.  If you are using the CLLF, there is
> some additional information about booting over the 10/100 Ethernet
> on the FEC that may be helpful.  Ask and I will post that in
> a separate message so it doesn't get lost here.
> 
> 
> 
> 	-- Dan
> 


Mark S. Mathews

AbsoluteValue Software     Web:    http://www.absoval.com
P.O. Box 941149            e-mail: mark@absoval.com
Maitland, FL 32794-1149    Phone:  407.644.8582
USA                        Fax:    407.539.1294


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
