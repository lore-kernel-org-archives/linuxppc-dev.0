Message-ID: <3B8D0349.58D1B1E7@iiic.ethz.ch>
Date: Wed, 29 Aug 2001 16:59:22 +0200
From: Michel =?iso-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
MIME-Version: 1.0
To: Michel Lanners <mlan@cpu.lu>
Cc: debian-powerpc@lists.debian.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: Xvideo acceleration: GATOS for PPC?
References: <200108290541.HAA29842@mcp.cpu.lu>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Lanners wrote:

> > Michel Dänzer wrote:
> > > > Although I found no evidence documented evicende of this, I suppose
> > > > this is because XFree (plain), although implementing Xvideo, doesn't
> > > > use the hardware acceleration in the ATI chips, whereas the GATOS
> > > > drivers do just that.
> > >
> > > Not quite. Plain XFree86 uses the frontend scaler, which also does the
> > > colorspace conversion. The reason for the CPU load is that the data is
> > > transferred to the card with regular memcpy. If the GATOS drivers use
> > > (virtually) no CPU for the transfer, that hints at that they use bus
> > > mastering for the transfer. Very interesting, I'll have to look at the
> > > code.
> >
> > False alarm, they also use memcpy. In fact, the code looks very similar to
> > plain XFree86, so I'd be surprised if it makes any difference.
>
> Did you look at the r128 driver only? My test showing the decrease in CPU
> load was on a Rage Mobility-equipped Dell laptop (i.e Mach64-compatible
> using the ati driver).

Nope, I looked at the mach64 code as well. Looks like slightly modified r128
code. The only real difference seems to be that GATOS supports additional
video chips, but that doesn't apply to us.


--
Earthling Michel Dänzer (MrCooper)    \   Debian GNU/Linux (powerpc) developer
CS student, Free Software enthusiast   \        XFree86 and DRI project member

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
