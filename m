Date: Tue, 24 Apr 2001 09:48:37 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ethan Benson <erbenson@alaska.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Rsync access through NAT?
In-Reply-To: <20010423231425.C8585@plato.local.lan>
Message-ID: <Pine.LNX.4.05.10104240948110.22858-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 23 Apr 2001, Ethan Benson wrote:
> On Tue, Apr 24, 2001 at 07:53:38AM +0200, Michel Lanners wrote:
> > I have ECN compiled in all my 2.4 kernels. They are building right now
> > without ECN.... We'll see.
> >
> > <a compile & reboot later>
>
> there is a sysctl variable that disables this at runtime you know ;-)
> i don't remember where it is offhand, sysctl -a | grep ecn or find
> /proc -name '*ecn*' -print should find it.
>
> > Yup, that seems to be the problem. rsync works again for me on
> > penguinppc. So I guess that some device close to penguinppc.org doesn't
> > support ECN.....
>
> probably turning on ecn is more trouble then its worth right now,
> unfortuanatly...

| tux$ cat /proc/sys/net/ipv4/tcp_ecn
| 1
| tux$

I have it enabled on all my machines running 2.4.x. So far no problems.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
