Message-ID: <3AE5E73E.76FAA847@iiic.ethz.ch>
Date: Tue, 24 Apr 2001 22:51:10 +0200
From: Michel =?iso-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
MIME-Version: 1.0
To: mlan@cpu.lu
Cc: geert@linux-m68k.org, ultrapenguin@netscape.net,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Rsync access through NAT?
References: <200104242000.WAA00723@piglet.grunz.lu>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Lanners wrote:

> >> > Yup, that seems to be the problem. rsync works again for me on
> >> > penguinppc. So I guess that some device close to penguinppc.org doesn't
> >> > support ECN.....
> >
> > Then why can I ping penguinppc.org without problems? Because my AXP
> > firewall still runs 2.2.x?
>
> Maybe because the NAT function on my Cisco 803 is to blame?

NAT is also a suspect of mine - it's the commonality between our cases.

> Cisco might 'accidentaly' support it in normal packet forwarding, but might
> not when doing NAT, since the IP header may need to be rewritten-- probably
> without the ECN bits.

I must admit I don't really know anything about ECN but that the name of the
/proc file is tcp_ecn, right? It kinda implies that ECN is only involved with
TCP, not ICMP or UDP or whatever. In particular, UDP worked fine (DNS lookups)
when TCP didn't.


--
Earthling Michel Dänzer (MrCooper)    \   Debian GNU/Linux (powerpc) developer
CS student, Free Software enthusiast   \        XFree86 and DRI project member

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
