Date: Sat, 2 Dec 2000 19:44:40 -0500
From: Dan Hopper <eusdbho@rtp.ericsson.se>
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: trouble with FEC on MPC860T - FEC_INTERRUPT not going off?
Message-ID: <20001202194440.A9761@slug.rtp.ericsson.se>
References: <200012020923.eB29NoF07306@denx.local.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200012020923.eB29NoF07306@denx.local.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk <wd@denx.de> remarked:
> in message <20001201223622.A28837@slug.rtp.ericsson.se> you wrote:
> >
> > FEC, and am now working on the kernel.  At the moment, I'm using the
> > 2.4-2000-11-11 kernel from ftp.denx.de as a baseline, since it
>
> This version of the kernel is derived from 2.4.0-test5 from July, 26.

OK.  Is there a newer one that's also friendly to 860Ts?  Some
others appeared somewhat different configuration-wise.  What base do
you use?

> I have run into the same problem, and my suggestion  is  to  try  the
> version  of fec.c I'll attach below (I've sent this to Dan Malek some
> days ago, but haven't heard anything since).

I did, and it seems to work great.  It negotiated a 100Mbps
half-duplex after detecting the PHYs, and took off from there with
NFS.  I did need to hook up the interrupt line from the 972, as you
indicated.

Next week, I guess I'll be doing a CVS merge from your latest
ppcboot tree and see if I can get that FEC code to play.

Thanks for your help!
Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
