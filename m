Date: Mon, 26 Feb 2001 10:13:29 +0000
Subject: Re: XFree86 4.0.xx + Display corruption + ati + mach64  
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Ramprasad Rao <ramp@oddjob.uchicago.edu>,
	linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010226101327.37354DB9CA@atlas.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> display. There are small underscore characters that scroll across my
> display from top to bottom approximately 1/2 inch from the left edge of
> screen. This corruption mainly occurs at color depths of 15/16 and above

[snip]

> It is quite possible that this is not a PPC specific problem but I was
> wondering if anyone on this list has had this problem.

I've always had the same effect (g3/beige, atyfb, mach 64 3DU_pro, 0x4750,
rev 0x5c).  I was hoping XF4 might fix it... ah well.

FWIW I never got any answer to a post ages ago about this.

This has occurred on all kernels I've tried 2.2.6 ... 2.4.2 and
{XF3.3.5/3.3.6, Xpmac rev6 ... rev 11) - so I guess, by process of
elimination with the other posting, it's in atyfb - or the hardware...

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
