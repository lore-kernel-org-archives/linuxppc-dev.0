Date: Fri, 16 May 2003 10:27:19 -0500 (CDT)
From: Bret Indrelee <Bret.Indrelee@qlogic.com>
Reply-To: Bret Indrelee <Bret.Indrelee@qlogic.com>
To: Steven Rothweiler <Stevenr@raritan.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Best Linux/PPC compiler ?
In-Reply-To: <159C486347C8D3119B1D005004A4694002069176@olive.raritan.com>
Message-ID: <Pine.LNX.4.44.0305161024550.3545-100000@spider.ancor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 16 May 2003, Steven Rothweiler wrote:
> What is the best Linux/PPC compiler?
>
> Specifically, we're using MPC8270.  We are coming from Linux/x86
> platform, where Intel has a nice compiler that blows the doors
> off of gcc, performance-wise.  I'm wondering if anyone knows if
> there have been any studies comparing various Linux/PPC compilers.
[ snip ]

I don't know if you can do the cross-compiles, but xlc for AIX is
the best PPC compiler I know of. You might try looking at SPEC,
see what compilers have been used for SPECmark for various PPC
systems.

-Bret

--
Bret Indrelee                 QLogic Corporation
Bret.Indrelee@qlogic.com      6321 Bury Drive, St 13, Eden Prairie, MN 55346


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
