From: Michel Lanners <mlan@cpu.lu>
Message-Id: <200108290541.HAA29842@mcp.cpu.lu>
Subject: Re: Xvideo acceleration: GATOS for PPC?
To: michdaen@iiic.ethz.ch (Michel =?iso-8859-1?Q?D=E4nzer?=)
Date: Wed, 29 Aug 2001 7:41:23 METDST
Cc: debian-powerpc@lists.debian.org, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <3B8C2AC1.4563CF09@iiic.ethz.ch>; from "Michel =?iso-8859-1?Q?D=E4nzer?=" at Aug 29, 101 1:35 am
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Michel,

> Michel Dänzer wrote:
> > > Although I found no evidence documented evicende of this, I suppose this
> > > is because XFree (plain), although implementing Xvideo, doesn't use the
> > > hardware acceleration in the ATI chips, whereas the GATOS drivers do
> > > just that.
> >
> > Not quite. Plain XFree86 uses the frontend scaler, which also does the
> > colorspace conversion. The reason for the CPU load is that the data is
> > transferred to the card with regular memcpy. If the GATOS drivers use
> > (virtually) no CPU for the transfer, that hints at that they use bus
> > mastering for the transfer. Very interesting, I'll have to look at the code.
>
> False alarm, they also use memcpy. In fact, the code looks very similar to
> plain XFree86, so I'd be surprised if it makes any difference.

Did you look at the r128 driver only? My test showing the decrease in CPU load
was on a Rage Mobility-equipped Dell laptop (i.e Mach64-compatible using the ati
driver).

Anyway, Tonight I'll try the r128 on PPC and report back...

Cheers

Michel
--
.signature: no such file or directory

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
